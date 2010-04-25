h=@(x) double(x>=0); % ��� ���������� �������-�����������.

m_f=  @(a)  @(x) x.^2-a*abs(x); % �������� ������� ������� x^2 - a |x|

%��������� ������� ����������
sup_p=@(a,x) h(-x-a/2).*(x+a/2).^2;  %���� ��������� sup
sup_m=@(a,x) h(x-a/2).*(x-a/2).^2;   %������
m_sup=@(a) @(y) max ( sup_m(a,y) ,sup_p(a,y)) - a^2/4 ; % �������� ������ sup (��� f**(y))

%����������, �������������
simple=@(a,x) (  h ( abs(x) - a/2  ) .* ( abs(x)-a/2).^2 - a^2/4)  ;
easy_sup=@(a) @(y) simple(a,y);

range = 1:15;
hold off
for i = range 
a=-6 + i; % �������� ������� �������. 
ss=m_sup(a);
ess=easy_sup(a);
f=m_f(a);
x=-10:0.5:10;
plot(x,f(x),'g',x,ess(x),'.b',1,1,'w');
%title('������� � �� �����������,a>0');
legend('f(x)=x^2-a|x|', 'f**(x)', ['a=',num2str(a)],'Location','Best');
axis manual, axis ([-10 10 -30 30]),
saveas(gcf,['pic' num2str(i) '.eps'],'psc2');
%saveas(gcf,['pic' num2str(i) '.pdf'],'pdf');
mov(i)=getframe;
end;


%���� � ��� ��� easy_sup === m_sup. 