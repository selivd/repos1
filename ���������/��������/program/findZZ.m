function zz=findZZ(ell,sig1,sig2,u)

Lambda1=-u/2+sqrt(u^2/4+sig2);
Lambda2=-u/2-sqrt(u^2/4+sig1);
Lambda3=-u/2-sqrt(u^2/4+sig2);

C1=1/(Lambda1-Lambda2);

C3=C1*exp( (Lambda2-Lambda3)*ell );

z1=@(t)( (t<0)*C1*exp(Lambda1*t));
z2=@(t)( (t>=0 && t<ell)* C1 * exp(Lambda2*t));
z3=@(t)( (t>=ell)* C3 * exp(Lambda3*t ));
temp=@(t)(z1(t)+z2(t)+z3(t));

zz=@(t) arrayfun( temp,t) ;


