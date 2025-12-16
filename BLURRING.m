function varargout = BLURRING(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BLURRING_OpeningFcn, ...
                   'gui_OutputFcn',  @BLURRING_OutputFcn, ...
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

function BLURRING_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = BLURRING_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function Weighted_Callback(hObject, eventdata, handles)
image=handles.a;

Noi_img = imnoise(image,'salt & pepper', 0.02);
axes(handles.axes2);
imshow(Noi_img);

mask =[1 2 1 ; 2 4 2 ;1 2 1]* (1/16) ;
S = imfilter(Noi_img,mask);
S = im2uint8(S);

axes(handles.axes3);
imshow(S);

function Averaging_Callback(hObject, eventdata, handles)
image=handles.a;

Noi_img = imnoise(image,'salt & pepper', 0.02);
axes(handles.axes2);
imshow(Noi_img);

mask = fspecial('average',[3 3]);
S = imfilter(Noi_img,mask);
S = im2uint8(S);

axes(handles.axes3);
imshow(S);

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
