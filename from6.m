function varargout = from6(varargin)
% FROM6 MATLAB code for from6.fig
%      FROM6, by itself, creates a new FROM6 or raises the existing
%      singleton*.
%
%      H = FROM6 returns the handle to a new FROM6 or the handle to
%      the existing singleton*.
%
%      FROM6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FROM6.M with the given input arguments.
%
%      FROM6('Property','Value',...) creates a new FROM6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before from6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to from6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help from6

% Last Modified by GUIDE v2.5 28-Dec-2015 20:29:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @from6_OpeningFcn, ...
                   'gui_OutputFcn',  @from6_OutputFcn, ...
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


% --- Executes just before from6 is made visible.
function from6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to from6 (see VARARGIN)

% Choose default command line output for from6
handles.output = hObject;

% Set default values or instructions in edit boxes
set(handles.edit3, 'String', '0.1');      % Default rate for Uniform
set(handles.edit4, 'String', '0 255');    % Default range for Uniform
set(handles.edit7, 'String', '0.1');      % Default rate for Gaussian
set(handles.edit8, 'String', '0 25');     % Default mean and sigma for Gaussian
set(handles.edit9, 'String', '0 255');    % Default for Rayleigh
set(handles.edit10, 'String', '0.5');     % Default for Exponential
set(handles.edit11, 'String', '2 3');     % Default for Gamma

% Initialize image data
handles.currentImage = [];
handles.imagePath = '';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes from6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = from6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[m, n] = uigetfile({'*.bmp;*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.gif', ...
                   'Image Files (*.bmp, *.jpg, *.jpeg, *.png, *.tif, *.tiff, *.gif)';
                   '*.*', 'All Files (*.*)'}, ...
                   'Select an Image');

if isequal(m, 0) || isequal(n, 0)
    return; % User cancelled
end

comp = fullfile(n, m);
set(handles.edit1, 'string', comp);

try
    % ????? ?????? ?? ?????? ???????
    img = readImageSafely(comp);
    
    % ????? ?????? ?? handles ????? ????? ???????
    handles.currentImage = img;
    handles.imagePath = comp;
    guidata(hObject, handles);
    
    imshow(img, 'parent', handles.axes1);
    title(handles.axes1, 'Original Image');
    
catch ME
    errordlg(['Error loading image: ', ME.message], 'Load Error');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.currentImage) && isempty(get(handles.edit1, 'String'))
    msgbox({'Invalid' 'please select image'}, 'Error','error');  
    return;
end

% ?????? ??? ?????? ?? handles ?? ?? ?????
I = getImageFromHandlesOrFile(handles);

if isempty(I)
    return;
end

e2 = get(handles.edit2, 'String');
if isempty(e2)  
    msgbox({'Invalid' 'please enter salt/pepper rate value'}, 'Error','error');  
else
    s = str2double(e2);
    if isnan(s)
        msgbox({'Invalid input' 'Please enter a valid number'}, 'Error','error');
        return;
    end
    
    switch get(handles.popupmenu1,'Value')  
        case 1
            % Salt noise
            N = saltnoise(I, s);
            imshow(N, 'parent', handles.axes2);
            title(handles.axes2, ['Salt Noise (rate: ' num2str(s) ')']);
        case 2
            % Pepper noise
            N = Peppernoise(I, s);
            imshow(N, 'parent', handles.axes2);
            title(handles.axes2, ['Pepper Noise (rate: ' num2str(s) ')']);
        otherwise
    end
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.currentImage) && isempty(get(handles.edit1, 'String'))
    msgbox({'Invalid' 'please select image'}, 'Error','error');  
    return;
end

% ?????? ??? ?????? ?? handles ?? ?? ?????
I = getImageFromHandlesOrFile(handles);

if isempty(I)
    return;
end

e3 = get(handles.edit3,'String');  % rate for uniform noise
e4 = get(handles.edit4,'String');  % range for uniform noise (should be TWO values)

if isempty(e3) || isempty(e4) 
    msgbox({'Invalid input' 'Please enter both rate and range values'}, 'Error','error');  
else
    rate_val = str2double(e3);
    if isnan(rate_val)
        msgbox({'Invalid rate' 'Please enter a valid number for rate'}, 'Error','error');
        return;
    end
    
    range_vals = str2num(e4); %#ok<ST2NM>
    
    % Check if range contains TWO values
    if numel(range_vals) < 2
        msgbox({'Invalid range input' 'Please enter TWO values for range (e.g., "0 255" or "-10 10")'}, 'Error','error');
        return;
    end
    
    % Apply uniform noise
    try
        N = uniformNoise(I, rate_val, range_vals(1), range_vals(2));
        imshow(N, 'parent', handles.axes2);
        title(handles.axes2, sprintf('Uniform Noise (rate: %g, range: [%g %g])', ...
              rate_val, range_vals(1), range_vals(2)));
    catch ME
        errordlg(['Error applying uniform noise: ', ME.message], 'Processing Error');
    end
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.currentImage) && isempty(get(handles.edit1, 'String'))
    msgbox({'Invalid' 'please select image'}, 'Error','error');  
    return;
end

% ?????? ??? ?????? ?? handles ?? ?? ?????
I = getImageFromHandlesOrFile(handles);

if isempty(I)
    return;
end

e7 = get(handles.edit7,'String');  % rate for gaussian noise
e8 = get(handles.edit8,'String');  % mean and sigma for gaussian noise

if isempty(e7) || isempty(e8) 
    msgbox({'Invalid input' 'Please enter both rate and (mean sigma) values'}, 'Error','error');  
else
    rate_val = str2double(e7);
    if isnan(rate_val)
        msgbox({'Invalid rate' 'Please enter a valid number for rate'}, 'Error','error');
        return;
    end
    
    params = str2num(e8); %#ok<ST2NM>
    
    % Check if params contains TWO values
    if numel(params) < 2
        msgbox({'Invalid input' 'Please enter TWO values for mean and sigma (e.g., "0 25")'}, 'Error','error');
        return;
    end
    
    % Apply gaussian noise
    try
        N = gaussianNoise(I, rate_val, params(1), params(2));
        imshow(N, 'parent', handles.axes2);
        title(handles.axes2, sprintf('Gaussian Noise (rate: %g, mean: %g, sigma: %g)', ...
              rate_val, params(1), params(2)));
    catch ME
        errordlg(['Error applying gaussian noise: ', ME.message], 'Processing Error');
    end
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.currentImage) && isempty(get(handles.edit1, 'String'))
    msgbox({'Invalid' 'please select image'}, 'Error','error');  
    return;
end

% ?????? ??? ?????? ?? handles ?? ?? ?????
I = getImageFromHandlesOrFile(handles);

if isempty(I)
    return;
end

e9 = get(handles.edit9,'String');  % parameters for rayleigh noise

if isempty(e9)  
    msgbox({'Invalid' 'please enter parameters for Rayleigh noise'}, 'Error','error');  
else
    params = str2num(e9); %#ok<ST2NM>
    
    % Check if params contains TWO values
    if numel(params) < 2
        msgbox({'Invalid input' 'Please enter TWO parameters for Rayleigh noise (e.g., "0 255")'}, 'Error','error');
        return;
    end
    
    % Apply rayleigh noise
    try
        N = rayligh_noise(I, params(1), params(2));
        imshow(N, 'parent', handles.axes2);
        title(handles.axes2, sprintf('Rayleigh Noise (a: %g, b: %g)', params(1), params(2)));
    catch ME
        errordlg(['Error applying Rayleigh noise: ', ME.message], 'Processing Error');
    end
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.currentImage) && isempty(get(handles.edit1, 'String'))
    msgbox({'Invalid' 'please select image'}, 'Error','error');  
    return;
end

% ?????? ??? ?????? ?? handles ?? ?? ?????
I = getImageFromHandlesOrFile(handles);

if isempty(I)
    return;
end

e10 = get(handles.edit10,'String');  % parameter for exponential noise

if isempty(e10)  
    msgbox({'Invalid' 'please enter parameter for Exponential noise'}, 'Error','error');  
else
    param = str2double(e10);
    
    % Check if param is valid
    if isnan(param)
        msgbox({'Invalid input' 'Please enter a valid number for Exponential noise'}, 'Error','error');
        return;
    end
    
    % Apply exponential noise (takes single parameter)
    try
        N = exp_noise(I, param);
        imshow(N, 'parent', handles.axes2);
        title(handles.axes2, sprintf('Exponential Noise (lambda: %g)', param));
    catch ME
        errordlg(['Error applying exponential noise: ', ME.message], 'Processing Error');
    end
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.currentImage) && isempty(get(handles.edit1, 'String'))
    msgbox({'Invalid' 'please select image'}, 'Error','error');  
    return;
end

% ?????? ??? ?????? ?? handles ?? ?? ?????
I = getImageFromHandlesOrFile(handles);

if isempty(I)
    return;
end

e11 = get(handles.edit11,'String');  % parameters for gamma noise

if isempty(e11)  
    msgbox({'Invalid' 'please enter parameters for Gamma noise'}, 'Error','error');  
else
    params = str2num(e11); %#ok<ST2NM>
    
    % Check if params contains TWO values
    if numel(params) < 2
        msgbox({'Invalid input' 'Please enter TWO parameters for Gamma noise (e.g., "2 3")'}, 'Error','error');
        return;
    end
    
    % Apply gamma noise
    try
        N = gamma_noise(I, params(1), params(2));
        imshow(N, 'parent', handles.axes2);
        title(handles.axes2, sprintf('Gamma Noise (a: %g, b: %g)', params(1), params(2)));
    catch ME
        errordlg(['Error applying gamma noise: ', ME.message], 'Processing Error');
    end
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
run;
close(from6);


% ================================================
% ?????? ???????? ??? ????? ????? TIFF
% ================================================

function img = readImageSafely(filepath)
% ????? ?????? ?????? ???? ?? ?????? ????? TIFF
try
    % ?????? ????? ?????? ???????? ??????? ?????
    img = imread(filepath);
    
    % ??? ???? ?????? TIFF ????? ???? ?????? ???? ??????? ?????? ??????
    [~, ~, ext] = fileparts(filepath);
    if strcmpi(ext, '.tif') || strcmpi(ext, '.tiff')
        % ???? ????? ?????? ??????? ????? ??????
        warning('off', 'all');
        try
            % ????? ????? ?????? TIFF
            info = imfinfo(filepath);
            img = imread(filepath, 'Info', info);
        catch
            % ??? ????? ???? ????? ?????? ??? ???? ????? ????
            img = im2double(imread(filepath));
        end
        warning('on', 'all');
    end
    
    % ????? ??? grayscale ??? ???? ???? ?????
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
catch ME
    % ??? ???? ???? ?????????? ???? ????? ???
    rethrow(ME);
end

function I = getImageFromHandlesOrFile(handles)
% ?????? ??? ?????? ?? handles ??? ???? ?????? ?? ?? ?????
I = [];

try
    % ????? ???? ?????? ?? handles
    if ~isempty(handles.currentImage)
        I = handles.currentImage;
        return;
    end
    
    % ??? ?? ??? ?? handles? ???? ?? ?????
    filepath = get(handles.edit1, 'String');
    if ~isempty(filepath)
        I = readImageSafely(filepath);
        
        % ????? ?????? ?? handles ????????
        handles.currentImage = I;
        guidata(handles.output, handles);
    end
    
catch ME
    errordlg(['Error loading image: ', ME.message], 'Load Error');
end