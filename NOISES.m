function varargout = NOISES(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NOISES_OpeningFcn, ...
                   'gui_OutputFcn',  @NOISES_OutputFcn, ...
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

function NOISES_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = NOISES_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function saltnoise_Callback(hObject, eventdata, handles)
image=handles.a;
[h, w]=size(image);
global noisyImage
noisyImage=image;
percent=getappdata(0,'rate');
for i = 1:h %for loops iterate through every pixel
    for j = 1:w
        noise_check = randi(percent); %creates a random number between 1 and noise_percent
        if noise_check == percent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
          noisyImage(i,j) = 255; %replaces the original pixel value with the random noise
        end
    end
end

noisyImage = im2uint8(noisyImage);

axes(handles.axes2);
imshow(noisyImage);

function pepperNoise_Callback(hObject, eventdata, handles)
image=handles.a;
[h, w]=size(image);
global noisyImage
noisyImage=image;
percent=getappdata(0,'rate');

for i = 1:h %for loops iterate through every pixel
    for j = 1:w
        noise_check = randi(percent); %creates a random number between 1 and noise_percent
        if noise_check == percent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
           noisyImage(i,j) = 0; %replaces the original pixel value with the random noise
        end
    end
end

noisyImage = im2uint8(noisyImage);

axes(handles.axes2);
imshow(noisyImage);

function saltandpepper_Callback(hObject, eventdata, handles)
image=handles.a;
[h, w]=size(image);
global noisyImage
noisyImage=image;
percent=getappdata(0,'rate');

for i = 1:h %for loops iterate through every pixel
    for j = 1:w
        noise_check = randi(percent); %creates a random number between 1 and noise_percent
        if noise_check == percent    %if the random number = noise_percent (1/noise_percent chance of any given pixel being noisy)
          noise_value = randi(256);    %creates a random noise value to replace the pixel
          noisyImage(i,j) = noise_value; %replaces the original pixel value with the random noise
        end
    end
end
noisyImage = im2uint8(noisyImage);

axes(handles.axes2);
imshow(noisyImage);

function minimum_Callback(hObject, eventdata, handles)
global noisyImage
global im
im=noisyImage;
B=zeros(size(im));

modifyA=padarray(im,[1 1]);

        x=(1:2)';
        y=(1:2)';
       
for i= 1:size(modifyA,1)-2
    for j=1:size(modifyA,2)-2
      
       %VECTORIZED METHOD
       window=reshape(modifyA(i+x-1,j+y-1),[],1);

       %FIND THE MAXIMUM VALUE IN THE SELECTED WINDOW
        
       B(i,j)=min(window);
   
    end
end
B=uint8(B);

axes(handles.axes3);
imshow(B);

function maximum_Callback(hObject, eventdata, handles)
global noisyImage
im=noisyImage;
B=zeros(size(im));

modifyA=padarray(im,[1 1]);

        x=(1:2)';
        y=(1:2)';
       
for i= 1:size(modifyA,1)-2
    for j=1:size(modifyA,2)-2
      
       %VECTORIZED METHOD
       window=reshape(modifyA(i+x-1,j+y-1),[],1);

       %FIND THE MAXIMUM VALUE IN THE SELECTED WINDOW
        
       B(i,j)=max(window);
   
    end
end
B=uint8(B);

axes(handles.axes3);
imshow(B);
handles.B=B;
guidata(hObject, handles);

function median_Callback(hObject, eventdata, handles)
global noisyImage
A=noisyImage;
modifyA=zeros(size(A)+2);
B=zeros(size(A));

%COPY THE ORIGINAL IMAGE MATRIX TO THE PADDED MATRIX
        for x=1:size(A,1)
            for y=1:size(A,2)
                modifyA(x+1,y+1)=A(x,y);
            end
        end
      %LET THE WINDOW BE AN ARRAY
      %STORE THE 3-by-3 NEIGHBOUR VALUES IN THE ARRAY
      %SORT AND FIND THE MIDDLE ELEMENT
       
for i= 1:size(modifyA,1)-2
    for j=1:size(modifyA,2)-2
        window=zeros(9,1);
        inc=1;
        for x=1:3
            for y=1:3
                window(inc)=modifyA(i+x-1,j+y-1);
                inc=inc+1;
            end
        end
       
        med=sort(window);
        %PLACE THE MEDIAN ELEMENT IN THE OUTPUT MATRIX
        B(i,j)=med(5);
       
    end
end
B=uint8(B);
axes(handles.axes3);
imshow(B);


function browse_Callback(hObject, eventdata, handles)
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


function gaussianNoise_Callback(hObject, eventdata, handles)
image=handles.a;
variance=getappdata(0,'gaussSigma');
mean=getappdata(0,'gaussMean');

noisyImage=GaussianNoise(image,mean,variance);

axes(handles.axes2);
imshow(noisyImage);

function gaussianMean_Callback(hObject, eventdata, handles)
r=str2num(get(handles.gaussianMean,'String'));
setappdata(0,'gaussMean',r);

function gaussianMean_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gaussianSigma_Callback(hObject, eventdata, handles)
r=str2num(get(handles.gaussianSigma,'String'));
setappdata(0,'gaussSigma',r);

function gaussianSigma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Rayleigh_Callback(hObject, eventdata, handles)
image=handles.a;
a=getappdata(0,'rayleighA');
b=getappdata(0,'rayleighB');

newimage=RayleighNoise(image,a,b);

axes(handles.axes2);
imshow(newimage);

function rylighA_Callback(hObject, eventdata, handles)
r=str2num(get(handles.rylighA,'String'));
setappdata(0,'rayleighA',r);

function rylighA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rayleighB_Callback(hObject, eventdata, handles)
r=str2num(get(handles.rayleighB,'String'));
setappdata(0,'rayleighB',r);

function rayleighB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Gamaa_Callback(hObject, eventdata, handles)
image=handles.a;
a=getappdata(0,'gammaA');
b=getappdata(0,'gammaB');

newimage=GammaNoise(image,a,b);

axes(handles.axes2);
imshow(newimage);

function gammaA_Callback(hObject, eventdata, handles)
r=str2num(get(handles.gammaA,'String'));
setappdata(0,'gammaA',r);

function gammaA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gammaB_Callback(hObject, eventdata, handles)
r=str2num(get(handles.gammaB,'String'));
setappdata(0,'gammaB',r);

function gammaB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function uniform_Callback(hObject, eventdata, handles)
image=handles.a;
a=getappdata(0,'uniA');
b=getappdata(0,'uniB');

newimage=UniformNoise(image,a,b);

axes(handles.axes2);
imshow(newimage);

function uniformA_Callback(hObject, eventdata, handles)
r=str2num(get(handles.uniformA,'String'));
setappdata(0,'uniA',r);

function uniformA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uniformB_Callback(hObject, eventdata, handles)
r=str2num(get(handles.uniformB,'String'));
setappdata(0,'uniB',r);

function uniformB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function expo_Callback(hObject, eventdata, handles)
image=handles.a;
value=getappdata(0,'expoValue');

newimage=ExponentialNoise(image, value);

axes(handles.axes2);
imshow(newimage);

function exponentailValue_Callback(hObject, eventdata, handles)
r=str2num(get(handles.exponentailValue,'String'));
setappdata(0,'expoValue',r);

function exponentailValue_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function percent_Callback(hObject, eventdata, handles)
r=str2num(get(handles.percent,'String'));
setappdata(0,'rate',r);

function percent_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
