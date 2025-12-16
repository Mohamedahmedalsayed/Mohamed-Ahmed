function varargout = FirstTap(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FirstTap_OpeningFcn, ...
                   'gui_OutputFcn',  @FirstTap_OutputFcn, ...
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


function FirstTap_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = FirstTap_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function noises_Callback(hObject, eventdata, handles)
NOISES
closereq(); 

function filters_Callback(hObject, eventdata, handles)
guiProject
closereq(); 




function sharpening_Callback(hObject, eventdata, handles)
SHARPENING
closereq(); 

function blurring_Callback(hObject, eventdata, handles)
BLURRING
closereq(); 

function points_Callback(hObject, eventdata, handles)
POINT_PROCESSING
closereq(); 


function Plotting_Callback(hObject, eventdata, handles)
PLOTTING
closereq(); 


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
imshow('Backgrounds.jpg');
