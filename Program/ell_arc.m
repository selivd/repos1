function [ dots ] = ell_arc(q,Q,alpha, plot_opt )
% produces dots on ellipsoid(q,Q) surface according to alpha angles 

gen_e=@(a) [cos(a);sin(a)];

len=length(alpha);
b1=gen_e(alpha);
Qh=sqrtm(Q);
dots=Qh*b1+repmat(q,1,len);
if nargin==4
    plot(dots(1,:),dots(2,:),plot_opt);
end;
end

