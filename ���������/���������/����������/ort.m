function plane=ort(v1,v2,v3)
if nargin ==1
    plane=ortp(v1);
    return;
end;
    r1=v1/norm(v1);
    r2=v2-r1*dot(r1,v2);
    r2=r2/norm(r2);
if( nargin == 2)
    plane=[r1 r2];
elseif (nargin == 3)
    r3=v3-r1*dot(v3,r1)-r2*dot(v3,r2);
    r3=r3/norm(r3);
    plane=[r1 r2 r3];
end;


function plane = ortp(plane)
    
plane(:,1)=plane(:,1)/norm(plane(:,1));

for j=1:size(plane,2)-1
   v=plane(:,j);
   for i=j+1:size(plane,2)
        r=plane(:,i);
        r=r-v*(v'*r);
        plane(:,i)=r/norm(r);
   end;
end;

if(sum(sum(abs(plane'*plane-eye(size(plane,2)))))>1e-15)
    plane=ortp(plane);
end;
    