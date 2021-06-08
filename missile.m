function [T,X,Y,Z,U,V,W] = missile(X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn);
%
%

r = 0.2;
A = pi*(0.2^2);
rho = 1.2;
g = 9.81;
dt = 0.005;

X(n) = X0;
Y(n) = Y0;
Z(n) = Z0;
U(n) = 0;
V(n) = 0;
W(n) = 0;

load ('terrain.mat');
z_terrain = interp2(x_terrain,y_terrain,h_terrain,X(n),Y(n));

while Z(n) > z_terrain || (n==1)
    [Th_x,Th_y,Th_z] = thrust(T(n),Thmag0,theta,phi,Tburn,U(n),V(n),W(n));
    Vmag = sqrt(U(n)^2+V(n)^2+W(n)^2);
    [Cd] = drag_coeff(Vmag);
    [m] = mass(T(n),m0,mf,Tburn);
    
    U(n+1) = U(n) + (Th_x/m-(Cd*(rho*A/(2*m))*U(n)*sqrt(U(n)^2+V(n)^2+W(n)^2)))*dt;
    V(n+1) = V(n) + (Th_y/m-(Cd*(rho*A/(2*m))*V(n)*sqrt(U(n)^2+V(n)^2+W(n)^2)))*dt;
    W(n+1) = W(n) + (Th_z/m-(Cd*(rho*A/(2*m))*W(n)*sqrt(U(n)^2+V(n)^2+W(n)^2))-g)*dt;
    X(n+1) = X(n) + U(n+1)*dt;
    Y(n+1) = Y(n) + V(n+1)*dt;
    Z(n+1) = Z(n) + W(n+1)*dt;
    T(n+1) = T(n) + dt;
    n = n+1;
    z_terrain = interp2(x_terrain,y_terrain,h_terrain,X(n),Y(n));
end
