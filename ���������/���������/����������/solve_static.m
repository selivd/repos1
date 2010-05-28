function solve_static(handles)

global start_glob;
global ellOptions;
%================== внутренние переменные ================
%===================== входные данные ====================

%L0=[[0 0 0 1]' , [0 0 1 0]'];
%x1=[0 0 0 1]'; 
%x2=[0 0 1 0]';

task=GetTask;

A=task.A;
U=task.eU;
B=task.B;
X0=task.X0;
C=task.C;
eV=task.eV;

n_planes = round(str2double(get(handles.edt_nplanes,'string')));
n_realpls = task.n_realplanes;

%плоскость сечения, задаваемая двумя векторами

v1=str2num(get(handles.edt_v1,'string'))';
v2=str2num(get(handles.edt_v2,'string'))';
T=str2double(get(handles.edit3,'String'));

lsys = task.lsys;
plane = ort(v1,v2);
vset=@(alpha)([sin(alpha);cos(alpha)]);

savenon.save_all=0;
savenon.approximation=2;
%================== точное множество =====================

rstep=pi/n_realpls;
ralpha=0:rstep:pi-rstep;
rdir=plane*vset(ralpha);
  saveall.save_all = 1;
  
real_rs=reach(lsys,X0,rdir,[0 T],saveall);
gc_rs=reach(lsys,X0,plane,[0,T],savenon);
[L t] = get_goodcurves(gc_rs);


%for i=1:length(L) [gc_x{i} gc_y{i}]=Proj(L{i},plane);end;



%proj=projection(real_rs,plane);

%f=figure;
%plot_ia(proj);hold on;
%for i=1:length(ralpha) plot3(t,gc_x{i},gc_y{i},'r');end;
    
%================== статическая плоскость =================

step = pi/n_planes;
alpha=0:step:pi-step;

dirs_0=plane*vset(alpha);



ea_val= [];
ia_val= [];
center= [];
l_value = [];
length(t)
start_time=tic;
for i = 2:length(t) %0-----|t1------|t2---...--|t_pieces
    ti = t(i) ;
    i
    % в каждый момент времени ti мы будем приходить в определенные точки
    % касания из точек dirs_0
    savenon.save_all=0;
    savenon.approximation=1;
    opt.save_all=1;
    
    time_grid=ellOptions.time_grid;
    ellOptions.time_grid=3;
    rs_0 = reach(lsys,X0,dirs_0,[ti 0],savenon);
    ellOptions.time_grid=time_grid;
    dirs=get_directions(rs_0);
    
    dirs_ti(size(A,1),length(alpha))=0;  %#ok<AGROW>
    % выцепляем направления dirs_ti, к которым пришли из dirs_0(ti)
    for k = 1:length(alpha),  dirs_ti(:,k)=dirs{k}(:,end); end; 
    
    % теперь из dirs_ti(0) приходим к dirs_0(ti) и получаем то, что хотим в точке ti 
    
    rs_ti= reach(lsys,X0,dirs_ti,[0 ti],opt);
    
  
    % вырезаем по каждому ti, то есть не колбаска порезаная, 
    % а прозрачными ломтиками - по одному эллипсоиду на сечение.
   
    check_dir=get_directions(rs_ti);
    for k=1:length(alpha), ch_dir(:,k)=check_dir{k}(:,end);end;
    
    if(sum(sum(abs(ch_dir-dirs_0)))>1e-9)
        error('dirs are not equal');
    end;
    
    
    if(i==2)
        korka=cut(rs_ti,t(1));
        proj = projection(korka,plane);
        cgc=get_goodcurves(korka);
        x=[];y=[];
        for k= 1:length(alpha)
            ea_val{k}(:,1)=proj.ea_values{k}; 
            ia_val{k}(:,1)=proj.ia_values{k}; 
             [x,y]=Proj(cgc{k},plane);
             gc_x{k}=x;
             gc_y{k}=y;
        end;
        center(:,1)=proj.center_values;
        
        
%        pr_dir(1)=get_directions(proj);
    end;
    
    lomtik_ti = cut(rs_ti,ti);
    cgc=get_goodcurves(lomtik_ti);
    proj = projection(lomtik_ti,plane);
    for k= 1:length(alpha), ea_val{k}(:,i)=proj.ea_values{k}; end;
    for k= 1:length(alpha), ia_val{k}(:,i)=proj.ia_values{k}; end;
    for k= 1:length(alpha), l_value{k}(:,i)=proj.l_values{k}; end;
     for k= 1:length(alpha)
         pr=cgc{k}'*plane;
         [x,y]=Proj(cgc{k},plane); 
         gc_x{k}=[gc_x{k},pr(:,1)];gc_y{k}=[gc_y{k},pr(:,2)];
     end;
    center(:,i)=proj.center_values;
 %   pr_dir(i)=get_directions(proj);
end
calc_time=toc(start_time);
sprintf('Время выполнения: %g \n',calc_time)

static_rs = get_rs(proj,t,center,ea_val,ia_val,l_value);
start_glob = [];

start_glob.t=t;
start_glob.gc_x=gc_x;
start_glob.gc_y=gc_y;
start_glob.plane=plane;
start_glob.tube=real_rs;
start_glob.eia_tube=static_rs;
start_glob.n_planes=n_planes;
start_glob.n_realpls = n_realpls;

save('set_calcs.mat','-struct', 'start_glob');

picwin(t,{gc_x,gc_y},plane,real_rs,static_rs);
    
   