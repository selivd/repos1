X0={'1','2'};
Pclass={'t','2*t'};
Vclass={'0.3*t','0.5*t'};
t=0:0.1:4;
q1=myeval(Vclass{1},t,'')';
q2=myeval(Vclass{2},t,'')';
X0set(:,1)=myeval(X0{1},t,'')';
X0set(:,2)=myeval(X0{2},t,'')';

if (min(q2-q1)<0) 
    'Vclass is not valid'
    return;
end;

Cset(:,1)= X0set(:,1)+q2;
Cset(:,2)= X0set(:,2)+q1;

