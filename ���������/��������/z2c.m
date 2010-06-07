ell=pi/2;lam1=1; lam2=0.1;
alph=exp(lam1*ell);

x=2;
Q=0;
nu1=lam1* (alph^2+1)/(alph^2-1) + lam2;
nu2=lam1* 2*alph/(alph^2-1);
y=(Q+x*nu1)/nu2;

C21=(alph*y-x)/(alph^2-1);
C22=alph^2/(alph^2-1)*x - alph/(alph^2-1) * y;
C32=y*exp(lam2*ell);

z1=@(t)( (t<0)*x*exp(lam2*t));
z2=@(t)( (t>=0 && t<ell)*(C21*exp(lam1*t)+C22*exp(-lam1*t)) );
z3=@(t)( (t>=ell)* y * exp(-lam2*(t-ell) ));
temp=@(t)(z1(t)+z2(t)+z3(t));

zz=@(t) arrayfun( temp,t) ;

tt=-4:0.01:4;
plot(tt,zz(tt));
