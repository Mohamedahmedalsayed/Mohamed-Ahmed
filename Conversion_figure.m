function varargout = Conversion_figure(varargin)
% CONVERSION_FIGURE MATLAB code for Conversion_figure.fig
%      CONVERSION_FIGURE, by itself, creates a new CONVERSION_FIGURE or raises the existing
%      singleton*.
%
%      H = CONVERSION_FIGURE returns the handle to a new CONVERSION_FIGURE or the handle to
%      the existing singleton*.
%
%      CONVERSION_FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERSION_FIGURE.M with the given input arguments.
%
%      CONVERSION_FIGURE('Property','Value',...) creates a new CONVERSION_FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Conversion_figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Conversion_figure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Conversion_figure

% Last Modified by GUIDE v2.5 21-Dec-2021 13:17:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Conversion_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @Conversion_figure_OutputFcn, ...
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




% --- Executes just before Conversion_figure is made visible.
function Conversion_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Conversion_figure (see VARARGIN)

% Choose default command line output for Conversion_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Conversion_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Conversion_figure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[rawname,rawpath]=uigetfile(('*.jpg'),'Select Image Data');
fullname=[rawpath rawname];
myImage= imread(fullname);
imshow(myImage, 'parent',handles.axes1);
setappdata(0,'image_value',myImage);



% --- Executes on button press in RGB2binary_tag.
function RGB2binary_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
Rgb_img = getappdata(0,'image_value'); 
Rgb_img = double(Rgb_img);
    r = Rgb_img(:, :, 1);
    g = Rgb_img(:, :, 2);
    b = Rgb_img(:, :, 3);
    
    gray_img = (r + g + b) / 3;
    
    [H, W] = size(gray_img);
    binary_img = zeros(H, W);
    
for i=1:H
    for j=1:W
        if gray_img(i, j) > 127
           binary_img(i, j) = 1;
        else
           binary_img(i, j) = 0;
        end
     end
end

binary_img = logical(binary_img);
imshow(binary_img,'parent',handles.axes3);
guidata(hObject, handles);


% --- Executes on button press in RGB2Gray_btn.
function RGB2Gray_btn_Callback(hObject, eventdata, handles)
handles.output = hObject;
Rgb_img = getappdata(0,'image_value');

 Rgb_img = double( Rgb_img );
 
    r = Rgb_img(:, :, 1);
    g = Rgb_img(:, :, 2);
    b = Rgb_img(:, :, 3);
    
    gray_img = (r + g + b) / 3;
 

gray_img = uint8(gray_img );
imshow(gray_img,'parent',handles.axes3);
guidata(hObject, handles);







% --- Executes on button press in Gray2Binary_tag.
function Gray2Binary_tag_Callback(hObject, eventdata, handles)
handles.output = hObject;
Gray_img = getappdata(0,'image_value');

[H, W] = size(Gray_img);
binary_img = zeros(H, W);
Gray_img = double( Gray_img );

    for i=1:H
        for j=1:W
            if Gray_img(i, j) >= 127
                binary_img(i, j) = 1;
            else
                binary_img(i, j) = 0;
            end
        end
    end
    
binary_img = logical(binary_img);
%binary_img = Gray2Binary(Gray_img, 127);
imshow(binary_img,'parent',handles.axes3);
guidata(hObject, handles);
    


% --- Executes on button press in Back_tag.
function Back_tag_Callback(hObject, eventdata, handles)

close;
open('Start_figure.fig');

% hObject    handle to Back_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Exit_tag.
function Exit_tag_Callback(hObject, eventdata, handles)
close
% hObject    handle to Exit_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
