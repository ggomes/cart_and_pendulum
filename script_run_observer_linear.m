clear
close all

eq = 'pi';

% load the parameters
params = get_parameters();

% we will check observability near the upright position
[A,B] = get_linearization(eq,params);

% assume we measure the position only
C = [1 0 0 0];

% choose the oberver poles and compute the oberver gain
observer_poles = [-3 -2 -1 -2.5];
L = design_observer(A,C,observer_poles);

% define the error system
sys_error = ss(A-L*C,zeros(4,1),eye(4),0);

% run the system to obtain the observer error
e0 = 10*[1 1 1 1]';
time = linspace(0,10);
e_traj = lsim(sys_error,0*time,time,e0);

% run the open loop system
x0 = [1 1 1 1]';
sys_ol = ss(A,B,eye(4),0);
x_traj = lsim(sys_ol,0*time,time,x0);
if strcmp(eq,'pi')
    x_traj = x_traj + ones(numel(time),1)*[0 0 pi 0];
end

% compute the observer state
xhat_traj = x_traj - e_traj;

% plot
make_plots_observer(time,x_traj,xhat_traj)
