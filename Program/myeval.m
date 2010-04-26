function result = myeval(strexpr,argument, isarray )
    result ='error';
    t=0;
    if (nargin == 1)
       func=eval([ '@(t)(' strexpr ')']);
       result=func;
       return ;
    end;
    
    if (nargin ==2)
        func = eval([ '@(t)(' strexpr ')']);
        result = func (argument);
        return;
    end;
    
    if (nargin == 3)
        func = eval([ '@(t)(' strexpr ')']);
        result = arrayfun(func,argument);
        return;
    end;
    
        
        
        

end

