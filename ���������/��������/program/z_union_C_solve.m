
ell=0.2;sig1=1; sig2=0.1;u=-0.4;

Q=2;
Q0=1;
%close gcf;
hold on;


ell=(i./max(i)).^2;
ell=1;
u=[-0.4,0,0.1,1];

tt=-4:0.02:4;
for i=1:5
    Z=findZZ(ell,sig1,sig2,u(i));
    yy=Z(tt);
    plot(tt,yy);
end;

V=FValueFun(Q0,sig1,sig2,0.4,u(5),u(1));
tt=-4:0.02:4;
X=tt;
Y=tt;
Z=[];CC=[];
for i=1:length(X)
    for j=1:length(Y)
        [Z(i,j),u1,u2]=V(X(i),Y(j));
        CC(i,j)= (u1==0);
    end;
end;

CC=logical(CC);
maxz=max(max(Z));
minz=min(min(Z));
%a*(x+b)
b=1-minz;
a=32/(maxz-minz);

Color1=(Z+b)*a;
Color2=(Z+b)*a+32;

Col=[];
Col(length(X),length(Y))=0;
Col(CC)=Color1(CC);
Col(~CC)=Color2(~CC);

surface(X,Y,Z,Col,'EdgeColor','none');

zlabel('V(x_1,x_2)')
xlabel('x_1')
ylabel('x_2')
title('');

rotate on
% for j=1:5
%     zz=findZZ(ell,sig1,sig2,u(j));
%     tt=-4:0.01:4;
%     plot(tt,Q*zz(tt),'g');
% end;


