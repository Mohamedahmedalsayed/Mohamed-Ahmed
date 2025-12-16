function varargout = from5(varargin)
% FROM5 MATLAB code for from5.fig
%      FROM5, by itself, creates a new FROM5 or raises the existing
%      singleton*.
%
%      H = FROM5 returns the handle to a new FROM5 or the handle to
%      the existing singleton*.
%
%      FROM5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FROM5.M with the given input arguments.
%
%      FROM5('Property','Value',...) creates a new FROM5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before from5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to from5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help from5

% Last Modified by GUIDE v2.5 28-Dec-2015 13:27:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @from5_OpeningFcn, ...
                   'gui_OutputFcn',  @from5_OutputFcn, ...
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


% --- Executes just before from5 is made visible.
function from5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to from5 (see VARARGIN)

% Choose default command line output for from5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes from5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = from5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1. (Browse Button)
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[k, l] = uigetfile({'*.bmp;*.jpg;*.jpeg;*.png;*.tif;*.gif', ...
                    'Image Files (*.bmp, *.jpg, *.jpeg, *.png, *.tif, *.gif)';
                    '*.*', 'All Files (*.*)'}, ...
                    'Select an Image');

if isequal(k, 0) || isequal(l, 0)
    return; % User cancelled
end

% Construct full file path
comp = fullfile(l, k);
set(handles.edit1, 'string', comp);

% Read the image
img = imread(comp);

% ================================================
% ??????? ???????? ??? GRAYSCALE ?? ??? ?? ???? ??????
% ?????? ????? ??? grayscale ????? ??? ???? ?????
% ================================================

% Check if image is RGB (3 channels)
if size(img, 3) == 3
    % Convert RGB to Grayscale using built-in rgb2gray function
    img = rgb2gray(img);
    
    % Optional: Show confirmation message
    msgbox('RGB image has been converted to GRAYSCALE permanently!', ...
           'Conversion Complete', 'help');
end

% ================================================
% ????? ??????? - ?????? ???? grayscale ???????
% ================================================

% Display the image (now guaranteed to be grayscale)
imshow(img, 'parent', handles.axes1);

% Store the image path in handles
handles.imagePath = comp;
guidata(hObject, handles);


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a);
[w h l]=size(I);
if l==3
%    [ image new_image new_image1 y ]=
fourier_transfomation_rgb( I );
%     subplot(2,2,1);imshow(image,'parent',handles.axes2);
%     subplot(2,2,2);imshow(new_image,'parent',handles.axes2);
%     subplot(2,2,3);imshow(new_image1,'parent',handles.axes2);
%     subplot(2,2,4);imshow(y,'parent',handles.axes2);
elseif l==1 
%   [ image new_image new_image1 y ]=
fourier_transfomation_gray( I );
%     subplot(2,2,1);imshow(image,'parent',handles.axes2);
%     subplot(2,2,2);imshow(new_image,'parent',handles.axes2);
%     subplot(2,2,3);imshow(new_image1,'parent',handles.axes2);
%     subplot(2,2,4);imshow(y,'parent',handles.axes2)
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
I=imread(a);
e5= get(handles.edit5,'String');
if isempty(e5)  
msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
else
d0=str2num(e5);
[w h l]=size(I);
if l==1
switch get(handles.popupmenu3,'Value')  
case 1
   % disp('1');
N=ilpf( I,d0);
imshow(N,'parent',handles.axes2);
case 2
N=ihpf( I,d0 );
imshow(N,'parent',handles.axes2);
    otherwise
end
else
 switch get(handles.popupmenu3,'Value')  
case 1
N=ilpf_RGB( I,d0 );
imshow(N,'parent',handles.axes2);
case 2
N=ihpf_RGB( I,d0 );
imshow(N,'parent',handles.axes2);
otherwise
end
end
end
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a);
e2= get(handles.edit2,'String');
if isempty(e2)  
msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
else
d0=str2num(e2);
[w h l]=size(I);
if l==1
switch get(handles.popupmenu1,'Value')  
case 1
    disp('1');
N=gaussian_low(I,d0);
imshow(N,'parent',handles.axes2);
case 2
N=gaussian_high(I,d0);
imshow(N,'parent',handles.axes2);
    otherwise
end
else
 switch get(handles.popupmenu1,'Value')  
case 1
N=gaussian_l_RGB( I,d0 );
imshow(N,'parent',handles.axes2);
case 2
N=gaussian_h_RGB( I,d0 );
imshow(N,'parent',handles.axes2);
otherwise
end
end
end
end



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
a = get(handles.edit1,'String');
if isempty(a)  
msgbox({'Invalid' 'please select image'}, 'Error','error');  
else
I=imread(a);
e4= get(handles.edit4,'String');
e3= get(handles.edit3,'String');
if isempty(e4)  | isempty(e3) 
msgbox({'Invalid' 'please enter gama value'}, 'Error','error');  
else
d0=str2num(e4);
n=str2num(e3);
[w h l]=size(I);
if l==1
switch get(handles.popupmenu2,'Value')  
case 1
    disp('1');
N=butterworth_low( I,d0,n );
imshow(N,'parent',handles.axes2);
case 2
N=butterworth_high( I,d0,n );
imshow(N,'parent',handles.axes2);
    otherwise
end
else
switch get(handles.popupmenu2,'Value')  
case 1
N=butterworth_l_RGB( I,d0 ,n);
imshow(N,'parent',handles.axes2);
case 2
N=butterworth_h_RGB( I,d0 ,n);
imshow(N,'parent',handles.axes2);
otherwise
end
end
end
end



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
run;
close(from5);



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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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