%vK=[sym('k1');sym('k2');sym('k3')];
%mu=[sym('m1');sym('m2');sym('m3')];
%v=[sym('v1');sym('v2');sym('v3')];
syms k1 k2 k3 k4 k5
k=k1+k2+k3+k4+k5;
vK=symvar(k);
syms m1 m2 m3 m4 m5
k=m1+m2+m3+m4+m5;
vMu=symvar(k);
syms v1 v2 v3 v4 v5
k=v1+v2+v3+v4+v5;
vV=symvar(k);


d1=vK;
d1(end)=-d1(end); %inverse last row
d1=diag(d1,-1);

%верхняя диагональ
d2=diag(vK,1);

%матрица построения
one=ones(1,length(vK));

s=diag(one,-1)+diag(one,+1);
mA=d1+d2;
d=mA*s;
d=diag(-diag(d));%-[0;vV]);
mA=mA+d;
mA=mA(2:end,2:end);
bigA=[zeros(length(vK)), eye(length(vK)); mA , diag(-vMu)];