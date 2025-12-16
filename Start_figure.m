function varargout = Start_figure(varargin)
% START_FIGURE MATLAB code for Start_figure.fig
%      START_FIGURE, by itself, creates a new START_FIGURE or raises the existing
%      singleton*.
%
%      H = START_FIGURE returns the handle to a new START_FIGURE or the handle to
%      the existing singleton*.
%
%      START_FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START_FIGURE.M with the given input arguments.
%
%      START_FIGURE('Property','Value',...) creates a new START_FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Start_figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Start_figure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Start_figure

% Last Modified by GUIDE v2.5 20-Dec-2021 10:44:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Start_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @Start_figure_OutputFcn, ...
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


% --- Executes just before Start_figure is made visible.
function Start_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Start_figure (see VARARGIN)

% Choose default command line output for Start_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Start_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Start_figure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Enhancement_tag.
function Enhancement_tag_Callback(hObject, eventdata, handles)
close
open('Enhancement_figure.fig')
% hObject    handle to Enhancement_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
close
open('linear.fig')
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
close
open('non_linear.fig')
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
close


% --- Executes on button press in Conversion_tag.
function Conversion_tag_Callback(hObject, eventdata, handles)

close;
open('Conversion_figure.fig');

% hObject    handle to Conversion_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Transformation_tag.
function Transformation_tag_Callback(hObject, eventdata, handles)
close
open('Transformation_figure.fig')
% hObject    handle to Transformation_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Noises_tag.
function Noises_tag_Callback(hObject, eventdata, handles)
close
open('Noise.fig')
% hObject    handle to Noises_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
close
open('Frequency.fig')
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
