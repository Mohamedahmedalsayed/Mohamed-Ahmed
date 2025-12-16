function varargout = Noise(varargin)
% NOISE MATLAB code for Noise.fig
%      NOISE, by itself, creates a new NOISE or raises the existing
%      singleton*.
%
%      H = NOISE returns the handle to a new NOISE or the handle to
%      the existing singleton*.
%
%      NOISE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE.M with the given input arguments.
%
%      NOISE('Property','Value',...) creates a new NOISE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Noise_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Noise_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Noise

% Last Modified by GUIDE v2.5 30-Dec-2021 12:40:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Noise_OpeningFcn, ...
                   'gui_OutputFcn',  @Noise_OutputFcn, ...
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


% --- Executes just before Noise is made visible.
function Noise_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Noise (see VARARGIN)

% Choose default command line output for Noise
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Noise wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Noise_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_image_btn.
function load_image_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
[rawname,rawpath]=uigetfile(('*.jpg'),'Select Image Data');
fullname=[rawpath rawname];
img= imread(fullname);
imshow(img , 'parent' , handles.axes9);
setappdata(0,'myImage_value',img);
guidata(hObject, handles);





% --- Executes on button press in salt_btn.
function salt_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage_value');
ps= str2double(get(handles.rate_edt_txt , 'string'));

[H,W] = size(img);
    img = double(img);

    ps = ps*H*W;

    
for j=1:ps
    x = ceil(rand(1,1)*H);
    y = ceil(rand(1,1)*W);
    img(x,y) = 255;
end
N_image=uint8(img);

imshow(N_image,'parent',handles.axes10);
guidata(hObject, handles);




% --- Executes on button press in gaussian_btn.
function gaussian_btn_Callback(hObject, eventdata, handles)
image = getappdata(0,'myImage_value');
start= str2double(get(handles.m_edt_txt , 'string'));
J = imnoise(image,'gaussian',start);
imshow(J,'Parent',handles.axes10);



% --- Executes on button press in rayleigh_btn.
function rayleigh_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage_value');
a= str2double(get(handles.a_rayleigh_edt_txt , 'string'));
b= str2double(get(handles.b_rayleigh_edt_txt, 'string'));
newImg(:,:,1)=Rayleigh_noise(img(:,:,1),a,b);
newImg(:,:,2)=Rayleigh_noise(img(:,:,2),a,b);
newImg(:,:,3)=Rayleigh_noise(img(:,:,3),a,b);
imshow(newImg,'Parent',handles.axes10);


% --- Executes on button press in uniform_btn.
function uniform_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage_value');
a = str2double(get(handles.a_uniform_edt_txt , 'string'));
b = str2double(get(handles.b_uniform_edt_txt , 'string'));

img = double(img);
[H,W] = size(img);
    numOfPixels = 1/(b-a) * W * H;
    img = double(img);

    for i=a:b
        for j=1:numOfPixels
            x = ceil(rand(1,1)*H);
            y = ceil(rand(1,1)*W);
            img(x,y) = img(x,y)+i;
            if(img(x,y)>255)
                img(x,y)=255;
            end
        end
    end
img = uint8(img);


imshow(img,'Parent',handles.axes10);
guidata(hObject,handles);



% --- Executes on button press in gamma_btn.
function gamma_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage_value');
gamma = str2double(get(handles.a_gamma_edt_txt , 'string'));
new_img=imadjust(img,[],[],gamma);
imshow(new_img,'Parent',handles.axes10);
guidata(hObject,handles);

function exponential_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img0 = getappdata(0,'myImage_value');
a = str2double(get(handles.edit20 , 'string'));
b = str2double(get(handles.edit21 , 'string'));
img1(:,:,1)=Exponential_noise_code(img0(:,:,1),a,b);
img1(:,:,2)=Exponential_noise_code(img0(:,:,2),a,b);
img1(:,:,3)=Exponential_noise_code(img0(:,:,3),a,b);
img1 = uint8(img1);
imshow(img1,'Parent',handles.axes10);
guidata(hObject,handles);

% --- Executes on selection change in salt_papper_menu.
function salt_papper_menu_Callback(hObject, eventdata, handles)
% hObject    handle to salt_papper_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns salt_papper_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from salt_papper_menu


% --- Executes during object  creation, after setting all properties.
function salt_papper_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to salt_papper_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to m_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of m_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function m_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rate_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to rate_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rate_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of rate_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function rate_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rate_edt_txt (see GCBO)
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



function a_rayleigh_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to a_rayleigh_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rayleigh_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of a_rayleigh_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function a_rayleigh_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rayleigh_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_rayleigh_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to b_rayleigh_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_rayleigh_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of b_rayleigh_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function b_rayleigh_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_rayleigh_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prob_uniform_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to prob_uniform_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prob_uniform_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of prob_uniform_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function prob_uniform_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prob_uniform_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_uniform_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to a_uniform_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_uniform_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of a_uniform_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function a_uniform_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_uniform_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_uniform_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to b_uniform_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_uniform_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of b_uniform_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function b_uniform_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_uniform_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_gamma_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to a_gamma_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_gamma_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of a_gamma_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function a_gamma_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_gamma_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_gamma_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to b_gamma_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_gamma_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of b_gamma_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function b_gamma_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_gamma_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value_expon_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to value_expon_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_expon_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of value_expon_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function value_expon_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_expon_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in back_btn.
function back_btn_Callback(hObject, eventdata, handles)
close
open('Start_figure.fig')
% hObject    handle to back_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, ~, handles)
close
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in papper_tag.
function papper_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage_value');
Np= str2double(get(handles.rate_edt_txt , 'string'));
[H,W] = size(img);
    img = double(img);
    Np = Np*H*W;
for i=1:Np
    x = ceil(rand(1,1)*H);
    y = ceil(rand(1,1)*W);
    img(x,y) = 0;
end

N_image=uint8(img);
imshow(N_image , 'parent' , handles.axes10);
guidata(hObject, handles);



% --- Executes on button press in Slat_papper_btn.
function Slat_papper_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage_value');
Np= str2double(get(handles.rate_edt_txt , 'string'));
[H,W] = size(img);
    img = double(img);
    Np = Np*H*W;
for i=1:Np
    x = ceil(rand(1,1)*H);
    y = ceil(rand(1,1)*W);
    img(x,y) = 0;
end
for i=1:Np
    x = ceil(rand(1,1)*H);
    y = ceil(rand(1,1)*W);
    img(x,y) = 255;
end

N_image=uint8(img);
imshow(N_image , 'parent' , handles.axes10);
guidata(hObject, handles);
% hObject    handle to Slat_papper_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
