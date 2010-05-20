clear X0 A1 B1 C1 A2 B2 C2 P1class P2class tt q11 q12 q21 q22 p11 p12 p21 p21
clear C1set pp11 pp12 pp21 pp22 X0set PP1 PP2 CaH Cind config

clear

X0={'-2+0*t','-1+0*t'};
% еще неиспользуются 
A1={'0+0*t'};
B1={'1+0*t'}; %B1={'2+0*t'};
C1={'1+0*t'};

A2={'0+0*t'};
B2={'1+0*t'}; %B2={'2+0*t'};
C2={'1+0*t'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P1class={'0.4*cos(t*pi)','1.5+0.6*sin(t*pi)'};
V1class={'0*t','0.2+0.1*sin(t*pi)'};

P2class={'0.3+sin(t*pi).^2','0.5*cos(t*pi).^2'};
V2class={'0*t-0.1*sqrt(t)','0*t+0.1*sqrt(t)'};


tt=0:0.1:4;

H=0;


q11=myeval(V1class{1});
q12=myeval(V1class{2});


p11=myeval(P1class{1});
p12=myeval(P1class{2});


f1=myeval(X0{1});
f2=myeval(X0{2});
X0set(:,1)=f1(tt);
X0set(:,2)=f2(tt);

qq11=integr(q11,tt);
qq12=integr(q12,tt);

%Ядра для 1 систем 
C1set(:,1)= X0set(:,1)+qq12(tt)';
C1set(:,2)= X0set(:,2)+qq11(tt)';

dif = ((C1set(:,2)-C1set(:,1))<0);
C1set(dif,:)=[]; %Ctt=tt;

Ctt=tt(1:length(C1set));
Cind=1:length(C1set);

pp11=integr(p11,tt);
pp12=integr(p12,tt);
y1=pp11(tt)';
y2=pp12(tt)';

%Разброс 1 прямое время
PP1=[ -supfn1(-1,[y1,y2]),supfn1(1,[y1,y2])];


dir = 1;

alpha=0.4:0.05:1;
j=1;

close(gcf);

for i = 1:length(alpha)
   pp_i=  alpha(i)*PP1(Cind,1)+(1-alpha(i))*PP1(Cind,2) ;
   
   X1_1=C1set(:,2)+pp_i;
   X1_2=C1set(:,1)+pp_i;
   
   supval = supfn1(dir,X1_1-H);
   t_i=find(supval>=0 ,1);
   if ( isempty(t_i)) continue, end;
   ff=myeval(supval,Ctt);
   t1_exact=fzero(ff,[Ctt(1),Ctt(end)]);
        [OK,intpm,zeros]=fSignIntervals(ff,tt);
        if ~OK, error('ошибка');end;
        
        plot_y1=ff(intpm{1});
        plot_x1=intpm{1};
   
   t1=tt(t_i);
   
   supval = supfn1(dir,X1_2-H);
   t_i=find(supval>=0 ,1);
   if ( isempty(t_i)) continue, end;
   ff=myeval(supval,Ctt);
   t2_exact=fzero(ff,[Ctt(1),Ctt(end)]);
   
        [OK,intpm,zeros]=fSignIntervals(ff,tt);
        if ~OK, error('ошибка');end;
 
        plot_y2=ff(intpm{1});
        plot_x2=intpm{1};
   
   
   t2=tt(t_i);
   
   hold on
   %линии 1,2 до гиперплоскости
   plot(plot_x1,plot_y1,plot_x2,plot_y2)
   %plot([Ctt;Ctt],[X1_1,X1_2]');
   if t1<=t2
    CaH(j,:)=[t1_exact,t2_exact]; %#ok<SAGROW>
    j=j+1;
    % CaH на гиперплоскости
    plot(CaH(j-1,:)',[H;H],'LineWidth',2,'color','b')
   
   
   end;
   
end

plot(CaH(1,:)',[H;H],'LineWidth',3,'color','k')
plot(CaH(end,:)',[H;H],'LineWidth',3,'color','k')
plot([tt(1) tt(end)],[H H],'b');

for i=1:size(CaH,1) 
    config.CaH{i}=H;
end

config.tau=CaH;
config.P2class=P2class;
config.V2class=V2class;
config.tt=tt;
config.H=H;
data = second_step(config);
visualize(data);

