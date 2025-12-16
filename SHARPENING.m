function varargout = SHARPENING(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SHARPENING_OpeningFcn, ...
                   'gui_OutputFcn',  @SHARPENING_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function SHARPENING_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = SHARPENING_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function unsharp_Callback(hObject, eventdata, handles)
image=handles.a;
I_sharpen=imsharpen(image,'amount',3);
I_sharpen = im2uint8(I_sharpen);

axes(handles.axes2);
imshow(I_sharpen);

function laplacian_Callback(hObject, eventdata, handles)
image=handles.a;
% Defined the laplacian filter.
Lap=[0 1 0; 1 -4 1; 0 1 0];
  
a1=conv2(image,Lap,'same');
  
a2=uint8(a1);
  
% Display the sharpened image.
axes(handles.axes2);
imshow(abs(image-a2),[]);  

function Browse_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename=strcat(pathname,filename);
       a=imread(filename);
       axes(handles.axes1);
       imshow(a);
       handles.a=a;
       guidata(hObject, handles);
    end

function Back_Callback(hObject, eventdata, handles)
FirstTap
closereq();


function edgedetection_Callback(hObject, eventdata, handles)
I=double(handles.a);
option=getappdata(0,'edgeOption');
In=I;

if option==1 %vertical
    mask=[1, 0, -1;1, 0, -1;1, 0, -1];

    %Rotate image by 180 degree first flip up to down then left to right
    mask=flipud(mask); 
    mask=fliplr(mask);
    for i=2:size(I, 1)-1
        for j=2:size(I, 2)-1

            %multiplying mask value with the corresponding image pixel value
            neighbour_matrix=mask.*In(i-1:i+1, j-1:j+1); 
            avg_value=sum(neighbour_matrix(:));
            I(i, j)=avg_value;
        end
    end
end

if option==2 %horizontal
    mask=[1, 1, 1;0, 0, 0;-1, -1, -1];
    mask=flipud(mask);
    mask=fliplr(mask);
    for i=2:size(I, 1)-1
        for j=2:size(I, 2)-1
            neighbour_matrix=mask.*In(i-1:i+1, j-1:j+1);
            avg_value=sum(neighbour_matrix(:));
            I(i, j)=avg_value;
        end
    end
end

if option==3 %diagonalleft
    mask=[0, -1, -1;1, 0, -1;1, 1, 0];
    mask=flipud(mask);
    mask=fliplr(mask);

    for i=2:size(I, 1)-1
        for j=2:size(I, 2)-1
            neighbour_matrix=mask.*In(i-1:i+1, j-1:j+1);
            avg_value=sum(neighbour_matrix(:));
            I(i, j)=avg_value;
        end
    end
end

if option==4 %diagonalright
    mask=[1, 1, 1;0, 0, 0;-1, -1, -1];
    mask=flipud(mask);
    mask=fliplr(mask);

    for i=2:size(I, 1)-1
        for j=2:size(I, 2)-1
            neighbour_matrix=mask.*In(i-1:i+1, j-1:j+1);
            avg_value=sum(neighbour_matrix(:));
            I(i, j)=avg_value;
        end
    end
end


axes(handles.axes2);
imshow(uint8(I));


function edgemenu_Callback(hObject, eventdata, handles)
a=get(handles.edgemenu,'value');

switch a 
    case 1
        setappdata(0,'edgeOption',a);
    case 2 
        setappdata(0,'edgeOption',a);
    case 3 
        setappdata(0,'edgeOption',a);
    case 4 
        setappdata(0,'edgeOption',a);
end


function edgemenu_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
