function  visualize( data )
% X2,tt

X2=data.X2;

for alph=1:size(X2,1)
    curr_tt=X2{alph,3};
    fx1=X2{alph,1};
    fx2=X2{alph,2};
    
    for i=1:length(fx1)
        y1=fx1{i}(curr_tt);
        y2=fx2{i}(curr_tt);
        
        plot(curr_tt,y1,'g','LineWidth',2);
        plot(curr_tt,y2,'k','LineWidth',2);
    end;
end

end

% function [x1s,x2s]=Xalph(s,tau1,tau2,x1,x2,pp1,qq2,tt)
% if (s>tau2)
%     x1s = x1 - ( qq2(s)-qq2(tau2) ) - ( pp1(s)-pp1(tau2) );
%     x2s = x2 - ( qq1(s)-qq1(tau2) ) - ( pp2(s)-pp2(tau2) );
% else
%     
%     
%      
% end
%     
