% function  test
task=GetTask;

basis=[1 0 0 ;
       0 1 0 ]';

nel=6;
step=2*pi/nel;

al=0:step:2*pi-step;
   
dirs=[cos(al);sin(al)];
rdir=basis*dirs;

opt.save_all=1;
opt.approximation=2;
rs=reach(task.lsys,task.X0,rdir,5,opt);

[LL,tt]=get_goodcurves(rs);

for i=1:length(al) 
    lv=LL{i};
    gc_x=basis(:,1)'*lv/norm(basis(:,1));
    gc_y=basis(:,2)'*lv/norm(basis(:,2));
    p_x{i}=gc_x;
    p_y{i}=gc_y;

end;

appr=projection(rs,basis);
plot_ia(appr);hold on; rotate3d on;
for i=1:length(al) plot3(tt,p_x{i},p_y{i},'r');end;


% function [r1,r2] = proj(x, plane)
%     r1 = plane(:,1)'*x/norm(plane(:,1));
%     r2 = plane(:,2)'*x/norm(plane(:,2));
