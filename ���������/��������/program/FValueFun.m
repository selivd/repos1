function V = FValueFun( Q0,sig1,sig2,ell, u1,u2 )
% produce value function V(x1,x2) 
% with fixed Q0, ell, sigma1,sigma2 and u1,u2  parameters
Z1=findZZ(ell,sig1,sig2,u1);
Z2=findZZ(ell,sig1,sig2,u2);

V=@(x1,x2)( findminopt(Z1(x1),Z2(x2),Q0));

end

