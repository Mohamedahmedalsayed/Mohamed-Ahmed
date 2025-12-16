function varargout = PLOTTING(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PLOTTING_OpeningFcn, ...
                   'gui_OutputFcn',  @PLOTTING_OutputFcn, ...
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

function PLOTTING_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = PLOTTING_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function ContrastStretch_Callback(hObject, eventdata, handles)
itemp=handles.a;
min=getappdata(0,'min');
max=getappdata(0,'max');

S = contrastnew(itemp, min, max);
axes(handles.axes2);
imshow(S);


function histogram_Callback(hObject, eventdata, handles)
img=handles.a;
[H W] = size(img);
count = zeros(256, 1);

for i=1:H
    for j=1:W
        count(img(i, j) + 1) = count(img(i, j) + 1) + 1;
    end
end

axes(handles.axes2);
bar(count);

function contrastrange_Callback(hObject, eventdata, handles)
a=str2num(get(handles.contrastrange,'String'));
setappdata(0,'min',a);

function contrastrange_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Browse_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename=strcat(pathname,filename);
       a=imread(filename);
       axes(handles.axes1);
       imshow(a);
       handles.a=a;
       guidata(hObject, handles);
    end


function Back_Callback(hObject, eventdata, handles)
FirstTap
closereq();



function max_Callback(hObject, eventdata, handles)
a=str2num(get(handles.max,'String'));
setappdata(0,'max',a);

function max_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
