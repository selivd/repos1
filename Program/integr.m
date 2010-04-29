function fintegral = integr( funhandle, tt)

r(length(tt))=1;
r(1)=0;
for i=1: (length(tt)-1)
    r(i+1)=r(i)+quad(funhandle, tt(i),tt(i+1));
end;

sp=spline(tt,r);

fintegral=@(t) ppval(sp,t) ;

end

