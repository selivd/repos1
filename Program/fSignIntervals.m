function [OK, out,zeros] = fSignIntervals(arg , interval )
%[OK, out,zeros] = fSignIntervals(arg , interval )

fun=0;
OK=0;
out=[];
zeros=[];

if isa(arg,'function_handle')
    fun=1;
    y=arrayfun(arg,interval);
elseif size(arg)==size(interval)
    y=arg;
end;
 
index=y>0;
if (min(index)~=0)return;end;
OK=1;

il1=[index(1),index];
il2=[index,index(end)];
res=xor(il1,il2);
res=res(2:end);
points=find(res);
zeros=interval(points);

start=1;
fin=length(interval);
for j=1:length(points)   
    out{j}=interval(start:points(j));
    start=points(j)+1;
end;
out{end+1}=interval(start:fin);

if fun == 0 return;end;
zeros=[];
fi=points;
si=fi+1;
for i=1:length(points)
    x=fzero(arg,[interval(fi(i)),interval(si(i))]);
    out{i}=[out{i},x];
    out{i+1}=[x,out{i+1}];
    zeros=[zeros,x];
end;


end

