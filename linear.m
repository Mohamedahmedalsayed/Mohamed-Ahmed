function varargout = linear(varargin)
% LINEAR MATLAB code for linear.fig
%      LINEAR, by itself, creates a new LINEAR or raises the existing
%      singleton*.
%
%      H = LINEAR returns the handle to a new LINEAR or the handle to
%      the existing singleton*.
%
%      LINEAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINEAR.M with the given input arguments.
%
%      LINEAR('Property','Value',...) creates a new LINEAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before linear_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to linear_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help linear

% Last Modified by GUIDE v2.5 30-Dec-2021 19:05:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @linear_OpeningFcn, ...
                   'gui_OutputFcn',  @linear_OutputFcn, ...
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


% --- Executes just before linear is made visible.
function linear_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to linear (see VARARGIN)

% Choose default command line output for linear
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes linear wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = linear_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
handles.output = hObject;
[rawname,rawpath]=uigetfile(('*.jpg'),'Select Image Data');
fullname=[rawpath rawname];
myImage= imread(fullname);
imshow(myImage ,'parent',handles.axes1)
setappdata(0,'myImage',myImage);
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
sigma = str2num(get(handles.sigma_edt_txt,'String'));
Iblur = imgaussfilt(img,sigma);
axes(handles.axes3);
imshow(Iblur);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in point_sharp_btn.
function point_sharp_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=point_sharpening(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);


% --- Executes on button press in Vertical_detec_btn.
function Vertical_detec_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_detectionV(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);
% hObject    handle to Vertical_detec_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mean_blur_btn.
function mean_blur_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
H = fspecial('motion',20,45);
MotionBlur = imfilter(img,H,'replicate');
axes(handles.axes3);
imshow(MotionBlur);
setappdata(0,'filename',MotionBlur);

% hObject    handle to mean_blur_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
close 
open('Start_figure.fig')
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to sigma_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of sigma_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function sigma_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Horiz_sharp_btn.
function Horiz_sharp_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_sharpeningH(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);


% --- Executes on button press in vertic_sharp_btn.
function vertic_sharp_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_sharpeningV(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);


% --- Executes on button press in diag_left_sharp.
function diag_left_sharp_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_sharpeningDL(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);


% --- Executes on button press in diag_right_sharp_btn.
function diag_right_sharp_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_sharpeningDR(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);



% --- Executes on button press in point_detec_btn.
function point_detec_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=point_detection(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);
% hObject    handle to point_detec_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in horiz_detec_btn.
function horiz_detec_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_detectionH(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);
% hObject    handle to horiz_detec_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in diag_right_detect_btn.
function diag_right_detect_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_detectionDR(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);
% hObject    handle to diag_right_detect_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in diag_left_detect_btn.
function diag_left_detect_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
u=line_detectionDL(img);
axes(handles.axes3);
imshow(u);
setappdata(0,'filename',u);
% hObject    handle to diag_left_detect_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in weight_blur_btn.
function weight_blur_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
H = fspecial('disk',10);
blurred = imfilter(img,H,'replicate'); 
axes(handles.axes3);
imshow(blurred);
setappdata(0,'filename',blurred);
% hObject    handle to weight_blur_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
