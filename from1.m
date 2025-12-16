function varargout = from1(varargin)
% FROM1 MATLAB code for from1.fig
%      FROM1, by itself, creates a new FROM1 or raises the existing
%      singleton*.
%
%      H = FROM1 returns the handle to a new FROM1 or the handle to
%      the existing singleton*.
%
%      FROM1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FROM1.M with the given input arguments.
%
%      FROM1('Property','Value',...) creates a new FROM1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before from1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to from1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help from1

% Last Modified by GUIDE v2.5 16-Dec-2025

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @from1_OpeningFcn, ...
                   'gui_OutputFcn',  @from1_OutputFcn, ...
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


% --- Executes just before from1 is made visible.
function from1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to from1 (see VARARGIN)

% Choose default command line output for from1
handles.output = hObject;

% ????? ????? ?????????? ??????
if isfield(handles, 'edit3')
    set(handles.edit3, 'String', '1.5');  % ???? ???????? ?? Contrast
end
if isfield(handles, 'edit4')
    set(handles.edit4, 'String', '+');    % ???? ???????? ???????? ????????
end
if isfield(handles, 'edit5')
    set(handles.edit5, 'String', '10');   % ???? ???????? ???????
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes from1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = from1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1 (Brightness Button).
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = get(handles.edit2,'String');
if isempty(a)  
    msgbox({'Invalid' 'Please select an image first'}, 'Error','error');  
else
    I = imread(a);
    [w, h, l] = size(I);
    op = get(handles.edit4,'String');
    e5 = get(handles.edit5,'String');
    
    if isempty(op) || isempty(e5)
        msgbox({'Invalid' 'Please fill all empty spaces'}, 'Error','error');  
    else
        off = str2double(e5);
        
        % ?????? ?? ?? ?????? ?????
        if isnan(off)
            msgbox({'Invalid' 'Offset value must be a number'}, 'Error','error');
            return;
        end
        
        if l == 3
            NR = RGBbright(I, op, off);
            imshow(NR,'parent',handles.axes2);
            title(handles.axes2, 'Brightness Adjusted (RGB)');
        else
            NG = graybright(I, op, off);
            imshow(NG,'parent',handles.axes2);
            title(handles.axes2, 'Brightness Adjusted (Grayscale)');
        end
    end
end


% --- Executes on button press in pushbutton2 (Contrast Button).
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = get(handles.edit2,'String');
if isempty(a)  
    msgbox({'Invalid' 'Please select an image first'}, 'Error','error');  
else
    s = get(handles.edit3,'String');
    if isempty(s)  
        msgbox({'Invalid' 'Please enter contrast value'}, 'Error','error');  
    else
        n = str2double(s);
        
        % ?????? ?? ?? ?????? ????? ??????
        if isnan(n) || n <= 0
            msgbox({'Invalid' 'Contrast value must be a positive number'}, 'Error','error');
            set(handles.edit3, 'String', '1.5');
            return;
        end
        
        I = imread(a);
        
        try
            x = contrast(I, n);
            imshow(x, 'parent', handles.axes2);
            title(handles.axes2, sprintf('Contrast Stretched (Factor: %.2f)', n));
        catch ME
            msgbox({'Error in contrast function:' ME.message}, 'Processing Error', 'error');
        end
    end
end


% --- Executes on button press in pushbutton3 (Histogram Button).
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = get(handles.edit2,'String');
if isempty(a)  
    msgbox({'Invalid' 'Please select an image first'}, 'Error','error');  
else
    I = imread(a);
    [w, h, l] = size(I);
    
    if l == 3
        % ???? RGB
        try
            [r, g, b] = hist(I);
            from7;
            subplot(3,1,1); bar(r, 'r'); title('Red Channel Histogram');
            subplot(3,1,2); bar(g, 'g'); title('Green Channel Histogram');
            subplot(3,1,3); bar(b, 'b'); title('Blue Channel Histogram');
        catch
            % ??? ???? ???? hist ???????? ?????? ???? MATLAB ???????
            figure('Name', 'RGB Histogram');
            subplot(2,2,1); imshow(I); title('Original Image');
            subplot(2,2,2); imhist(I(:,:,1)); title('Red Channel');
            subplot(2,2,3); imhist(I(:,:,2)); title('Green Channel');
            subplot(2,2,4); imhist(I(:,:,3)); title('Blue Channel');
        end
    else
        % ???? Grayscale
        try
            [r2] = hist(I);
            bar(r2, 'parent', handles.axes2);
            title(handles.axes2, 'Grayscale Histogram');
        catch
            % ??? ???? ???? hist ???????? ?????? ???? MATLAB ???????
            imhist(I, 'parent', handles.axes2);
            title(handles.axes2, 'Grayscale Histogram (MATLAB)');
        end
    end
end


% --- Executes on button press in pushbutton4 (Browse Button).
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[c, d] = uigetfile({'*.jpg;*.png;*.bmp;*.tif;*.jpeg', 'Image Files (*.jpg, *.png, *.bmp, *.tif, *.jpeg)'; ...
                    '*.*', 'All Files (*.*)'}, 'Select Image File');
                    
if isequal(c, 0) || isequal(d, 0)
    return;  % ???????? ??? Cancel
end

comp = fullfile(d, c);
set(handles.edit2, 'string', comp);
img = imread(comp);
imshow(img, 'parent', handles.axes1);
title(handles.axes1, 'Original Image');


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


% --- Executes on button press in pushbutton5 (BACK Button).
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB 
run;
close(from1);


% --- Executes on button press in pushbutton6 (Histogram Equalization Button).
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

a = get(handles.edit2,'String');
if isempty(a)  
    msgbox({'Invalid' 'Please select an image first'}, 'Error','error');  
else
    I = imread(a);
    
    try
        result = his_eq(I);
        imshow(result, 'parent', handles.axes2);
        title(handles.axes2, 'Histogram Equalization Result');
    catch ME
        % ??? ???? ?????? ???????? ?????? ???? MATLAB ???????
        try
            if size(I, 3) == 3
                % ???? RGB: ????? histogram equalization ??? ?? ????
                result = I;
                for ch = 1:3
                    result(:,:,ch) = histeq(I(:,:,ch));
                end
            else
                % ???? Grayscale
                result = histeq(I);
            end
            
            imshow(result, 'parent', handles.axes2);
            title(handles.axes2, 'Histogram Equalization (MATLAB)');
        catch
            msgbox({'Error in histogram equalization:' ME.message}, 'Processing Error', 'error');
        end
    end
end