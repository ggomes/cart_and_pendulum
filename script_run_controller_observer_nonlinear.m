clear
close all

eq = '0';

% load the parameters
params = get_parameters();

% we will check observability near the upright position
[A,B] = get_linearization(eq,params);

% assume we measure the position only
C = [1 0 0 0];

% choose the oberver poles and compute the oberver gain
observer_poles = 2*[-5 -5.1 -5.2 -5.3];
L = design_observer(A,C,observer_poles);

% choose the closed loop poles and compute the controller gain
closed_loop_poles = 0.5*[-3 -2 -1 -2.5];
K = design_controller(A,B,closed_loop_poles);

% run the closed loop system using 'ode45'
x0 = 0.8*[0 1 0.02*pi 0]';
e0 = .3*[0.04 0 .23 0]';
xhat0 = x0-e0;
xxhat0 = [x0;xhat0];
unstable = false;
try
    [time,x_traj] = ode45(@(t,xxhat) fobs(xxhat,params,A,B,C,L,K), [0 20], xxhat0);
catch ME
    unstable = true;
    disp('unstable')
end

% plot
if ~unstable
    make_plots_observer(time,x_traj(:,1:4),x_traj(:,5:8));
end
