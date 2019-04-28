function xdot=f(x,params,K)
% x = [p pdot theta thetadot]

if nargin<3
    K = [0 0 0 0];
end

g = params.g;
M = params.M;
m = params.m;
c = params.c;
l = params.l;
sigma = params.sigma;

p = x(1);
pdot = x(2);
theta = x(3);
thetadot = x(4);

if abs(p)>10^3 || abs(theta)>10^3
    ME = MException('MyScript:Unstable', 'Instability detected');
    throw(ME)
end

Z = M*l + m*l*(sin(theta))^2;

F = -K*x;
xi1 = sigma*thetadot/m/l - g*sin(theta);
xi2 = F - c*pdot - m*l*sin(theta)*thetadot^2;

pddot = ( l * xi2 - m*l* cos(theta)*xi1 ) / Z;
thetaddot = ( cos(theta)*xi2 - (M+m)*xi1 ) / Z;

xdot = [pdot pddot thetadot thetaddot]';