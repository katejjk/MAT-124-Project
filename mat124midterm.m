
% initializing the ODE functions

%Model without Vaccination, using the AD Meyer Paper
% N = S + E + I

%Simulating the Swarming season
% βs is the rate of transmissive contact between infectious and susceptible bats
% ϕs is the rate of transmission from the environmental Pd reservoir to susceptible bats during the swarming phase
% τs is the rate of transfer from the exposed class to the infectious class during the swarming phase
% μ is the rate of natural mortality of little brown bats
% P is the growth of the pathogen

%the default values of the below rates and other parameters, as described
%in the paper


beta_s = .000000127; %(2.8 * 10^-4) / 2;
phi_s =  5.83 * 10^-14; % 10 * 10^-12;
mu = 1/ (8.5 * 365);
tao_s = 1/120;
omega = 50;   
nu = 1/2;
K_pd = 10^10;
N = 15000;
I0 = 1; % 1;                              % Initial number of infected individuals
E0 = 0; % 0;                               % Initial number of exposed individuals
S0 = N;                               % Initial number of susceptible individuals
T_s = 61;  
P0 = 10^10;                               % Growth of Pathogen (correct later)
y0 = [P0; E0; S0; I0];                    % Initial conditions
tspan = [0 T_s];                        % Interval of Integration
[t,y] = ode45(@(t,y) seip_model(t,y,beta_s,phi_s,tao_s, mu, omega, nu, K_pd),tspan,y0);

tiledlayout(2,2)
nexttile
plot(t,y,'LineWidth', 2);
xlabel('Days'); 
ylabel('Number of individuals');
legend('S','E','I', 'P');
title('SEIP Model Predictions of Swarming');


% For Hibernation
beta_h =  1.33*10^-13;%1.4 * 10^-12;
phi_h = 0.000006629; %1 * 10^ -12;
tao_h = 1/83;
delta = 1/60;

N = 6000;
I0 = 4000;                              % Initial number of infected individuals
E0 = 5000;                               % Initial number of exposed individuals
S0 = N;                               % Initial number of susceptible individuals
T_h = 212;  
P0 = 10^10;                               % Growth of Pathogen (correct later)
y0 = [P0; E0; I0; S0];                    % Initial conditions
tspan = [0 T_h];                        % Interval of Integration
[t,y] = ode45(@(t,y) seip_model_hiber(t,y,beta_h,phi_h,tao_h, mu, omega, nu, K_pd, delta),tspan,y0);

nexttile
plot(t,y,'LineWidth',2);
xlabel('Days'); 
ylabel('Number of individuals');
legend('S','E','I','P');
title('SEIP Model Predictions of Hibernation');




