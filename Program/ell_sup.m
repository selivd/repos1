function rez = ell_sup(L, arg1,args )
% ell_sup(L,Q), ell_sup(L,q,Q), ell_sup(L,ellipsoid)
% support function for ellipsoid in L direction 


if (nargin==3)
    Q=varargin{1}; %#ok<USENS>
    q=arg1;
elseif( nargin ==2 )
    if (isnumeric(arg1))
        Q=arg1;
        q=zeros(size(Q,1),1);
    else
        [q,Q]=parameters(arg1);
    end;
elseif(nargin ==1)
    ' wrong arguments'
    return ;
end;

rez = q'*L + sqrt( L'*Q*L );
return;


if (size(Q,1)~=size(Q,2))
    ' not square matrix '
    return;
end;

if( size(q,1)~=1 || size(q,2)~=size(Q,1))
    'wrong size of q'
    return;
end;
if ( size(L)~=size(q) )
    'wrong size of L'
    return;
end;



end

