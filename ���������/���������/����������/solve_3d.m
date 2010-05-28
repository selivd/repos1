function M=solve_3d(handles)

global ellOptions;

ellOptions.time_grid=10;
%================== внутренние переменные ================
%===================== входные данные ====================

task=GetTask;

X0=task.X0;
lsys = task.lsys;
dim=dimension(lsys);

n_planes = round(str2double(get(handles.edt_nplanes,'string')));
n_realpls = task.n_realplanes;

%плоскость сечения, задаваемая векторами

L=Set3DDirections();
add=zeros(dim-size(L,2),size(L,2));
L=[L;add];


plane=eye(3);
add=zeros(dim-3,3);
plane=[plane;add];
plane=ort(plane);

T=str2double(get(handles.edit3,'String'));



savenon.save_all=0;
savenon.approximation=1;
 
saveall.save_all = 1;

          
%================== множество =====================
 
rs=reach(lsys,X0,L,[0 T],saveall);



[d,t]=get_directions(rs);
%ea=projection(ea,plane);

gc=get_goodcurves(rs);

% for k=1:length(gc)
%    pgc{k}=gc{k}'*plane;
% end;
   
dirs=get_directions(rs);
dir1=dirs{1};
dir2=dirs{2};
dir3=dirs{3};

dyn_plane=cell(length(t),1);
pgc=cell(size(L,2),1);
for i=1:length(t)
    dyn_plane{i}=ort([dir1(:,i),dir2(:,i),dir3(:,i)]);
    for k=1:size(L,2)
        pgc{k}(i,:)=gc{k}(:,i)'*dyn_plane{i};
    end;
end;

pea=cell(length(t),1);
for i=1:length(t)
    ct=cut(rs,t(i));
    pea{i}=projection(ct,dyn_plane{i});
end;


h=figure ;

axis square;

%  for k=1:length(L)
%     plot3(pgc{k}(:,1),pgc{k}(:,2),pgc{k}(:,3),'ro-');hold on;
%  end;
opt.shade=0.1;
M=[];
fp=2;
c1=[0 0 1];
c2=[1 0 0];
c3=[0 1 0];
start_i=2;
end_i=7;
for i=start_i:end_i
    al=(i-1)/(length(t)-1);
    if even(i) 
        col=c1; 
    else
        col=c2;
    end;
    al=1;
    opt.color=al*col+(1-al)*c3;
    
    plot_ea(pea{i},opt);hold on;
    for k=1:size(L,2)   
        plot3(pgc{k}(start_i:i,1),pgc{k}(start_i:i,2),pgc{k}(start_i:i,3),'ko-');hold on;
    end;
    if(isempty(M))
        M=getframe;
        M(3*length(t)+100)=M(1);
        M(3*length(t)+100)=[];
    else
        M(fp)=getframe;
        fp=fp+1;
    end;
end;

fprintf('finish');
    for i=1:20
	camorbit(i*1,0.1*i,'camera')
 	M(fp)=getframe;
     fp=fp+1;
end
 M=M(1:fp-1);
 movie(M,2);




