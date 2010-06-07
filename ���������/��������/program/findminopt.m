function [minimum,u1,u2] = findminopt( b1,b2,c1 )
% b^T * u -> min
% A11*u >c1 
% u>0

dq=[b1-b2;b2];
if(b1-b2 <=0)
    u1=c1;
    u2=0;
else
    u1=0;
    u2=c1;
end;
minimum=b1*u1+b2*u2;
return;

end

