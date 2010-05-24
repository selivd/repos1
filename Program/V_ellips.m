
q1=[0;0];
q2=[1;0];

Q1=[1 1;
    1 4];

Q2=[1 -1;
    -1 4];

close gcf;
hold on;
plot(ellipsoid(q1,Q1));
plot(ellipsoid(q2,Q2));

alph=-pi/2:0.05:pi/2;
Q1h=sqrtm(Q1);
Q2h=sqrtm(Q2);
dots1=ell_arc([0;0],Q1,alph);
c=q1-q2;
vv=dots1-repmat(q2,1,length(alph));

dist=diag(vv'*Q2*vv)-1;

myf=myeval(ss,alph);
[ok,out,zeros]=fSignIntervals(myf,alph);
 if ~ok, return;end;
 
 aa=repmat(alph',1,length(zeros));
 bb=repmat(zeros,length(alph),1);
 cc=(aa-bb); 
 cc=logical(cc);
 [I,J]=find(~cc);
 
 keypoints = zeros;
