function Y = newton4euler(y,Y,h)
  % [Y,isConverged]=newton4euler(f,x,ytranspose,Y,h)
  % special function to evaluate Newton's method for back_euler
  TOL = 1.e-6;
  MAXITS = 10;
   
  for n=1:MAXITS
    
    [fValue(1),fValue(2),fValue(3),fValue(4)] = odeFunction(Y(1), Y(2), Y(3), Y(4));
    
    A = Jacobiano(Y);
    
    dFdY = (h.* A) - eye(length(Y));
    
    F = y + h * fValue - Y;
    F = [F]';
    
    incremento = dFdY\F;
    
    Y = Y - transpose(incremento) ;
    
  endfor
endfunction

%{function [Y,isConverged]=newton4euler(f,x,ytranspose,Y,h)
% [Y,isConverged]=newton4euler(f,x,ytranspose,Y,h)
% special function to evaluate Newton's method for back_euler

% your name and the date

TOL = 1.e-6;
MAXITS = 10;
 
isConverged= (1==0);  % starts out FALSE
for n=1:MAXITS
  [fValue fPartial] = feval( f, x, Y);
  F = ytranspose + h * fValue - Y;
  dFdY = h * fPartial - eye(length(Y));
  increment=dFdY\F;
  Y = Y - increment;
  if norm(increment,inf) < TOL*norm(Y,inf)
    isConverged= (1==1);  % turns TRUE here
    return
  end
end
%}
