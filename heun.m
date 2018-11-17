function Y=heun(n,h,y0)
  T=zeros(n,4);
  Y=zeros(n,4);
  Y(1,1) = y0(1);
  Y(1,2) = y0(2);
  Y(1,3) = y0(3);
  Y(1,4) = y0(4);
  for k = 1:n-1
    [T(k,1), T(k,2), T(k,3), T(k,4)] = odeFunction(Y(k,1),Y(k,2),Y(k,3),Y(k,4));
      
    p(1) = Y(k,1) + h*T(k,1);
    p(2) = Y(k,2) + h*T(k,2);
    p(3) = Y(k,3) + h*T(k,3);
    p(4) = Y(k,4) + h*T(k,4);
    
    [T(k+1,1), T(k+1,2), T(k+1,3), T(k+1,4)] = odeFunction(p(1),p(2),p(3),p(4));
    Y(k+1,1) = Y(k,1) + (h/2)*( T(k,1) + T(k+1,1));
    Y(k+1,2) = Y(k,2) + (h/2)*( T(k,2) + T(k+1,2));
    Y(k+1,3) = Y(k,3) + (h/2)*( T(k,3) + T(k+1,3));
    Y(k+1,4) = Y(k,4) + (h/2)*( T(k,4) + T(k+1,4));
  endfor
endfunction
  