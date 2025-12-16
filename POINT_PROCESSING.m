function varargout = POINT_PROCESSING(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @POINT_PROCESSING_OpeningFcn, ...
                   'gui_OutputFcn',  @POINT_PROCESSING_OutputFcn, ...
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

function POINT_PROCESSING_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = POINT_PROCESSING_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function RGB2gray_Callback(hObject, eventdata, handles)
result=handles.a;
op=getappdata(0,'option');
ratio=getappdata(0,'ratioo');

result = im2double(result);
r = result(:, :, 1);
g = result(:, :, 2);
b = result(:, :, 3);
if op==1
        result = r;
    elseif op==2
        result = g;
    elseif op==3
        result = b;
    elseif op==4
        result = (r + g + b) / 3;
    elseif op==5
        result = ratio(1)*r + ratio(2)*g + ratio(3)*b;
end 
result = im2uint8(result);

axes(handles.axes2);
imshow(result);
handles.result=result;
guidata(hObject, handles);


function Gray2Binary_Callback(hObject, eventdata, handles)
img=handles.a;
T=getappdata(0,'threshold');

[H, W] = size(img);
result = zeros(H, W);
result = im2double(result);

if T < 0 || T > 255
    disp('Error: threshold is out of range');
    disp('Enter from 0 to 255');
else
    for i=1:H
       for j=1:W
           if img(i, j) > T
               result(i, j) = 1;
           else
               result(i, j) = 0;
           end
       end
    end
end
    
result = logical(result);

axes(handles.axes2);
imshow(result);
handles.result=result;
guidata(hObject, handles);


function RGB2Binary_Callback(hObject, eventdata, handles)
img=handles.a;
T=getappdata(0,'thre');
img = im2double(img);
r = img(:, :, 1);
g = img(:, :, 2);
b = img(:, :, 3);
gray = (r + g + b) / 3;
gray = im2uint8(gray);

[H, W] = size(gray);
result = zeros(H, W);

for i=1:H
    for j=1:W
        if gray(i, j) > T
            result(i, j) = 1;
        else
            result(i, j) = 0;
        end
    end
end

result = logical(result);

axes(handles.axes2);
imshow(result);
handles.result=result;
guidata(hObject, handles);


function bright_Callback(hObject, eventdata, handles)
img=handles.a;
op=getappdata(0,'opt');
k=getappdata(0,'k');     %double is used to bright in case of + and /
img = im2double(img);

if op=='+'
    result = img + k;
elseif op=='/'
    result = img / k;
end

[H, W, L] = size(result);
for i=1:H
    for j=1:W
        for k=1:L
            if result(i, j, k) > 255
                result(i, j, k) = 255;
            end
        end
    end
end

result = im2uint8(result);

axes(handles.axes2);
imshow(result);
handles.result=result;
guidata(hObject, handles);


function Darkness_Callback(hObject, eventdata, handles)
img=handles.a;
op=getappdata(0,'darkop');
k=getappdata(0,'KK');   %double is used to dark in case of - and *
img = im2double(img);

if op=='-'
    result = img - k;
elseif op=='*'
    result = img * k;
end

[H, W, L] = size(result);
for i=1:H
    for j=1:W
        for k=1:L
            if result(i, j, k) < 0
                result(i, j, k) = 0;
            end
        end
    end
end

result = im2uint8(result);

axes(handles.axes2);
imshow(result);
handles.result=result;
guidata(hObject, handles);


function log_Callback(hObject, eventdata, handles)
img=handles.a;
c=getappdata(0,'const');
img = im2double(img);

s = c * log2(1 + img);
s = im2uint8(s);

axes(handles.axes2);
imshow(s);
handles.s=s;
guidata(hObject, handles);


function expo_Callback(hObject, eventdata, handles)
img=handles.a;
c=getappdata(0,'const');
img = im2double(img);

S = power(2.0, img/c) - 1;
S = im2uint8(S);

axes(handles.axes2);
imshow(S);
handles.S=S;
guidata(hObject, handles);


function negative_Callback(hObject, eventdata, handles)
img=handles.a;
img=im2double(img);
S = 1 - img;
S = im2uint8(S);

axes(handles.axes2);
imshow(S);


function gamma_Callback(hObject, eventdata, handles)
img=handles.a;
c=getappdata(0,'const');
y=getappdata(0,'Y');
img = im2double(img);
S = c * power(img, y);
S = im2uint8(S);

axes(handles.axes2);
imshow(S);


function brightoption_Callback(hObject, eventdata, handles)
a=get(handles.brightoption,'String');
setappdata(0,'opt',a);

function brightoption_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function brightconst_Callback(hObject, eventdata, handles)
a=str2num(get(handles.brightconst,'String'));
setappdata(0,'k',a);

function brightconst_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function darkoption_Callback(hObject, eventdata, handles)
a=get(handles.darkoption,'String');
setappdata(0,'darkop',a);


function darkoption_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function darkconst_Callback(hObject, eventdata, handles)
a=str2num(get(handles.darkconst,'String'));
setappdata(0,'KK',a);


function darkconst_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb2grayoption_Callback(hObject, eventdata, handles)
a=str2num(get(handles.rgb2grayoption,'String'));
setappdata(0,'option',a);

function rgb2grayoption_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rgb2grayratio_Callback(hObject, eventdata, handles)
a=str2num(get(handles.rgb2grayratio,'String'));
setappdata(0,'ratioo',a);

function rgb2grayratio_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function gray2binarythreshold_Callback(hObject, eventdata, handles)
a=str2num(get(handles.gray2binarythreshold,'String'));
setappdata(0,'threshold',a);

function gray2binarythreshold_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rgb2binarythreshold_Callback(hObject, eventdata, handles)
a=str2num(get(handles.rgb2binarythreshold,'String'));
setappdata(0,'thre',a);


function rgb2binarythreshold_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function expoconst_Callback(hObject, eventdata, handles)
a=str2num(get(handles.expoconst,'String'));
setappdata(0,'const',a);

function expoconst_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function gammaconst_Callback(hObject, eventdata, handles)
a=str2num(get(handles.gammaconst,'String'));
setappdata(0,'const',a);

function gammaconst_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gammaY_Callback(hObject, eventdata, handles)
a=str2num(get(handles.gammaY,'String'));
setappdata(0,'Y',a);


function gammaY_CreateFcn(hObject, eventdata, handles)

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


function logconstt_Callback(hObject, eventdata, handles)
a=str2num(get(handles.logconstt,'String'));
setappdata(0,'const',a);


function logconstt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function back_Callback(hObject, eventdata, handles)
FirstTap
closereq();
