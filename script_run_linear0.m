clear
close all

% load the parameters
params = get_parameters();

% initial condition and time span
ic = [0 -1 0 1];
tspan = [0 20];

% control action
F = 0;

% integrate the model
[A,B] = get_linearization('0',params);
[time,x_traj] = ode45(@(t,x) A*x+B*F, tspan, ic);

% plot
make_plots(time,x_traj)