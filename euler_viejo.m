function euler=euler(n,h,y0)
  y=y0;
  for i=1:n
    [x1,x2,x3,x4] = fuv(y(1), y(2), y(3), y(4));
    yant=y;
    y =(yant + [x1,x2,x3,x4].*h );
    for j=1:4
        pasos(i,j)=y(j);
    endfor
  endfor
  % Solucion usando lsode para comparar
  x=lsode("fuvlsode", y0,(t=linspace(0,n*h,n)'));

  % Paraboloide hiperbolico y geodesica con euler
  figure("name", "Geod�sica con euler y paraboloide hiperb�lico");
  scatter3(pasos(:,1),pasos(:,2),pasos(:,1).*pasos(:,2),"ob");
  hold on;
  j = linspace (-10, 10, 200);
  k = linspace (-10, 10, 200);
  surf(j,k,j'*k)
  hold off;
  legend({"Euler","Paraboloide"});
  title ("Geod�sica con euler y paraboloide hiperb�lico");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  zlabel ("g(u,v)=u*v");

  % Euler vs lsode en 3d:
  figure("name", "Euler vs. Lsode 3D");
  scatter3(x(:,1),x(:,2),x(:,1).*x(:,2),"or");
  hold on;
  scatter3(pasos(:,1),pasos(:,2),pasos(:,1).*pasos(:,2),"ob");
  hold off;
  legend({"LSODE","Euler"});
  title ("Euler vs. lsode");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  zlabel ("g(u,v)=u*v");

  % Euler vs lsode en 2d:
  figure("name", "Euler vs. Lsode");
  plot(x(:,1),x(:,2),"+r", pasos(:,1),pasos(:,2),"xb");
  legend({"LSODE","Euler"});
  title ("Euler vs. lsode");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");

  % Euler - lsode en 2d:
  figure("name", "Diferencia");
  plot(t, abs(pasos(:,1)-x(:,1)),"+r",t, abs(pasos(:,2)-x(:,2)),"xb");
  legend({"Diferencia en u","Diferencia en v"});
  title ("Diferencia entre Euler y Lsode");
  xlabel ("t");
  ylabel ("Abs(Euler-LSODE)");
endfunction
