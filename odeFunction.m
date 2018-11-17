function [a,b,c,d] = odeFunction(u,v,p,q)
    a = p;
    b = q;
    c = (((-2)*v*p*q)/(u*u + v*v + 1));
    d = (((-2)*u*p*q)/(u*u + v*v + 1));    
endfunction