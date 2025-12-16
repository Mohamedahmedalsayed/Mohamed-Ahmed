function varargout = run(varargin)
% RUN MATLAB code for run.fig

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct( ...
    'gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @run_OpeningFcn, ...
    'gui_OutputFcn',  @run_OutputFcn, ...
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
% End initialization code


function run_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = run_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% ---------------- Buttons ---------------- %

function pushbutton1_Callback(hObject, eventdata, handles)
from; close(run);

function pushbutton2_Callback(hObject, eventdata, handles)
from1; close(run);

function pushbutton3_Callback(hObject, eventdata, handles)
from2; close(run);

function pushbutton4_Callback(hObject, eventdata, handles)
from3; close(run);

function pushbutton5_Callback(hObject, eventdata, handles)
from4; close(run);

function pushbutton6_Callback(hObject, eventdata, handles)
from5; close(run);

function pushbutton7_Callback(hObject, eventdata, handles)
from6; close(run);

function pushbutton8_Callback(hObject, eventdata, handles)
close(run);

% ?? ???????? ???????????? - ?? ???????
function pushbutton9_Callback(hObject, eventdata, handles)
% ??????? ????? ???????? ????????????
morpho_gui();  % ?????? ??????? () ????????? ??????
close(run);    % ????? ?????? ????????


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
