function task = GetTask

%--------------  A  -------------
%task.A=mA([3;0.2],[0.4;0.1],[0.5;0.5]); %good
%task.A=mA([0.5;0.5],[0.1;0.3],[1;0.2]);
%task.A=mA([0.5;0.5],[0.1;0.3],[1;0.2]); 
n=4;
k=0.4*rand(n,1)+0.6;
v=0.4*rand(n,1)+0.6;
m=0.4*rand(n,1)+0.6;
task.A=mA(k,v,m)
eig(task.A)
%task.A = [0.1 0 0;0 0 1;0 -1 0];     
%task.A = [0 0 0.1; 0.1 0 0;0 -0.1 0];
%al=pi/6;
%task.A=[sin(al)*cos(al) 0 sin(al)-cos(al); 0 sin(al) cos(al);0 -cos(al) sin(al)];
%task.A=diag([0.6;0.4;0.9]);
ball=ell_unitball(size(task.A,1));

%--------------  eU -------------
task.eU=0.5*ball;



% -------------  B  -------------

B=diag([ones(n,1);zeros(n,1)]);%zeros(length(task.A),dimension(task.eU));
%B(end,end)=1;
task.B=B;
clear B

%----------------C---------------
Ceps=0.000;
Cval=1;
task.C=diag([Cval*ones(n,1);Ceps*ones(n,1)]);
ball = ell_unitball(2*n);
%task.eC=ellipsoid(zeros(2*n,1),diag([Cval*ones(n,1);Ceps*ones(n,1)]));
task.eV=0.1*ball;


%--------------  X0  -------------


task.X0=ball;

task.lsys=linsys(task.A,task.B,task.eU,task.C,task.eV);

task.n_realplanes=8;



end

