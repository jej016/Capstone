function varargout = GUIDE_GUI(varargin)
% GUIDE_GUI MATLAB code for GUIDE_GUI.fig
%      GUIDE_GUI, by itself, creates a new GUIDE_GUI or raises the existing
%      *.
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
% Last Modified by GUIDE v2.5 16-Apr-2017 16:48:37

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
g = f.file_path(1:length(f.file_path)-7);
ch1 = f.getChannelByName('Channel 1');
handles.data1 = ch1.getData(1);
ch2 = f.getChannelByName('Channel 2');
handles.data2 = ch2.getData(1);
ch3 = f.getChannelByName('Channel 3');
handles.data3 = ch3.getData(1);
handles.event = eventDetector.detector(g);

%handles.fig = handles.axes1;
handles.z = handles.data1;
handles.y = handles.data2;
handles.x = handles.data3;
subplot(3,1,1,'Parent',handles.uipanel3);
plot(handles.z);
title('Venous Pressure- Ear')
subplot(3,1,2,'Parent',handles.uipanel3);
plot(handles.y);
title('Venous Pressure- Limb')
subplot(3,1,3,'Parent',handles.uipanel3);
plot(handles.x);
title('Arterial Pressure- Neck')

% Choose default command line output for GUIDE_GUI
handles.output = hObject;

handles.left = 1;
handles.right = length(handles.z);

handles.eventLength = 30000;
handles.index = 1;

handles.tgroup = uitabgroup('Parent', handles.figure1);
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'Data');
set(handles.uipanel1,'Parent',handles.tab1)

% set arrays to use to generate list box
eventName = cell(1,length(handles.event.eventName));
itemsData = zeros(1,length(handles.event.eventName));
for i = 1:length(handles.event.eventName)
    eventName(i) = handles.event.eventName(i);
    itemsData(i) = i;
end
            
% set list box to event data
set(handles.listbox1,'string',['All Data' eventName]);
set(handles.listbox1,'Value',1)

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
resetGraph(hObject,eventdata, handles);
handles.left = 1;
handles.right = length(handles.z);
% Update handles structure
guidata(hObject, handles);

function resetGraph(hObject,eventdata, handles)
sub1=subplot(3,1,1);
sub2=subplot(3,1,2);
sub3=subplot(3,1,3);
delete(sub1);
delete(sub2);
delete(sub3);
subplot(3,1,1,'Parent',handles.uipanel3);
plot(handles.z)
title('Venous Pressure- Ear')
subplot(3,1,2,'Parent',handles.uipanel3);
plot(handles.y)
title('Venous Pressure- Limb')
subplot(3,1,3,'Parent',handles.uipanel3);
plot(handles.x);
title('Arterial Pressure- Neck')
guidata(hObject, handles);

% --- Executes on button press in FFT.
function FFT_Callback(hObject, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = fft(handles.z(handles.left:handles.right))/length(handles.z(handles.left:handles.right));
y = fft(handles.y(handles.left:handles.right))/length(handles.z(handles.left:handles.right));
z = fft(handles.x(handles.left:handles.right))/length(handles.z(handles.left:handles.right));
resetGraph(hObject,eventdata, handles);
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
guidata(hObject, handles);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
val = get(hObject,'Value');

if val ==  1
    handles.z = handles.data1;
    handles.y = handles.data2;
    handles.x = handles.data3;
    %handles.right = length(handles.z);
elseif val > 1
    handles.index = handles.event.eventIndex(val - 1);
    handles.z = handles.data1(handles.index:handles.index + handles.eventLength);
    handles.y = handles.data2(handles.index:handles.index + handles.eventLength);
    handles.x = handles.data3(handles.index:handles.index + handles.eventLength);
    %if handles.right > 30000
    %    handles.right = 30000;
    %end
end
handles.right = length(handles.z);
resetGraph(hObject,eventdata, handles);
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = figure();
x = handles.z(handles.left:handles.right);
y = handles.y(handles.left:handles.right);
z = handles.x(handles.left:handles.right);

% perform calculations for event
calc = CalcUnit.study(x, y, z);
                
% display calculatons in chart
ColumnName = {'Name','Max','Min','Average','Median','Std Dev','Variance'};
data = {'Signal1',calc.maxi(1),calc.mini(1),calc.avrg(1),calc.medi(1),calc.stdDev(1),calc.vari(1);'Signal2',calc.maxi(2),calc.mini(2),calc.avrg(2),calc.medi(2),calc.stdDev(2),calc.vari(2);'Signal3',calc.maxi(3),calc.mini(3),calc.avrg(3),calc.medi(3),calc.stdDev(3),calc.vari(3)};
t = uitable('Parent',f,'ColumnWidth', {150}, 'FontSize', 20, 'ColumnName', ColumnName, 'Data', data);

table_extent = get(t,'extent');
set(t,'Position',[1 1 table_extent(3) table_extent(4)])
figure_size = get(f,'outerposition');
desired_fig_size = [figure_size(1) figure_size(2) table_extent(3)+15 table_extent(4)+90];
set(f,'outerposition', desired_fig_size);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
    handles.eventLength = str2double(get(hObject,'String')) * 1000;
    if (length(handles.data1) ~= length(handles.z))
        handles.z = handles.data1(handles.index:handles.index + handles.eventLength);
        handles.y = handles.data2(handles.index:handles.index + handles.eventLength);
        handles.x = handles.data3(handles.index:handles.index + handles.eventLength);
        handles.right = handles.eventLength;
        resetGraph(hObject,eventdata, handles);
    end;
    guidata(hObject, handles);
        

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
