function varargout = guiProject(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiProject_OpeningFcn, ...
                   'gui_OutputFcn',  @guiProject_OutputFcn, ...
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

function guiProject_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = guiProject_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


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


function correlationFilter_Callback(hObject, eventdata, handles)
img=handles.a;
option=getappdata(0,'optioncorrelation');
mask= [0 -1 0; -1 5 -1; 0 -1 0];
img=im2double(img);

[h ,w]=size(img);
masksize=length(mask);
padsize = (masksize-1)/2;



%zero padding
if option==1
    S=zeros(h, w);
    img=padarray(img, [padsize padsize]);
    for i=1:h
        for j=1:w
        subimg = img(i:i+2*padsize, j:j+2*padsize);
        S(i,j) = sum(sum(subimg .* mask));
        %clipping values out of range
        if S(i,j) < 0
            S(i,j)=0;
        elseif S(i,j)>255
            S(i,j)=255;
        end
        end
    end
    
%row duplication
elseif option==2
    S=zeros(h, w);
    img=padarray(img, [padsize padsize], 'symmetric');
    for i=1:h
        for j=1:w
        subimg = img(i:i+2*padsize, j:j+2*padsize);
        S(i,j) = sum(sum(subimg .* mask));
        %clipping values out of range
        if S(i,j) < 0
            S(i,j)=0;
        elseif S(i,j)>255
            S(i,j)=255;
        end
        end
    end
    
%ignore boarder
else
    S=zeros(h-2*padsize, w-2*padsize);
    for i=1: h-2*padsize
        for j=1: w-2*padsize
        subimg = img(i:i+2*padsize, j:j+2*padsize);
        S(i,j) = sum(sum(subimg .* mask));
        %clipping values out of range
        if S(i,j) < 0
            S(i,j)=0;
        elseif S(i,j)>255
            S(i,j)=255;
        end
        end
    end
end

%S = im2uint8(S);
axes(handles.axes2);
imshow(S);


function Butterworth_Callback(hObject, eventdata, handles)
image=handles.a;
option=getappdata(0,'FilterOption');
D0=getappdata(0,'Dbutter');

%image=im2double(image);
[M,N] = size(image);
wM = zeros(M, M);
wN = zeros(N, N);
for u = 0 : (M - 1)
    for x = 0 : (M - 1)
        wM(u+1, x+1) = exp(-2 * pi * 1i / M * x * u);
    end    
end

for v = 0 : (N - 1)
    for y = 0 : (N - 1)
        wN(y+1, v+1) = exp(-2 * pi * 1i / N * y * v);
    end    
end

FI = wM * double(image) * wN;
FIS = fftshift(FI);


filter=zeros(M, N);

if option == 1
    for i=1:M
        for j=1:N
            dis=sqrt((i-(M/2)).^2+(j-(N/2)).^2);
            if dis<=D0
                filter(i,j)=1/(1+(dis/D0)^2);    %lowpass
            end
        end
    end

else 
    for i=1:M
        for j=1:N
            dis=sqrt((i-(M/2)).^2+(j-(N/2)).^2);
            if dis>=D0
                filter(i,j)=1/(1+(D0/dis)^2);    %heighpass
            end
        end
    end
end

RF = real(FIS).*filter;
ImagF = imag(FIS).*filter;
New_Image = RF + ImagF*1i;

S = Normalize_Fourier_Valid_To_Imshow(ifft2(New_Image));

    
%S = im2uint8(S);
axes(handles.axes2);
imshow(S);   


function Idealfilter_Callback(hObject, eventdata, handles)
image=handles.a;
option=getappdata(0,'FilterOption');
D0=getappdata(0,'Dideal');
%image=im2double(image);

[M,N] = size(image);
wM = zeros(M, M);
wN = zeros(N, N);
for u = 0 : (M - 1)
    for x = 0 : (M - 1)
        wM(u+1, x+1) = exp(-2 * pi * 1i / M * x * u);
    end    
end

for v = 0 : (N - 1)
    for y = 0 : (N - 1)
        wN(y+1, v+1) = exp(-2 * pi * 1i / N * y * v);
    end    
end

FI = wM * double(image) * wN;
FIS = fftshift(FI);


filter=zeros(M, N);

for i=1:M
    for j=1:N
        dis=sqrt((i-(M/2)).^2+(j-(N/2)).^2);
        if dis<=D0
            filter(i,j)=1;
        end
    end
end

%heighpass filter
    if option==2
        filter=1-filter;
    end

RF = real(FIS).*filter;
ImagF = imag(FIS).*filter;
New_Image = RF + ImagF*1i;

S = Normalize_Fourier_Valid_To_Imshow(ifft2(New_Image));

%S = im2uint8(S);
axes(handles.axes2);
imshow(S);   


function GuassianFilter_Callback(hObject, eventdata, handles)
image=handles.a;
option=getappdata(0,'FilterOption');
D0=getappdata(0,'guassD0');

S = GaussianFilterUpdated(image,D0,option);


axes(handles.axes2);
imshow(S);   


function domain_Callback(hObject, eventdata, handles)
image=handles.a;
option=getappdata(0,'domainop');
%image=im2double(image);

%option1 -> spatial 2 frequancy
if option==1
    S=fft2(image);
    S=fftshift(S);
%frequancy 2 spatial
else
    S=fftshift(image);
    S=ifft2(S);
end
S=abs(S);    %deal with complix numbers
S=log(1+S);  %brightness
S=mat2gray(S);  %normalization

%S = im2uint8(S);
axes(handles.axes2);
imshow(S);    


function correlationoption_Callback(hObject, eventdata, handles)
a=str2num(get(handles.correlationoption,'String'));
setappdata(0,'optioncorrelation',a);

function correlationoption_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function butterd0_Callback(hObject, eventdata, handles)
a=str2num(get(handles.butterd0,'String'));
setappdata(0,'Dbutter',a);

function butterd0_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function idealD_Callback(hObject, eventdata, handles)
a=str2num(get(handles.idealD,'String'));
setappdata(0,'Dideal',a);

function idealD_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function guassD_Callback(hObject, eventdata, handles)
a=str2num(get(handles.guassD,'String'));
setappdata(0,'guassD0',a);

function guassD_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function domainop_Callback(hObject, eventdata, handles)
a=str2num(get(handles.domainop,'String'));
setappdata(0,'domainop',a);

function domainop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lowhighlist_Callback(hObject, eventdata, handles)
a=get(handles.lowhighlist,'value');

switch a 
    case 1
        setappdata(0,'FilterOption',a);
    case 2 
        setappdata(0,'FilterOption',a);
end

function lowhighlist_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Back_Callback(hObject, eventdata, handles)
FirstTap
closereq();
