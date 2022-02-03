%Semi-analytical solution for penny-shaped hydraulic fracture.
%Ref:E.V. Dontsov, An approximate solution for a penny-shaped hydraulic fracture that accounts for fracture toughness, fluid viscosity and leak-off, Royal Society Open Science, 3 (2016) 160737.

clear all; close all;

%add folder to path
addpath('PC_analytical_solution');

%parameters
E  =30.0e9;
v  = 0.35;
Ep = E/(1.0-v^2);            %Pa
mup= 12.0*0.001;             %Pa*s
Kp =4.0*(2.0/pi)^(1/2)*0.5e6;%Pa*m^(1/2)
Cp =2.0*0.5e-6;              %m/s^(1/2)
% t  =20;                    %time,s
% t  =102;                   %time,s
t  =500;                     %time,s
Q0 =0.001;                   %m^3/s,injection rate

%number of points
N=500;
 
%get solution
[R,w,p,rho,eta]=get_rad_sol(Ep,mup,Kp,Cp,Q0,t,N,0);

%Plot figures
figure;
plot(R*rho,w,'k-');
xlabel('$r$ [m]','Interpreter','latex');
ylabel('$w$ [m]','Interpreter','latex');

figure;
plot(R*rho,p,'k-');

xlabel('$r$ [m]','Interpreter','latex');
ylabel('$p$ [Pa]','Interpreter','latex');

%Save data
tem = R*rho;
T_tem = tem';
T_w   = 1000.0*w'; %mm
T_p   = 1.0/1e6*p; %mm
save X:\R.txt T_tem -ascii
save X:\w.txt T_w -ascii
save X:\p.txt T_p -ascii

for i=1:100
    t(i) = i*5;
    [R,w,p,rho,eta]=get_rad_sol(Ep,mup,Kp,Cp,Q0,t(i),N,0);
    max_pressure(i) = max(p)/1.0e6;
	max_R(i)    = max(R);
end

T_t = t';
T_max_pressure = max_pressure';
T_max_R = max_R';
save X:\Time.txt T_t -ascii
save X:\max_pressure.txt T_max_pressure -ascii
save X:\max_R.txt T_max_R -ascii