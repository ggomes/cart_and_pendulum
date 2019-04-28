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
[A,B] = get_linearization('pi',params);
[time,x_traj] = ode45(@(t,x) A*x+B*F, tspan, ic);
x_traj = x_traj + ones(numel(time),1)*[0 0 -pi 0];

% plot
make_plots(time,x_traj)