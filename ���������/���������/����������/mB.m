function B=mB(A,eU)

if(nargin==2 && strcmp(class(eU),'ellipsoid'))
    B=zeros(length(A),dimension(eU));
else
    B=zeros(length(A));
end

B(end)=1;

B=[1 0; 0 2; 0 1];