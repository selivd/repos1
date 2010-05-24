clear 
CAH=[-2 2;
      0 0];
Q=[ 1, 0;
    0, 4];

Qh=sqrtm(Q);

gen_e=@(a) [cos(a);sin(a)];
%генерация углов
a1=[0:0.6:pi/3, pi/2];
a2=pi-a1;
%единичные вектора
b1=gen_e(a1);
b2=gen_e(a2);
%центры эллипсоидов
c1=Qh*b1+repmat(CAH(:,1),1,length(a1));
c2=Qh*b2+repmat(CAH(:,2),1,length(a1));
%Opoint=zeros(2,length(a1));
close gcf
hold on;
axis equal 
%чертим эллипсоиды, выделяем центры
for i=1:length(a1)
    ee1=ellipsoid(c1(:,i),Q);
    ee2=ellipsoid(c2(:,i),Q);
    plot(ee1);
    plot(ee2);
    plot(c1(1,:),c1(2,:),'o');
    plot(c2(1,:),c2(2,:),'o');
end;

%плавные линии для граничного множества 
a1=[0:0.1:pi/2, pi/2];
a2=pi-a1;

b1=gen_e(a1);
b2=gen_e(a2);

c1=Qh*b1+repmat(CAH(:,1),1,length(a1));
c2=Qh*b2+repmat(CAH(:,2),1,length(a1));

qc=c2(:,end:-1:1);
ZZ=[c1,qc];
ZZn=[ZZ(1,:);-ZZ(2,:)];

plot(ZZ(1,:),ZZ(2,:),'b','linewidth',2);
plot(ZZn(1,:),ZZn(2,:),'b--','linewidth',2);
plot(CAH(1,:),CAH(2,:),'ks');
plot(CAH(1,:),CAH(2,:),'g-');

hold off;