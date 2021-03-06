function result = myeval(strexpr,argument, asarray )
    result ='error';
    t=0;
    if (nargin == 1)
       func=eval([ '@(t)(' strexpr ')']);
       result=func;
       return ;
    end;
    
    if (nargin ==2)
        if (ischar(strexpr))
            func = eval([ '@(t)(' strexpr ')']);
            result = func (argument);
        else 
            sp=spline(argument,strexpr);
            result=@(t)(ppval(sp,t));
        end;
        return;
    end;
    
    if (nargin == 3)
        func = eval([ '@(t)(' strexpr ')']);
        result = arrayfun(func,argument);
        return;
    end;
    
        
        
        

end

