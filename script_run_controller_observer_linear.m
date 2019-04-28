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
observer_poles = [-5 -5.1 -5.2 -5.3];
L = design_observer(A,C,observer_poles);

% choose the closed loop poles and compute the controller gain
closed_loop_poles = [-3 -2 -1 -2.5];
K = design_controller(A,B,closed_loop_poles);

% create a state space object for the closed loop system using 'ss'
At = [ A-B*K             B*K
       zeros(size(A))    A-L*C ];

Bt = [ zeros(size(B))
       zeros(size(B)) ];

Ct = eye(8);

sys = ss(At,Bt,Ct,0);

% run the closed loop simulation
x0 = 0.1*[0 1 0.02*pi 0]';
e0 = 20*[.1 .1 .01 .05]';
xhat0 = x0-e0;
time = linspace(0,10);

traj = lsim(sys,zeros(size(time)),time,[x0;xhat0]);
x_traj = traj(:,1:4);
if strcmp(eq,'pi')
    x_traj = x_traj + ones(numel(time),1)*[0 0 pi 0];
end
e_traj = traj(:,5:8);
xhat_traj = x_traj - e_traj;

% plot
make_plots_observer(time,x_traj,xhat_traj)
