function varargout = Transformation_figure(varargin)
% TRANSFORMATION_FIGURE MATLAB code for Transformation_figure.fig
%      TRANSFORMATION_FIGURE, by itself, creates a new TRANSFORMATION_FIGURE or raises the existing
%      singleton*.
%
%      H = TRANSFORMATION_FIGURE returns the handle to a new TRANSFORMATION_FIGURE or the handle to
%      the existing singleton*.
%
%      TRANSFORMATION_FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSFORMATION_FIGURE.M with the given input arguments.
%
%      TRANSFORMATION_FIGURE('Property','Value',...) creates a new TRANSFORMATION_FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Transformation_figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Transformation_figure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Transformation_figure

% Last Modified by GUIDE v2.5 20-Dec-2021 11:16:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Transformation_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @Transformation_figure_OutputFcn, ...
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


% --- Executes just before Transformation_figure is made visible.
function Transformation_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Transformation_figure (see VARARGIN)

% Choose default command line output for Transformation_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Transformation_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Transformation_figure_OutputFcn(hObject, eventdata, handles) 
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
axes(handles.axes1);
imagesc(myImage);
setappdata(0,'myImage_value',myImage);
guidata(hObject, handles);




% --- Executes on button press in Gamma_tag.
function Gamma_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
Rgb_img = getappdata(0,'myImage_value');
gamma_var = str2double(get(handles.Gamma_editbox , 'string'));

Rgb_img = im2double(Rgb_img);

gamma_img = 1 * power(Rgb_img,gamma_var);
    
gamma_img = im2uint8(gamma_img);

imshow(gamma_img , 'parent' , handles.axes2);
guidata(hObject, handles);





function Gamma_editbox_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gamma_editbox as text
%        str2double(get(hObject,'String')) returns contents of Gamma_editbox as a double


% --- Executes during object creation, after setting all properties.
function Gamma_editbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Back_tag.
function Back_tag_Callback(hObject, eventdata, handles)
close
open('Start_figure.fig')
% hObject    handle to Back_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Invs_Log_tag.
function Invs_Log_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
Rgb_img = getappdata(0,'myImage_value');

[ x ,w ,~ ] = size (Rgb_img);
inv_log_img = zeros(x , w);
Rgb_img = double(Rgb_img);
    for i=1:x
        for j=1:w
            inv_log_img(i,j,1) =exp((Rgb_img(i,j,1))+1);
            inv_log_img(i,j,2) =exp((Rgb_img(i,j,2))+1);
            inv_log_img(i,j,3) =exp((Rgb_img(i,j,3))+1);
        end
    end
inv_log_img = uint8(inv_log_img);

axes(handles.axes2);
imagesc(inv_log_img);
guidata(hObject, handles);


% --- Executes on button press in Negative_tag.
function Negative_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
Rgb_img = getappdata(0,'myImage_value');

[ x ,w ,~ ] = size (Rgb_img);
negative_img = zeros(x , w);
Rgb_img = double(Rgb_img);
    
for i=1:x
    for j=1:w
        negative_img(i,j,1) = 255 - Rgb_img(i,j,1);
        negative_img(i,j,2) = 255 - Rgb_img(i,j,2);
        negative_img(i,j,3) = 255 - Rgb_img(i,j,3);

    end
end

negative_img = uint8(negative_img);

axes(handles.axes2);
imagesc(negative_img);
guidata(hObject, handles);



% --- Executes on button press in Histo_EQ_tag.
function Histo_EQ_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
Rgb_img = getappdata(0,'myImage_value');
histo_eq_img= histeq(Rgb_img);
axes(handles.axes2);
imagesc(histo_eq_img);
guidata(hObject, handles);


% --- Executes on button press in Log_tag.
function Log_tag_Callback(hObject, eventdata, handles)

handles.output = hObject;

Rgb_img = getappdata(0,'myImage_value');
[ x ,w ,~ ] = size (Rgb_img);
log_img = zeros(x , w);
Rgb_img = im2double(Rgb_img);
    for i=1:x
        for j=1:w
            log_img(i,j,1) =log((Rgb_img(i,j,1))+1);
            log_img(i,j,2) =log((Rgb_img(i,j,2))+1);
            log_img(i,j,3) =log((Rgb_img(i,j,3))+1);
        end
    end
log_img = im2uint8(log_img);

axes(handles.axes2);
imagesc(log_img);
guidata(hObject, handles);




% --- Executes on button press in Exit_tag.
function Exit_tag_Callback(hObject, eventdata, handles)
close
% hObject    handle to Exit_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
