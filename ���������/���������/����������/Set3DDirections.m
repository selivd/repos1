function L0=Set3DDirections(al,be)
    if(nargin==0)
        al=[0,  pi/2,  pi/2 ] ;
        be=[0,    0 ,  pi/2 ] ;
    elseif(nargin==1)
        switch al 
            case 1
                al=pi* [0, 2/3, 2/3, 2/3] ;
                be=pi* [0,  0 , 2/3, 4/3] ;
            case 2
                al=[0,1/4,1/2]*pi;
                be=0:1/4:2-1/4; be=pi*be;
            case 3
                al=[0,1/4]*pi;
                be=0:1/4:2-1/4; be=pi*be;
            otherwise
                error('SetDirections : parameter\n');
        end;
   
        
    end;
    al_ind=1:length(al);
    al_ind=al_ind(ones(length(be),1),:);
    al_ind=reshape(al_ind,1,length(be)*length(al));
    be=repmat(be,1,length(al));
    al=al(al_ind);    
        
    L0(1,:)=sin(al).*cos(be) ;
    L0(2,:)=sin(al).*sin(be);
    L0(3,:)=cos(al);
    
    L0=unique(L0','rows')' ;
    
end
