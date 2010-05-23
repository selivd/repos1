
e1=ellipsoid([0;0],[1,1.5;1.5,4]);
[q,Q1]=parameters(e1);

iQ1=inv(Q1);
iQ1_half=sqrtm(iQ1);
Q1_half=sqrtm(Q1);
gamma=0.5;
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

hold on
axis equal
plot(e1);
plot(gamma,g+p,'o',gamma,g-p,'o',gamma,g,'ko');
plot([gamma gamma],[g+p,g-p],'b');
%E(g,D^(-1))
hold off
