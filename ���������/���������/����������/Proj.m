function [r1,r2] = Proj(x, plane)
% [r1,r2] = Proj(x, plane)
    norma=sqrt(sum(plane.^2)); %norma=repmat(norma,size(plane,1),1)
    r1 = (plane(:,1)'*x/norma(1));
    r2 = (plane(:,2)'*x/norma(2));
    
    
    





