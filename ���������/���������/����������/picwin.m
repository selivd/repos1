function varargout = picwin(varargin)



gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @picwin_OpeningFcn, ...
                   'gui_OutputFcn',  @picwin_OutputFcn, ...
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


% --- Executes just before picwin is made visible.
function picwin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to picwin (see VARARGIN)
hold off;
t=varargin{1};
gc_x=varargin{2}{1}; 
gc_y=varargin{2}{2}; 
fig=figure;
%h=axes;
%set(hObject,'CurrentAxes',handles.axes1);

if(nargin>3)
    plane=varargin{3};
    tube = varargin{4};
    prs=projection(tube,plane);hold on;
    Opt.shade = 0.2;
 %   plot_ia(prs,'b',Opt);
    
end
if(nargin>4)
    eia_tube=varargin{5};
    plot_ia(eia_tube,'g',Opt); hold on;
    plot_ea(eia_tube,'r',Opt);
   % plot_ea(prs,'k',Opt);
%    plot_ea(eia_tube,'k',Opt); hold on;
end


n_planes = length(gc_x);
for i = 1:n_planes
    plot3(t,gc_x{i}',gc_y{i}','Linewidth',2,'Color','r');hold on;
end;

set(handles.ch_extern,'value',1);
set(handles.ch_precise,'value',1);
set(handles.ch_intern,'value',1);
set(handles.ch_goodc,'value',1);



rotate3d on;
% Choose default command line output for picwin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(hObject,'CurrentAxes',handles.axes1);
% UIWAIT makes picwin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = picwin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ch_goodc.
function ch_goodc_Callback(hObject, eventdata, handles)
h=get(handles.axes1,'children');
for i=1:length(h)
    if (strcmp(get(h(i),'type'),'line'))
        if(get(hObject,'value')==1.0)
            set(h(i),'visible','on');
        else
            set(h(i),'visible','off');
        end;
    end;
end;

% --- Executes on button press in ch_precise.
function ch_precise_Callback(hObject, eventdata, handles)
h=get(handles.axes1,'children');
for i=1:length(h)
    if (strcmp(get(h(i),'type'),'patch'))
        c=get(h(i),'FaceVertexCData'); clr= c(1,:);
        if(clr(1)==0 && clr(2)==0 && clr(3)==0)
            if(get(hObject,'value')==1.0)
                set(h(i),'visible','on');
            else
                set(h(i),'visible','off');
            end;
        end;
    end;
end;

% --- Executes on button press in ch_extern.
function ch_extern_Callback(hObject, eventdata, handles)
h=get(handles.axes1,'children');
for i=1:length(h)
    if (strcmp(get(h(i),'type'),'patch'))
        c=get(h(i),'FaceVertexCData'); clr = c(1,:);
        if(clr(1)==1 && clr(2)==0 && clr(3)==0)
            if(get(hObject,'value')==1.0)
                set(h(i),'visible','on');
            else
                set(h(i),'visible','off');
            end;
        end;
    end;
end;

% --- Executes on button press in ch_intern.
function ch_intern_Callback(hObject, eventdata, handles)
h=get(handles.axes1,'children');
for i=1:length(h)
    if (strcmp(get(h(i),'type'),'patch'))
        c=get(h(i),'FaceVertexCData'); clr = c(1,:);
        if(clr(1)==0 && clr(2)==1 && clr(3)==0)
            if(get(hObject,'value')==1.0)
                set(h(i),'visible','on');
            else
                set(h(i),'visible','off');
            end;
        end;
    end;
end;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
ax=handles.axes1;
saveas(ax,['pic' '.eps'],'psc2');

