clear

e1=ellipsoid([0;0;0],[1,1.5,0;1.5,4,0;0,0,1]);
[q,Q1]=parameters(e1);

iQ1=inv(Q1);
iQ1_half=sqrtm(iQ1);
Q1_half=sqrtm(Q1);
gamma=0.5;
H=hyperplane([1,0,0],gamma);
iQ1

A22=iQ1(2:end,2:end);
a12=iQ1(2:end,1);
iA22=inv(A22)
g=-gamma*iA22*a12
R=iQ1(1)-a12'*iA22*a12; R=R*gamma^2

D=A22/(1-R)
% p'Dp=1; 
% y2=p-g; g - center
x=1;

p=sqrtm(inv(D))*x;
myE=ellipsoid([gamma;g],[ [0.001; 0;0], [0,0; inv(D)]]);
%projection(myE,[1,0,0
hold on
axis equal
opt.shade=0.3;
opt.color=[0.1; 0.9; 0.1];
plot(e1,opt);
plot(myE);

opth.shade=0.3;
opth.color=[0; 0; 1];
%opth.center=[0,0];
%opth.size=2;
%plot(H);
%plot(gamma,g+p,'o',gamma,g-p,'o');
%E(g,D^(-1))
hold off
