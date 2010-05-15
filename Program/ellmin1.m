e1=ellipsoid([0;0],[1,0;0,4]);
[q,Q1]=parameters(e1);
iQ1=inv(Q1);
iQ1_half=sqrtm(iQ1);
Q1_half=sqrtm(Q1);
c=[1;0];

iQ1
tildc=Q1_half*c

gamma=0.5;
k=1-gamma^2/(tildc'*tildc)
cn=tildc(2:end);
cn=cn/c(1);

iD= 1/k * (cn*cn'+eye(length(c)-1))
D=inv(iD)
% y'*iD*y=1; y ?
e=1; %||e|| = 1
y2=sqrtm(D)*e
y1=-y2'*cn

rez=Q1_half*[y1;y2]


hold on
plot(e1);
plot(gamma/sqrt(c'*c),rez,'o',gamma/sqrt(c'*c),-rez,'o');
hold off