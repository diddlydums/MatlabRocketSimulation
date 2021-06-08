close all;
clc;
format long;
color='krbgmcy';

for M_id=1:7
    [X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn] = read_input('missile_data.txt',M_id);
    [I{M_id}, X{M_id}, Y{M_id}, Z{M_id}, U{M_id}, V{M_id}, W{M_id}] = missile(X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn);
    Vmag{M_id}=sqrt((U{M_id}.^2)+(V{M_id}.^2)+(W{M_id}.^2));
    Acc{M_id}=diff(Vmag{M_id});
end

load 'terrain.mat'
figure(1);hold on;

for M_id=1:7
    plot3(X{M_id}/1000,Y{M_id}/1000,Z{M_id}/1000,['-',color(M_id)],'lineWidth',
    