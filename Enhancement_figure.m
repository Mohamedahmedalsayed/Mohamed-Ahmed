function varargout = Enhancement_figure(varargin)
% ENHANCEMENT_FIGURE MATLAB code for Enhancement_figure.fig
%      ENHANCEMENT_FIGURE, by itself, creates a new ENHANCEMENT_FIGURE or raises the existing
%      singleton*.
%
%      H = ENHANCEMENT_FIGURE returns the handle to a new ENHANCEMENT_FIGURE or the handle to
%      the existing singleton*.
%
%      ENHANCEMENT_FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENHANCEMENT_FIGURE.M with the given input arguments.
%
%      ENHANCEMENT_FIGURE('Property','Value',...) creates a new ENHANCEMENT_FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Enhancement_figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Enhancement_figure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Enhancement_figure

% Last Modified by GUIDE v2.5 23-Dec-2021 04:53:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Enhancement_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @Enhancement_figure_OutputFcn, ...
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


% --- Executes just before Enhancement_figure is made visible.
function Enhancement_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Enhancement_figure (see VARARGIN)

% Choose default command line output for Enhancement_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Enhancement_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Enhancement_figure_OutputFcn(hObject, eventdata, handles) 
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
axes(handles.axes3);
imagesc(myImage);
setappdata(0,'myImage_value',myImage);
guidata(hObject, handles);


% --- Executes on button press in Histogram_tag.
function Histogram_tag_Callback(hObject, eventdata, handles)
Rgb_img = getappdata(0,'myImage_value');
[H, W] = size(Rgb_img);
    count = zeros(256, 1);
    
    for i=1:H
        for j=1:W
            count(Rgb_img(i, j) + 1) = count(Rgb_img(i, j) + 1) + 1;
        end
    end
axes(handles.axes4);
imagesc(count);
axes(handles.axes5);
imagesc(bar(count));


 
% hObject    handle to Brightness_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function operator_tag_Callback(hObject, eventdata, handles)
% hObject    handle to operator_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of operator_tag as text
%        str2double(get(hObject,'String')) returns contents of operator_tag as a double


% --- Executes during object creation, after setting all properties.
function operator_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to operator_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Value_tag_Callback(hObject, eventdata, handles)

% hObject    handle to Value_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Value_tag as text
%        str2double(get(hObject,'String')) returns contents of Value_tag as a double


% --- Executes during object creation, after setting all properties.
function Value_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Value_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
image = getappdata(0,'myImage_value');
J = imadjust(image,stretchlim(image),[]);
 axes(handles.axes4);
imagesc(J);
 axes(handles.axes5);
imagesc(bar(imhist(J)));


% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function Clear_Callback(~, ~, handles)
clear
clc
cla

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Back_tag.
function Back_tag_Callback(hObject, eventdata, handles)
close
open('Start_figure.fig')
% hObject    handle to Back_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Exit_tag.
function Exit_tag_Callback(hObject, eventdata, handles)
close
% hObject    handle to Exit_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)


% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Image_path_Callback(hObject, eventdata, handles)
% hObject    handle to Image_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Image_path as text
%        str2double(get(hObject,'String')) returns contents of Image_path as a double


% --- Executes during object creation, after setting all properties.
function Image_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Image_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slid


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
image = getappdata(0,'myImage_value');
op = get(handles.edit6 , 'String');
k = str2double(get(handles.edit7 , 'string'));
 image = double(image);
    
    if strcmp(op,'+')
        result = image + k;
    elseif strcmp(op,'-')
        result = image - k;
    elseif strcmp(op,'*')
        result = image * k;
    elseif strcmp(op,'/')
        result = image / k;
    end
    
    [H, W, L] = size(result);
    for i=1:H
        for j=1:W
            for k=1:L
                if result(i, j, k) > 255
                    result(i, j, k) = 255;
                elseif result(i, j, k) < 0
                    result(i, j, k) = 0;
                end
            end
        end
    end
    
    result = uint8(result);
axes(handles.axes4);
imagesc(result);
cla(handles.axes5);






% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, ~, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
set(handles.edit6,'string',0);
set(handles.Value_tag,'string',0);
clc
clear
cla
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
