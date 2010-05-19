H=2;
b=1.4:0.4:4;
a=2;
lambda=0.3;
y=[];
x= (0:0.1:3);
% for i=1:lentgh(b)
%     x=0:0.1:5;
%     j=1:length(x);
%     y(j,i)=b(i)-(x-a)^2;
% end;

close gcf
hold on;

%f=@(x,a,b) b-(x-a).^2;
f1=@(x,a,b) b*(lambda+(1-lambda)*sqrt(x) )+sin(x*1.5*pi)*(a/3);
f=@(a,b) @(x) f1(x,a,b);
f=@(x,a,b) arrayfun(f(a,b),x);

for i=1:length(b)
    y(i,:)=f(x,a,b(i));
end;
%y=repmat(b',1,length(x))-repmat((x-a).^2,length(b),1);

ih=[];
%подготовка интервалов между пересечениями
for i=1:length(b)
    ff=@(x) H-f(x,a,b(i));
    [ok,xset]=fSignIntervals(ff,x);
    if ~ok
       continue;
    end;
    ih=[ih,i];
    
    xx{i}=xset{1};
    yy{i}=f(xx{i},a,b(i));
%     
%     for j=1:length(xxb{i})
%         xx=xxb{i};
%         yy{j}=f(xx{1},a,b(i));
%     end;
%         yyb{i}=[yyb{i},yy];
end;

for i=1:length(yy)-1
    px=xx{i};
    px2=xx{i+1};
    px2=px2(end:-1:1);
    px=[px,px2];
    py=yy{i};
    py2=yy{i+1};
    py=[yy{i},py2(end:-1:1)];
    
    fill(px,py,'y');
end;




for i=1:length(b)
   plot(x,y(i,:));
end;

for i=1:length(yy)
    plot(xx{i},yy{i},'r');
end;
plot([x(1) x(end)],[H H]);

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
