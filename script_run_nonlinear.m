clear
close all

% load the parameters
params = get_parameters();

% initial condition and time span
x0 = [0 0 0.4 0];
tspan = [0 20];

% integrate the model
unstable = false;
try
    [time,x_traj] = ode45(@(t,x) f(x,params), tspan, x0);
catch ME
    unstable = true;
    disp('unstable')
end

% plot
if ~unstable
    make_plots(time,x_traj)
end