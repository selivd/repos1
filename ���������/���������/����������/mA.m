function [ bigA,mA ] = mA( vK,vV,vMu )
%A Summary of this function goes here
%   [ bigA ] = A( vK,vV,vMu )
% vK-вектор коэффициентов K

%нижн€€ диагональ
d1=vK;
d1(end)=-d1(end); %inverse last row
d1=diag(d1,-1);

%верхн€€ диагональ
d2=diag(vK,1);

%матрица построени€
one=ones(1,length(vK));

s=diag(one,-1)+diag(one,+1);
mA=d1+d2;
d=mA*s;
d=diag(-diag(d));%-[0;vV]);
mA=mA+d;
mA=mA(2:end,2:end);
bigA=[zeros(length(vK)), eye(length(vK)); mA , diag(-vMu)];

end
