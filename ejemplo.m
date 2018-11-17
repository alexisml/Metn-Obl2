function ejemplo
  clc
  clear
  % punto de inicio
  p_x = 1;%8.9;
  p_y = 2;%9.1;
  % vector hacia donde va la geodesica
  v_x = 3;%-1;
  v_y = 4;%-1;
  % parametros para solvers
  y0 = [p_x,p_y,v_x,v_y];
  iteraciones = 500;
  h = 0.01;
  
  % Nuestro solver seleccionado como oráculo es LSODE, utilizando Adams-Moulton de orden 12
  lsode_options("integration method", "adams")
  lsode_options("maximum order", 12)
  matriz_lsode = lsode("fuvlsode", y0,(t=linspace(0,iteraciones*h,iteraciones)'));
  
  % Euler hacia adelante
  matriz_euler = euler(iteraciones, h, y0);
  
  % Euler hacia atras
  matriz_back_euler = back_euler(iteraciones, h, y0);
  
  % Runge-Kutta de orden 4
  matriz_rk4 = RK4(iteraciones, h, y0);
  
  % Trapecio
  matriz_trapecio = trapecio(iteraciones, h, y0);
  
  % Heun
  matriz_heun = heun(iteraciones, h, y0);
  
  % Otra opción: Adams-Bashforth-Moulton de orden 4
  matriz_abm4 = abm4(iteraciones, h, y0);
  
  for k=1:iteraciones
    dif_euler(k) = norm([matriz_lsode(k,1)-matriz_euler(k,1), matriz_lsode(k,2)-matriz_euler(k,2), matriz_lsode(k,3)-matriz_euler(k,3), matriz_lsode(k,4)-matriz_euler(k,4)]);
    dif_back_euler(k) = norm([matriz_lsode(k,1)-matriz_back_euler(k,1), matriz_lsode(k,2)-matriz_back_euler(k,2), matriz_lsode(k,3)-matriz_back_euler(k,3), matriz_lsode(k,4)-matriz_back_euler(k,4)]);
    dif_rk4(k) = norm([matriz_lsode(k,1)-matriz_rk4(k,1), matriz_lsode(k,2)-matriz_rk4(k,2), matriz_lsode(k,3)-matriz_rk4(k,3), matriz_lsode(k,4)-matriz_rk4(k,4)]);
    dif_trapecio(k) = norm([matriz_lsode(k,1)-matriz_trapecio(k,1), matriz_lsode(k,2)-matriz_trapecio(k,2), matriz_lsode(k,3)-matriz_trapecio(k,3), matriz_lsode(k,4)-matriz_trapecio(k,4)]);
    dif_heun(k) = norm([matriz_lsode(k,1)-matriz_heun(k,1), matriz_lsode(k,2)-matriz_heun(k,2), matriz_lsode(k,3)-matriz_heun(k,3), matriz_lsode(k,4)-matriz_heun(k,4)]);
    dif_abm4(k) = norm([matriz_lsode(k,1)-matriz_abm4(k,1), matriz_lsode(k,2)-matriz_abm4(k,2), matriz_lsode(k,3)-matriz_abm4(k,3), matriz_lsode(k,4)-matriz_abm4(k,4)]);
  endfor
  
  % Grafica 3d
  figure("name", "Paraboloide hiperbolico y Adams-Moulton ord. 12");
  scatter3(matriz_lsode(:,1),matriz_lsode(:,2),matriz_lsode(:,1).*matriz_lsode(:,2),"ob");
  hold on;
  %{ 
  Descomentar para graficar todas las soluciones
  scatter3(matriz_euler(:,1),matriz_euler(:,2),matriz_euler(:,1).*matriz_euler(:,2),"or");
  hold on;
  scatter3(matriz_rk4(:,1),matriz_rk4(:,2),matriz_rk4(:,1).*matriz_rk4(:,2),"og");
  hold on;
  scatter3(matriz_trapecio(:,1),matriz_trapecio(:,2),matriz_trapecio(:,1).*matriz_trapecio(:,2),"oo");
  hold on;
  scatter3(matriz_heun(:,1),matriz_heun(:,2),matriz_heun(:,1).*matriz_heun(:,2),"oy");
  hold on;
  scatter3(matriz_abm4(:,1),matriz_abm4(:,2),matriz_abm4(:,1).*matriz_abm4(:,2),"oc");
  hold on;
  %} 
  
  j = linspace (-10, 10, 200);
  k = linspace (-10, 10, 200);
  surf(j,k,j'*k)
  hold off;
  legend({"Adams-Moulton ord. 12", "Paraboloide"});
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  zlabel ("g(u,v)=u*v");
  
  figure("name", "Distintas soluciones");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");
  hold on;
  plot(matriz_euler(:,1),matriz_euler(:,2),"or");
  hold on;
  plot(matriz_back_euler(:,1),matriz_back_euler(:,2),"ov");
  hold on;
  plot(matriz_rk4(:,1),matriz_rk4(:,2),"og");
  hold on;
  plot(matriz_trapecio(:,1),matriz_trapecio(:,2),"ok");
  hold on;
  plot(matriz_heun(:,1),matriz_heun(:,2),"oy");
  hold on;
  plot(matriz_abm4(:,1),matriz_abm4(:,2),"oc");
  hold off;
  
  %Comparaciones contra lsode
  tiempo=linspace(0,iteraciones,iteraciones)'
  % Euler hacia adelante
  figure("name", "Error global de Euler hacia adelante");
  semilogy(tiempo, dif_euler(1,:),"+r");
  title ("Error global de Euler hacia adelante");
  xlabel ("Tiempo / iteracción");
  ylabel ("Norma de la diferencia");
  hold off;
  
  figure("name", "Lsode y Euler hacia adelante");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");hold on;
  semilogy(matriz_euler(:,1),matriz_euler(:,2),"+r");
  title ("Lsode y Euler hacia adelante");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  hold off;
  
  % Euler hacia atrás
  figure("name", "Error global de Euler hacia atrás");
  semilogy(tiempo, dif_back_euler(1,:),"+v");
  title ("Error global de Euler hacia atrás");
  xlabel ("Tiempo / iteracción");
  ylabel ("Norma de la diferencia");
  hold off;
  
  figure("name", "Lsode y Euler hacia atrás");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");hold on;
  semilogy(matriz_back_euler(:,1),matriz_back_euler(:,2),"+v");
  title ("Lsode y Euler hacia atrás");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  hold off;
  
  % RK4
  figure("name", "Error global de Runge-Kutta de orden 4");
  semilogy(tiempo, dif_rk4(1,:),"+g");
  title ("Error global de Runge-Kutta de orden 4");
  xlabel ("Tiempo / iteracción");
  ylabel ("Norma de la diferencia");
  hold off;
  
  figure("name", "Lsode y Runge-Kutta de orden 4");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");hold on;
  semilogy(matriz_rk4(:,1),matriz_rk4(:,2),"+g");
  title ("Lsode y Runge-Kutta de orden 4");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  hold off;
  
  % Trapecio
  figure("name", "Error global de Trapecio");
  semilogy(tiempo, dif_trapecio(1,:),"+k");
  title ("Error global de Trapecio");
  xlabel ("Tiempo / iteracción");
  ylabel ("Norma de la diferencia");
  hold off;
  
  figure("name", "Lsode y Trapecio");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");hold on;
  semilogy(matriz_trapecio(:,1),matriz_trapecio(:,2),"+k");
  title ("Lsode y Trapecio");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  hold off;
  
  % Heun
  figure("name", "Error global de Heun");
  semilogy(tiempo, dif_heun(1,:),"+y");
  title ("Error global de Heun");
  xlabel ("Tiempo / iteracción");
  ylabel ("Norma de la diferencia");
  hold off;
  
  figure("name", "Lsode y Heun");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");hold on;
  semilogy(matriz_heun(:,1),matriz_heun(:,2),"+y");
  title ("Lsode y Heun");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  hold off;
  
  % ABM4
  figure("name", "Error global de Adams-Bashforth-Moulton ord. 4");
  semilogy(tiempo, dif_abm4(1,:),"+c");
  title ("Error global de Adams-Bashforth-Moulton ord. 4");
  xlabel ("Tiempo / iteracción");
  ylabel ("Norma de la diferencia");
  hold off;
  
  figure("name", "Lsode y Adams-Bashforth-Moulton ord. 4");
  plot(matriz_lsode(:,1),matriz_lsode(:,2),"ob");hold on;
  semilogy(matriz_abm4(:,1),matriz_abm4(:,2),"+c");
  title ("Lsode y Adams-Bashforth-Moulton ord. 4");
  xlabel ("Coordenada u");
  ylabel ("Coordenada v");
  hold off;
endfunction