function pasos=euler(n,h,y0)
  y=y0;
  pasos(1,1) = y0(1);
  pasos(1,2) = y0(2);
  pasos(1,3) = y0(3);
  pasos(1,4) = y0(4);
  for i=2:n
    [x1,x2,x3,x4] = fuv(y(1), y(2), y(3), y(4));
    yant=y;
    y =(yant + [x1,x2,x3,x4].*h );
    for j=1:4
        pasos(i,j)=y(j);
    endfor
  endfor
  
endfunction
