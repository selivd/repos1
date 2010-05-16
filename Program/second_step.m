function output = second_step( config )
%CaH{i}=x, tau(i)=[t1,t2], A{'t'},B{'t'},C{'t'},P2class{'t'},V2class{'t'}, tt(:)

tt=config.tt;
V2class=config.V2class;
P2class=config.P2class;

q1=myeval(V2class{1});
q2=myeval(V2class{2});
qq1=integr(q1,tt);
qq2=integr(q2,tt);

p1=myeval(P2class{1});
p2=myeval(P2class{2});
pp21=integr(p1,tt);
pp22=integr(p2,tt);

%Разброс 2 прямое время
%PP2=[ -supfn1(-1,[y1,y2]),supfn1(1,[y1,y2])];

for cah_index=1:length(config.X0)
    Xh=config.CaH{cah_index};
    CaHt=config.tau(cah_index,:);
    [OK,mintau]=getMinTau2(pp2,qq1,qq2,CaHt(1),CaHt(2),tt(end));
    if OK 
        plot(mintau,Xh,'or');
    end
    
end
output=[];
end

function [OK,minTau] = getMinTau2(fuInt,fq1Int,fq2Int,tau1,tau2,t1)
c1=fuInt(tau1);
f1=@(s)(fuInt(s)-c1);
c2=fq1Int(tau1)-fq1Int(t1); 
c3=fq2Int(t1);
f2=@(s)(c3-fq2Int(s)+c2);

ff=@(s)(f2(s)-f1(s));
[tmin,fval,exitflag]=fzero(ff,[tau1,tau2]);
if (exitflag~=1)
    OK=false;
    minTau=inf;
    return;
end
minTau=tmin;

end


