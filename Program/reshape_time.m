clear arr;
step=100;
for i=step:step:100000
    start=tic;
    arr(i)=0;
    
    ar=reshape(arr,[i/20,5,2,2]);
    T(i/step)=toc(start);
end;