function varargout = from4(varargin)
% FROM4 MATLAB code for from4.fig
%      FROM4, by itself, creates a new FROM4 or raises the existing
%      singleton*.
%
%      H = FROM4 returns the handle to a new FROM4 or the handle to
%      the existing singleton*.
%
%      FROM4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FROM4.M with the given input arguments.
%
%      FROM4('Property','Value',...) creates a new FROM4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before from4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to from4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help from4

% Last Modified by GUIDE v2.5 28-Dec-2015 00:21:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @from4_OpeningFcn, ...
                   'gui_OutputFcn',  @from4_OutputFcn, ...
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


% --- Executes just before from4 is made visible.
function from4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to from4 (see VARARGIN)

% Choose default command line output for from4
handles.output = hObject;
% create an axes that spans the whole gui
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes from4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = from4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a) ;
mask_w1 = get(handles.edit2,'String');
mask_h1 = get(handles.edit3,'String');
if isempty(mask_w1)  | isempty(mask_h1)
msgbox({'Invalid' 'please fall space'}, 'Error','error');  
else
mask_w=str2num(mask_w1);
mask_h=str2num(mask_h1);
N=NonlinearMinFilter( I,mask_h,mask_w);
imshow(N,'parent',handles.axes2);
end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a) ;
mask_w1 = get(handles.edit2,'String');
mask_h1 = get(handles.edit3,'String');
if isempty(mask_w1)  | isempty(mask_h1)
msgbox({'Invalid' 'please fall space'}, 'Error','error');  
else
mask_w=str2num(mask_w1);
mask_h=str2num(mask_h1);
N=NonlinearMaxFilter( I,mask_h,mask_w);
imshow(N,'parent',handles.axes2);
end
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
 a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a) ;
mask_w1 = get(handles.edit2,'String');
mask_h1 = get(handles.edit3,'String');
if isempty(mask_w1)  | isempty(mask_h1)
msgbox({'Invalid' 'please fall space'}, 'Error','error');  
else
mask_w=str2num(mask_w1);
mask_h=str2num(mask_h1);
N= NonlinearMedianFilter( I,mask_h,mask_w);
imshow(N,'parent',handles.axes2);
end
end



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
[i j]=uigetfile({'*.*','All Files'});
comp = strcat(j,i);
set(handles.edit1,'string',comp);
img=imread([j i]);
imshow(img,'parent',handles.axes1);
% hObject    handle to pushbutton4 (see GCBO)
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
 a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a) ;
mask_w1 = get(handles.edit2,'String');
mask_h1 = get(handles.edit3,'String');
if isempty(mask_w1)  | isempty(mask_h1)
msgbox({'Invalid' 'please fall space'}, 'Error','error');  
else
mask_w=str2num(mask_w1);
mask_h=str2num(mask_h1);
N= NonlinearMidFilter( I,mask_h,mask_w);
imshow(N,'parent',handles.axes2);
end
end



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
run;
close(from4);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
 a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a) ;
mask_w1 = get(handles.edit2,'String');
mask_h1 = get(handles.edit3,'String');
if isempty(mask_w1)  | isempty(mask_h1)
msgbox({'Invalid' 'please fall space'}, 'Error','error');  
else
mask_w=str2num(mask_w1);
mask_h=str2num(mask_h1);
N= NonlinearGeometricFilter( I,mask_h,mask_w);
imshow(N,'parent',handles.axes2);
end
end




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
