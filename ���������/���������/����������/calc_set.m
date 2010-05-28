function [ rs ] = calc_set( vK,vV,vM, eU,X0,L0,T )
%CALC_SET Summary of this function goes here
%   [ rs ] = calc_set( vK,vV,vM, eU,X0,L0,T )
    A=mA(vK,vV,vM);
%    B=zeros(2*length(vK));
    B=mB(A,eU);
    B(end,end)=1;
    lsys = linsys(A,B,eU);
    opt.save_all = 1;
    rs=reach(lsys,X0,L0,T,opt);
    
end
