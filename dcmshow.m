function varargout = dcmshow(varargin)
% DCMSHOW MATLAB code for dcmshow.fig
%      DCMSHOW, by itself, creates a new DCMSHOW or raises the existing
%      singleton*.
%
%      H = DCMSHOW returns the handle to a new DCMSHOW or the handle to
%      the existing singleton*.
%
%      DCMSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCMSHOW.M with the given input arguments.
%
%      DCMSHOW('Property','Value',...) creates a new DCMSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dcmshow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dcmshow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dcmshow

% Last Modified by GUIDE v2.5 12-Feb-2019 23:08:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dcmshow_OpeningFcn, ...
                   'gui_OutputFcn',  @dcmshow_OutputFcn, ...
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

function dcmshow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dcmshow (see VARARGIN)

% Choose default command line output for dcmshow
handles.output = hObject;
if(nargin<5)
    handles.ww=[];
    if(nargin<4)
        handles.a=zeros(512,512,2);
    else
        handles.a=varargin{1};
    end
else
    handles.a=varargin{1};
    handles.ww=varargin{2};
end
if(size(handles.a,3)==1)
    D=zeros(size(handles.a,1),size(handles.a,2),2);
    D(:,:,1)=handles.a;
    handles.a=D;
end
handles.a(isnan(handles.a)) = 0;
handles.actualimage=handles.a(:,:,1);
imshow(handles.a(:,:,1),handles.ww,'Parent',handles.axes1);
handles.min_value=num2str(min(handles.a(:)));
handles.max_value=num2str(max(handles.a(:)));
handles.roi_flag=0;
handles.matriz_aux=[0 0 0];
handles.contador=0;
handles.folder='null';
set(handles.minimo,'String',strcat('Min value:',handles.min_value));
set(handles.maximo,'String',strcat('Max value:',handles.max_value));
set(handles.slider1,'Max',size(handles.a,3));
set(handles.slider1,'SliderStep',[1/size(handles.a,3) 0.1]);
set(handles.text3,'String',strcat('1/',num2str(size(handles.a,3))));
warning('off','all')
% Update handles structure
guidata(hObject, handles);


function varargout = dcmshow_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function figure1_CreateFcn(hObject, eventdata, handles)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
handles.slide=uint16(get(handles.slider1,'Value'));
size_r=size(handles.a,3);
handles.actualimage=handles.a(:,:,handles.slide);
imshow(handles.actualimage,handles.ww,'Parent',handles.axes1);
set(handles.text3,'String',strcat(num2str(handles.slide),'/',num2str(size_r)));
guidata(hObject,handles);

function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
zoom on

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
pan on

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
min=get(handles.min,'String');
min=str2double(min);
max=get(handles.max,'String');
max=str2double(max);
if (max>min && (~isnan(max) || ~isnan(min)))
    handles.ww=[min max];
    imshow(handles.actualimage,handles.ww,'Parent',handles.axes1);
    guidata(hObject,handles);
else
    msgbox('not valid');
end


function pushbutton3_Callback(hObject, eventdata, handles)
handles.ww=[str2double(handles.min_value) str2double(handles.max_value)];
imshow(handles.actualimage,handles.ww,'Parent',handles.axes1);
guidata(hObject,handles);


function pushbutton5_Callback(hObject, eventdata, handles)
handles.ww=[-200 200];
imshow(handles.actualimage,handles.ww,'Parent',handles.axes1);
guidata(hObject,handles);



function pushbutton6_Callback(hObject, eventdata, handles)
handles.ww=[-500 500];
imshow(handles.actualimage,handles.ww,'Parent',handles.axes1);
guidata(hObject,handles);



function min_Callback(hObject, eventdata, handles)

function min_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double


% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
if(handles.roi_flag)
    if(~get(handles.checkbox2,'Value'))
         handles.roi= roipoly();
    end
else
    handles.roi= roipoly();
    handles.roi_flag=1;
end
[std, mean]= roisd(handles.actualimage,handles.roi);
set(handles.text13,'String',strcat('std:',num2str(std)));
set(handles.text14,'String',strcat('media:',num2str(mean)));
auxiliar=[handles.contador std mean];
handles.matriz_aux=[handles.matriz_aux;auxiliar];
handles.contador=handles.contador+1;
guidata(hObject,handles);


function pushbutton12_Callback(hObject, eventdata, handles)
datacursormode on


function pushbutton13_Callback(hObject, eventdata, handles)
figure;
imshow(handles.actualimage,handles.ww);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
imdistline();
guidata(hObject,handles);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
plotedit on


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
[FileName,PathName] = uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Save Image');
FileName=strcat(PathName,FileName);
aux=handles.actualimage-min(handles.actualimage(:));
aux=aux/max(aux(:));
imwrite(aux,FileName);


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
assignin('base','statistics',handles.matriz_aux)




% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
close(dcmshow)
filtertool(handles.a);

%%close_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
infoflagg=1;
try
var_name=inputdlg('Inserte vector con metadata','Load');
handles.info=evalin('base',var_name{:});
catch
infoflagg=0;
end
if infoflagg
handles.folder=escribirdcm(handles.a,handles.info);
else
handles.folder=escribirdcm(handles.a);
end
guidata(hObject,handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
