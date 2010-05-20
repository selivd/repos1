function  visualize( data )
% X2,tt

X2=data.X2;
qq2=data.qq22;
pp2=data.pp22;

for alph=1:size(X2,1)
    curr_tt=X2{alph,3};
    fx1=X2{alph,1};
    fx2=X2{alph,2};
    
    for i=1:length(fx1)
        y1=fx1{i}(curr_tt);
        y2=fx2{i}(curr_tt);
        
        plot(curr_tt,y1,'g','LineWidth',2);
        plot(curr_tt,y2,'k','LineWidth',2);
        
        
        t1=curr_tt(end);
        z=findZfromx2(y2(end),pp2,qq2,curr_tt);
        
        
        
        %plot(curr_tt,z(curr_tt),'LineWidth',2,'color','y');
        
        for j=1:2:length(curr_tt)
            tx=curr_tt(j);
          %  plot( [tx tx], [y2(j) z(tx)],'LineWidth',2,'color','y');
        end;
        %plot([curr_tt(end) curr_tt(end)], [y2(end),z(curr_tt(end))] ,'k');
    end;
end

end

function z=findZfromx2(x2,pp2,qq2,curr_tt)

        t1=curr_tt(end);
        for j=1:length(curr_tt)
            z(j)=x2+pp2(curr_tt(j))-pp2(t1)+qq2(curr_tt(j))-qq2(t1);
        end;
        z=myeval(z,curr_tt);
end