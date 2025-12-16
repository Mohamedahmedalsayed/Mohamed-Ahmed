function varargout = Frequency(varargin)
% FREQUENCY MATLAB code for Frequency.fig
%      FREQUENCY, by itself, creates a new FREQUENCY or raises the existing
%      singleton*.
%
%      H = FREQUENCY returns the handle to a new FREQUENCY or the handle to
%      the existing singleton*.
%
%      FREQUENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREQUENCY.M with the given input arguments.
%
%      FREQUENCY('Property','Value',...) creates a new FREQUENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Frequency_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Frequency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Frequency

% Last Modified by GUIDE v2.5 29-Dec-2021 21:46:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Frequency_OpeningFcn, ...
                   'gui_OutputFcn',  @Frequency_OutputFcn, ...
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


% --- Executes just before Frequency is made visible.
function Frequency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Frequency (see VARARGIN)

% Choose default command line output for Frequency
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Frequency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Frequency_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_img_btn.
function load_img_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
[rawname,rawpath]=uigetfile(('*.jpg'),'Select Image Data');
fullname=[rawpath rawname];
myImage= imread(fullname);
axes(handles.axes1);
imagesc(myImage);
setappdata(0,'myImage',myImage);
guidata(hObject, handles);



% --- Executes on button press in Fouri_btn.
function Fouri_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
image = getappdata(0,'myImage');
four_img = ferqancy_filter(image);

axes(handles.axes2);
imagesc(four_img);
setappdata(0,'fourier_img',four_img);
guidata(hObject, handles);



% --- Executes on button press in inv_Four_btn.
function inv_Four_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
four_img = getappdata(0,'myImage');
%inv_four_img = InverseFouierTransform(four_img);
axes(handles.axes2);
imagesc(four_img);
guidata(hObject, handles);



% --- Executes on button press in ideal_high_btn.
function ideal_high_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img= getappdata(0,'myImage');
d0 = str2double(get(handles.D0_edt_tct , 'string'));
fi=fft2(img);
    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w ,l]=size(img);
    filter=zeros(h,w);
    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            if d <= d0
                filter(i,j)=0;
            else
                filter(i,j)=1;
            end
        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end
    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;


imshow(filter_image,'parent',handles.axes2);
guidata(hObject, handles);

% --- Executes on button press in gauss_high_btn.
function gauss_high_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img= getappdata(0,'myImage');
d0 = str2double(get(handles.d0_gauss_edt_txt , 'string'));
fi=fft2(img);

    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w, l]=size(img);
    filter=zeros(h,w);

    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            filter(i,j)=1-exp((-d^2)/(2*d0)^2);

        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end
    %nreal=nreal*filter
    %nimag=nimag*filter
    %NI=nreal+i*nimag
    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;

imshow(filter_image,'parent',handles.axes2);
guidata(hObject, handles);


% --- Executes on button press in butter_high_btn.
function butter_high_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img= getappdata(0,'myImage');
d0 = str2double(get(handles.d0_butter_edt_txt , 'string'));
n = str2double(get(handles.n_edt_txt , 'string'));
fi=fft2(img);

    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w, l]=size(img);
    filter=zeros(h,w);

    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            filter(i,j)=1-exp((-d^2)/(2*d0)^2);

        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end
    %nreal=nreal*filter
    %nimag=nimag*filter
    %NI=nreal+i*nimag
    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;
    

imshow(filter_image,'parent',handles.axes2);

guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
close 
open('Start_figure.fig');
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
close
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ideal_low_pass_btn.
function ideal_low_pass_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
d0 = str2double(get(handles.D0_edt_tct , 'string'));   
fi=fft2(img);
    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w,l]=size(img);
    filter=zeros(h,w);

    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            if d <= d0
                filter(i,j)=1;
            else
                filter(i,j)=0;
            end

        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end

    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;


imshow(filter_image,'parent',handles.axes2);
guidata(hObject, handles);



function D0_edt_tct_Callback(hObject, eventdata, handles)
% hObject    handle to D0_edt_tct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D0_edt_tct as text
%        str2double(get(hObject,'String')) returns contents of D0_edt_tct as a double


% --- Executes during object creation, after setting all properties.
function D0_edt_tct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D0_edt_tct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gauss_low_btn.
function gauss_low_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
d0 = str2double(get(handles.d0_gauss_edt_txt , 'string'));
fi=fft2(img);
    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w,l]=size(img);
    filter=zeros(h,w);

    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            filter(i,j)=exp((-d^2)/(2*d0)^2);

        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end

    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;

imshow(filter_image,'parent',handles.axes2);

guidata(hObject, handles);



function d0_gauss_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to d0_gauss_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d0_gauss_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of d0_gauss_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function d0_gauss_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d0_gauss_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in butter_low_btn.
function butter_low_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
img = getappdata(0,'myImage');
d0 = str2double(get(handles.d0_gauss_edt_txt , 'string'));
n = str2double(get(handles.n_edt_txt , 'string'));

fi=fft2(img);
    fi=fftshift(fi);
    nreal=real(fi);
    nimag=imag(fi);
    [h ,w,l]=size(img);
    filter=zeros(h,w);

    for i=1:h
        for j=1:w
            d=sqrt((i-h/2)^2+(j-w/2)^2);
            filter(i,j)=exp((-d^2)/(2*d0)^2);

        end
    end
    for i=1:h
        for j=1:w
            nreal(i,j)=nreal(i,j)*filter(i,j);
            nimag(i,j)=nimag(i,j)*filter(i,j);
            NI(i,j)=nreal(i,j)+sqrt(-1)*nimag(i,j);
        end
    end

    NI=fftshift(NI);
    NI=ifft2(NI);
    z=mat2gray(abs(NI));
    filter_image=z;


imshow(filter_image,'parent',handles.axes2);
guidata(hObject, handles);




function d0_butter_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to d0_butter_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d0_butter_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of d0_butter_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function d0_butter_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d0_butter_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_edt_txt_Callback(hObject, eventdata, handles)
% hObject    handle to n_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_edt_txt as text
%        str2double(get(hObject,'String')) returns contents of n_edt_txt as a double


% --- Executes during object creation, after setting all properties.
function n_edt_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_edt_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
