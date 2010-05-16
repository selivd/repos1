function output = second_step( config )
%CaH{i}=x, tau(i)=[t1,t2], A{'t'},B{'t'},C{'t'}
%P2class{'t'},V2class{'t'}, tt(:),H

CaHset=config.CaH;
Tauset=config.tau;
tt=config.tt;
V2class=config.V2class;
P2class=config.P2class;
H=config.H;
t1=tt(end);

q1=myeval(V2class{1});
q2=myeval(V2class{2});
qq1=integr(q1,tt);
qq2=integr(q2,tt);

p1=myeval(P2class{1});
p2=myeval(P2class{2});
pp1=integr(p1,tt);
pp2=integr(p2,tt);

%Разброс 2 прямое время
%PP2=[ -supfn1(-1,[y1,y2]),supfn1(1,[y1,y2])];

alphX2=[];
output.taus=[];
for cah_index=1:length(CaHset)
    Xh=CaHset{cah_index};
    CaHt=Tauset(cah_index,:);
    [OK,mintau2]=getMinTau2(pp2,qq1,qq2,CaHt(1),CaHt(2),t1);
    if ~OK ,continue,end;
    t_step=tt(2)-tt(1);
    tau2s=mintau2:t_step:CaHt(2);
    taus=[];
    for t2i=tau2s
       [OK,t1i]=getTau1FromTau2(pp2,qq1,qq2,CaHt(1),mintau2,t1);
       if ~OK,continue,end;
       taus=[taus;t1i,t2i]; %#ok<AGROW>
       plot(t1i,Xh,'or',t2i,Xh,'og');
    end
    
    x1i(size(1,taus))=NaN;
    x2i(size(1,taus))=NaN;
    for i=1:size(1,taus)
        t2i=taus(i,2);
        x1i(i)=H+qq2(t1)-qq2(t2i)+pp1(t1)-pp1(t2i);
        x2i(i)=H+qq2(t1)-qq2(t2i)+pp1(t1)-pp1(t2i);
    end;
    alphX2=[alphX2;{x1i},{x2i}]; %#ok<AGROW>
    output.taus=[output.taus,{taus}];
end
output.X2=alphX2;
output.tt=tt;

end

function [OK,minTau] = getMinTau2(fuInt,fq1Int,fq2Int,tau1,tau2,t1)
c1=fuInt(tau1);
f1=@(s)(fuInt(s)-c1);
c2=fq1Int(tau1)-fq1Int(t1); 
c3=fq2Int(t1);
f2=@(s)(c3-fq2Int(s)+c2);

ff=@(s)(f2(s)-f1(s));
if (ff(tau1)*ff(tau2)>0)
    OK=false;
    minTau=inf;
    return;
end;
[tmin,fval,exitflag]=fzero(ff,[tau1,tau2]);
if (exitflag~=1)
    OK=false;
    minTau=inf;
    return;
end
OK=true;
minTau=tmin;

end

function [OK,mytau1]=getTau1FromTau2(pp2,qq1,qq2,tau1,mintau2,t1) %#ok<DEFNU>
c1=pp2(mintau2);
c2=qq2(t1)-qq2(mintau2);
c3=qq1(t1);
ff=@(s) c2+qq1(s)-c3-c1+pp2(s) ; 
if ( ff(tau1)*ff(mintau2) > 1e-6 ) 
    OK=false;
    mytau1=-inf;
    return;
end;

[mytau1,fval,flag]=fzero(ff,[tau1-1e-6,mintau2]);
if (flag~=1) 
    OK=false;
    mytau1=-inf;
    return;
end;
OK=true;

end





