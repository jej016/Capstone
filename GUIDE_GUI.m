function varargout = GUIDE_GUI(varargin)
% GUIDE_GUI MATLAB code for GUIDE_GUI.fig
%      GUIDE_GUI, by itself, creates a new GUIDE_GUI or raises the existing
%      singleton*.
%
%      H = GUIDE_GUI returns the handle to a new GUIDE_GUI or the handle to
%      the existing singleton*.
%
%      GUIDE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_GUI.M with the given input arguments.
%
%      GUIDE_GUI('Property','Value',...) creates a new GUIDE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIDE_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIDE_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIDE_GUI
% Last Modified by GUIDE v2.5 07-Mar-2017 18:08:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIDE_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIDE_GUI_OutputFcn, ...
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


% --- Executes just before GUIDE_GUI is made visible.
function GUIDE_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIDE_GUI (see VARARGIN)
f = adi.readFile;
ch1 = f.getChannelByName('Channel 1');
data1 = ch1.getData(1);
ch2 = f.getChannelByName('Channel 2');
data2 = ch2.getData(1);
ch3 = f.getChannelByName('Channel 3');
data3 = ch3.getData(1);

%handles.fig = handles.axes1;
handles.z = data1;
handles.y = data2;
handles.x = data3;
subplot(3,1,1,'Parent',handles.uipanel1);
plot(handles.z);
title('Venous Pressure- Ear')
subplot(3,1,2,'Parent',handles.uipanel1);
plot(handles.y);
title('Venous Pressure- Limb')
subplot(3,1,3,'Parent',handles.uipanel1);
plot(handles.x);
title('Arterial Pressure- Neck')

% Choose default command line output for GUIDE_GUI
handles.output = hObject;

handles.left = 1;
handles.right = length(handles.z);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIDE_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIDE_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SetLimit.
function SetLimit_Callback(hObject, eventdata, handles)
% hObject    handle to SetLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold;
sub1=subplot(3,1,1);
sub2=subplot(3,1,2);
sub3=subplot(3,1,3);
[handles.left,~] = ginput(1);
y1 = ylim(sub1);
y2 = ylim(sub2);
y3 = ylim(sub3);
line([handles.left,handles.left], y1,'parent',sub1);
line([handles.left,handles.left], y2,'parent',sub2);
line([handles.left,handles.left], y3,'parent',sub3);

[handles.right,~] = ginput(1);
y4 = ylim(sub1);
y5 = ylim(sub2);
y6 = ylim(sub3);
line([handles.right,handles.right], y4,'parent',sub1);
line([handles.right,handles.right], y5,'parent',sub2);
line([handles.right,handles.right], y6,'parent',sub3);
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in ClearLimits.
function ClearLimits_Callback(hObject, eventdata, handles)
% hObject    handle to ClearLimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%delete(handles.fig);
resetGraph(eventdata, handles);
handles.left = 1;
handles.right = length(handles.z);
% Update handles structure
guidata(hObject, handles);

function resetGraph(eventdata, handles)
sub1=subplot(3,1,1);
sub2=subplot(3,1,2);
sub3=subplot(3,1,3);
delete(sub1);
delete(sub2);
delete(sub3);
subplot(3,1,1,'Parent',handles.uipanel1);
plot(handles.z)
title('Venous Pressure- Ear')
subplot(3,1,2,'Parent',handles.uipanel1);
plot(handles.y)
title('Venous Pressure- Limb')
subplot(3,1,3,'Parent',handles.uipanel1);
plot(handles.x);
title('Arterial Pressure- Neck')

% --- Executes on button press in FFT.
function FFT_Callback(~, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = fft(handles.z(handles.left:handles.right))/length(handles.z(handles.left:handles.right));
y = fft(handles.z(handles.left:handles.right))/length(handles.z(handles.left:handles.right));
z = fft(handles.z(handles.left:handles.right))/length(handles.z(handles.left:handles.right));
resetGraph(eventdata, handles);
f = figure('Name', 'Fast Fourier Transforms');
subplot(3,1,1);
plot(abs(x));
title('FFT Venous Pressure- Ear')
subplot(3,1,2);
plot(abs(y));
title('FFT Venous Pressure- Limb')
subplot(3,1,3);
plot(abs(z));
title('FFT Arterial Pressure- Neck')
sub1=subplot(3,1,1);
sub2=subplot(3,1,2);
sub3=subplot(3,1,3);
ylim(sub1, [0 .005])
ylim(sub2, [0 .005])
ylim(sub3, [0 .005])
