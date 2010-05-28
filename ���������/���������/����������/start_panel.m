function varargout = start_panel(varargin)
% START_PANEL M-file for start_panel.fig
%      START_PANEL, by itself, creates a new START_PANEL or raises the existing
%      singleton*.
%

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_panel_OpeningFcn, ...
                   'gui_OutputFcn',  @start_panel_OutputFcn, ...
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


% --- Executes just before start_panel is made visible.
function start_panel_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to start_panel (see VARARGIN)

% Choose default command line output for start_panel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes start_panel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = start_panel_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btBuild.
function btBuild_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to btBuild (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global ellOptions;
global start_glob;

if ~isstruct(ellOptions)
  evalin('base', 'ellipsoids_init;');
end

ellOptions.time_grid=20;
task_num=   get(handles.rb_stat,'value')...
         +2*get(handles.rb_dyn,'value')...
         +3*get(handles.rb_3d,'value');

switch task_num
    case 1,
        solve_static(handles);
    case 2,
        solve_dynamic(handles);
    case 3,
        start_glob.M=solve_3d(handles);
end;






% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global start_glob;

start_glob=load ('set_calcs.mat');
S=start_glob;

picwin(S.t,  {S.gc_x,S.gc_y},S.plane, S.tube, S.eia_tube);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global start_glob;
t       = start_glob.t;
tube    = start_glob.tube;
eia_tube= start_glob.eia_tube;
gc_x    = start_glob.gc_x;
gc_y    = start_glob.gc_y;
plane   = start_glob.plane;

value = get(hObject,'value');
t_i=round( (length(t)-1) * value +1 );
str=num2str(t(t_i));
set(handles.edt_tcut,'String', str);
ct= cut(tube,t(t_i));
real_prs= projection(ct,plane);
opt.shade=0.2;
act= cut(eia_tube,t(t_i));

for i=1:length(gc_x)
    xx(i)=gc_x{i}(t_i);
    yy(i)=gc_y{i}(t_i);
end;


if (isfield(start_glob,'snapshot_window'))
    start_glob.snapshot_window= figure(start_glob.snapshot_window);
else
    start_glob.snapshot_window = figure;
end;

plot_ia(real_prs,opt);hold on;
opt.color=[1 1 0];
plot_ia(act,opt);hold on;
opt.color=[0 1 1];
plot_ea(act,opt); hold on;
plot(xx,yy,'or');
    


function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes during object creation, after setting all properties.
function edt_tcut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_tcut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edt_nplanes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_nplanes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on button press in btn_task.
function btn_task_Callback(hObject, eventdata, handles)
% hObject    handle to btn_task (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit('GetTask.m');


% --- Executes on button press in btn_refresh.
function btn_refresh_Callback(hObject, eventdata, handles)
% hObject    handle to btn_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
task=GetTask;
v1=zeros(size(task.A,1),1);
v2=v1;
v1(1)=1;
v2(2)=1;

set(handles.edt_v1,'String',num2str(v1'));
set(handles.edt_v2,'String',num2str(v2'));



% --- Executes during object creation, after setting all properties.
function edt_v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edt_v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_nplanes_Callback(hObject, eventdata, handles)
% hObject    handle to edt_nplanes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_nplanes as text
%        str2double(get(hObject,'String')) returns contents of edt_nplanes as a double



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
