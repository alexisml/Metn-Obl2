function xdot = fuvlsode (x, t)
    u = x(1);
    v = x(2);
    p = x(3);
    q = x(4);
    xdot = [p;q;(-2*v*p*q)/(u^2 + v^2 + 1);(-2*u*p*q)/(u^2 + v^2 + 1)];
 endfunction