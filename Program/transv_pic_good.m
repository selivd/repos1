clear 
H=2;
b=1.285:0.4:4;
a=2;
lambda=0.3;
y=[];
x= (0:0.01:1.4);
% for i=1:lentgh(b)
%     x=0:0.1:5;
%     j=1:length(x);
%     y(j,i)=b(i)-(x-a)^2;
% end;

close gcf
hold on;

%f=@(x,a,b) b-(x-a).^2;
f1=@(x,a,b) b*(lambda+(1-lambda)*sqrt(x) ); % +sin(x^1.5*1.5*pi)*(a/3);
f=@(a,b) @(x) f1(x,a,b);
f=@(x,a,b) arrayfun(f(a,b),x);

for i=1:length(b)
    y(i,:)=f(x,a,b(i));
end;

for i=1:length(b)
   plot(x,y(i,:));
end;
plot([x(1) x(end)],[H H]);
%y=repmat(b',1,length(x))-repmat((x-a).^2,length(b),1);

ih=[];
%подготовка интервалов между пересечениями
xsets=[];
zeros=[];
yy=[];
for i=1:length(b)
    ff=@(x) H-f(x,a,b(i));
    [ok,intpm,nuls]=fSignIntervals(ff,x);
    if ~ok
       continue;
    end;
    ih=[ih,i];
    
    xsets{end+1}=intpm(1:2:end);
    %yy{end+1}=f(xx{end},a,b(i));
    zeros{end+1}=nuls;
%     
%     for j=1:length(xxb{i})
%         xx=xxb{i};
%         yy{j}=f(xx{1},a,b(i));
%     end;
%         yyb{i}=[yyb{i},yy];
end;

% подготовка заливки и множества CH
trans=[];
for i=1:length(ih)-1
    ind1=ih(i);
    ind2=ih(i+1);
    xset1=xsets{i};
    xset2=xsets{i+1};
    xx1=xset1{1}; 
    zz2=zeros{i+1};
    ineibour=find(zz2<xx1(end),1,'last');
    neibpoint=zz2(ineibour); 
    trans{end+1}=[neibpoint,xx1(end)];
    % конструируем куски функции и плоскости
    acc=[];
    for j=1:length(xset2)
        if ( max(xset2{j})<=neibpoint)
        acc=[acc,xset2{j}];
        end;
    end;
    xx2=acc(end:-1:1);
    pxx=[xx1,xx2];
    
    yy1=f(xx1,a,b(ind1));
    yy2=f(xx2,a,b(ind2));
    pyy=[yy1,yy2];
    
    aa=fill(pxx,pyy,'y');
end;




for i=1:length(b)
   plot(x,y(i,:));
end;

% for i=1:length(yy)
%     plot(xx{i},yy{i},'r');
% end;

plot([x(1) x(end)],[H H]);

for i=1:length(trans)
    plot(trans{i},[H H],'LineWidth',3,'Color','r');
end;

%подготовка заполнения и заполнение
% [x,y]=meshgrid(-1:0.2:1,0:0.2:2)
% z=y-x.^2;
% [DX,DY]=gradient(z,0.2,0.2);
% countour(x,y,z)
% contour(x,y,z)
% quiver(x,y,-DY,DX);
% hold on;
% contour(x,y,z)
% plot( [0 2],[0.5 0.5],'-')
% plot( [-1 1],[0.5 0.5],'-')
