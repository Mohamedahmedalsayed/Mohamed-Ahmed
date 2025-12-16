function varargout = non_linear(varargin)
% NON_LINEAR MATLAB code for non_linear.fig
%      NON_LINEAR, by itself, creates a new NON_LINEAR or raises the existing
%      singleton*.
%
%      H = NON_LINEAR returns the handle to a new NON_LINEAR or the handle to
%      the existing singleton*.
%
%      NON_LINEAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NON_LINEAR.M with the given input arguments.
%
%      NON_LINEAR('Property','Value',...) creates a new NON_LINEAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before non_linear_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to non_linear_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help non_linear

% Last Modified by GUIDE v2.5 29-Dec-2021 13:49:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @non_linear_OpeningFcn, ...
                   'gui_OutputFcn',  @non_linear_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before non_linear is made visible.
function non_linear_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to non_linear (see VARARGIN)

% Choose default command line output for non_linear
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes non_linear wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = non_linear_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
handles.output = hObject;
[rawname,rawpath]=uigetfile(('*.tif'),('*.jpg'),'Select Image Data');
fullname=[rawpath rawname];
myImage= imread(fullname);
imshow(myImage , 'parent' , handles.axes2);
setappdata(0,'myImage_value',myImage);
guidata(hObject, handles);



function Mask_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Mask_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mask_edit as text
%        str2double(get(hObject,'String')) returns contents of Mask_edit as a double


% --- Executes during object creation, after setting all properties.
function Mask_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mask_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
hightFiltter = str2num(get(handles.edit8,'String'));
widthFilter = str2num(get(handles.edit9,'String'));
A=getappdata(0,'myImage_value');
B = ordfilt2(A,9,ones(hightFiltter,widthFilter));
axes(handles.axes3);
imshow(B)
setappdata(0,'filename',B);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
hightFiltter = str2num(get(handles.edit8,'String'));
widthFilter = str2num(get(handles.edit9,'String'));
A=getappdata(0,'myImage_value');
A = im2gray(A);
B = ordfilt2(A,hightFiltter,true(widthFilter));
axes(handles.axes3);
imshow(B)
setappdata(0,'filename',B);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
A =getappdata(0,'myImage_value');
hightFiltter = str2num(get(handles.edit8,'String'));
widthFilter = str2num(get(handles.edit9,'String'));
B=medfilt2(A,[hightFiltter widthFilter]);
axes(handles.axes3);
imshow(B)
setappdata(0,'filename',B);

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
hightFiltter = str2num(get(handles.edit8,'String'));
widthFilter = str2num(get(handles.edit9,'String'));
img =getappdata(0,'myImage_value');
[h, w] =size(img);
NImg=zeros(h,w);
FImg=zeros(h+2,w+2);
for i=1:h
    for j=1:w
        FImg(i+1,j+1)=img(i,j);
    end
end

for i=1:h
    for j=1:w
        maxx = max(max(FImg(i:i+hightFiltter-1,j:j+widthFilter-1)));
        minn = min(min(FImg(i:i+hightFiltter-1,j:j+widthFilter-1)));
        NImg(i,j)= (maxx+minn)/2;
    
    end   

end
NImg = uint8(NImg);
axes(handles.axes3);
imshow(NImg);

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
hightFiltter = str2num(get(handles.edit8,'String'));
widthFilter = str2num(get(handles.edit9,'String'));
A=getappdata(0,'myImage_value');
A=im2double(im2gray(A));
paddedimage2=padarray(A,[1,1]);
[r,c]=size(paddedimage2);
 
for i=2:r-1
    for j=2:c-1
        out=[paddedimage2(i-1,j-1),paddedimage2(i-1,j),paddedimage2(i-1,j+1),paddedimage2(i,j-1),paddedimage2(i,j),paddedimage2(i,j+1),paddedimage2(i-1,j),paddedimage2(i+1,j-1),paddedimage2(i+1,j),paddedimage2(i+1,j+1)];
       a=max(out);
       b=min(out);
        outimage(i,j)=(a+b)/2;
    end
end
u=outimage;
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);


% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
close
open('Start_figure.fig')
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
