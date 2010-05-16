function  visualize( data )
% alphX2,taus,tt,pp1,pp2,qq1,qq2
alphX2=data.alphX2;
taus = data.taus;
t2=taus(1,:);

for alph=1:size(1,alphX)
    x1=alphX2{alph,1};
    x2=alphX2{alph,2};
    
end

end

function [x1s,x2s]=Xalph(s,tau2,x1,x2,pp1,qq2,tt)
if (s>tau2)
    x1s = x1 - ( qq2(s)-qq2(tau2) ) - ( pp1(s)-pp1(tau2) );
    x2s = x2 - ( qq1(s)-qq1(tau2) ) - ( pp2(s)-pp2(tau2) );
else
     
end
    
