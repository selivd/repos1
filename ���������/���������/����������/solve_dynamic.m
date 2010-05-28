function solve_dynamic(handles)
global start_glob;
global ellOptions;

ellOptions.time_grid=30;
%================== внутренние переменные ================
%===================== входные данные ====================

task=GetTask;

A=task.A;
U=task.eU;
B=task.B;
X0=task.X0;

n_planes = round(str2double(get(handles.edt_nplanes,'string')));
n_realpls = task.n_realplanes;

%плоскость сечени€, задаваема€ двум€ векторами

v1=str2num(get(handles.edt_v1,'string'))';
v2=str2num(get(handles.edt_v2,'string'))';
T=str2double(get(handles.edit3,'String'));

lsys = task.lsys;
plane = ort(v1,v2);
vset=@(alpha)([sin(alpha);cos(alpha)]);

savenon.save_all=0;
savenon.approximation=2;
 
saveall.save_all = 2;

          
%================== точное множество =====================
num_v2=round((n_realpls+1)/2);
rstep=pi/n_realpls;
ralpha=0:rstep:pi-rstep;
rdir=plane*vset(ralpha);
 
  
real_rs=reach(lsys,X0,rdir,[0 T],saveall);
dirs=get_directions(real_rs);
dir1=dirs{1};
dir2=dirs{num_v2-1};

gc_rs=reach(lsys,X0,plane,[0,T],savenon);
[L t] = get_goodcurves(gc_rs);




for i=1:length(L) [gc_x{i} gc_y{i}]=Proj(L{i},plane);end;


%=================== ƒинамическа€ плоскость ==============
%  аждый раз мы сдвигаем базис проекции так, чтобы один из векторов базиса
% (первый) всегда указывал на вектор плоскости касани€. “огда проекци€ хорошей кривой
% будет касатьс€ проекции всех нужных множеств.

step = pi/n_planes;
alpha=0:step:pi-step;

dirs_0=plane*vset(alpha);

rs=reach(lsys,X0,dirs_0,[0 T],saveall);
[gc,t]=get_goodcurves(rs);
dyn_plane=cell(length(t),1);
goodk=cell(length(alpha),1);
for i=1:length(t)
    dyn_plane{i}=ort(dir1(:,i),dir2(:,i));
    for k=1:length(alpha)
        goodk{k}(:,i)=dyn_plane{i}'*gc{k}(:,i);
    end;
end;


good_v=[];slices=[];
for i=2:length(t)-1
   
    ct=cut(rs,[t(i-1),t(i+1)]);
    
    slice=projection(ct,dyn_plane{i});
    
    if isempty(slices)
        slices=slice;
    else
        slices=[slices slice];
    end;
end;



figure;
hold on;
opt.shade=0.05;
for i=1:length(slices)
    plot_ea(slices(i),'b',opt);
    
    plot_ia(slices(i),'g');
end;

for k=1:length(alpha)
    plot3(t(2:end-1),goodk{k}(1,2:end-1)',goodk{k}(2,2:end-1)','ro-');hold on;
end;
rotate3d on;


