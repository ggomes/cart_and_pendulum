function make_plots_observer(time,x,xhat)

params = get_parameters();

% plot
figure('Position',[212.0000   51.4000  560.0000  657])
subplot(411)
plot(time,x(:,1),'LineWidth',2), hold on
plot(time,xhat(:,1),'--','LineWidth',2)
ylabel('p')

subplot(412)
plot(time,x(:,2),'LineWidth',2), hold on
plot(time,xhat(:,2),'--','LineWidth',2)
ylabel('pdot')

subplot(413)
plot(time,x(:,3),'LineWidth',2), hold on
plot(time,xhat(:,3),'--','LineWidth',2)
ylabel('theta')

subplot(414)
plot(time,x(:,4),'LineWidth',2), hold on
plot(time,xhat(:,4),'--','LineWidth',2)
ylabel('thetadot')

% animate
llim = max([min([min(xhat(:,1))-3 min(x(:,1))-3 -3]) -30]);
rlim = min([max([max(xhat(:,1))+3 max(x(:,1))+3 3]) 30]);
boxwidth = rlim-llim;

cart.w = 1;
cart.h = 0.2;

p = x(:,1);
theta = x(:,3);

phat = xhat(:,1);
thetahat = xhat(:,3);

figure('Position',[788 234 560 420])
hold on
line([llim rlim],[-.01 -0.01])

% real cart
xpos = 0.5*cart.w*[-1 1];
ypos = [0 cart.h];
h(1) = patch(xpos([1 1 2 2]),ypos([1 2 2 1]),'b');
h(2) = line([0 0],[cart.h cart.h+params.l]);
set(h(2),'LineWidth',2)
set(h(2),'Color',[0 1 0])
m(1) = plot(0,0,'ro','MarkerSize',50/boxwidth,'MarkerEdgeColor','k','MarkerFaceColor','r');
set(m(1),'XData',p(1)-params.l*sin(theta(1)),'YData',params.l*cos(theta(1)))


% estimated cart
xpos = 0.5*cart.w*[-1 1];
ypos = [0 cart.h];
h(3) = patch(xpos([1 1 2 2]),ypos([1 2 2 1]),'m');
h(4) = line([0 0],[cart.h cart.h+params.l]);
set(h(4),'LineWidth',2)
set(h(4),'Color',0.7*[1 0 0 ])
set(h(3),'FaceAlpha',0.7)
m(2) = plot(0,0,'ro','MarkerSize',50/boxwidth,'MarkerEdgeColor','k','MarkerFaceColor','r');
set(m(2),'XData',phat(1)-params.l*sin(thetahat(1)),'YData',params.l*cos(thetahat(1)))
% set(m(2),'FaceAlpha',0.7)

axis([llim rlim llim rlim])
set(gca,'YTick',[])
set(gca,'XTick',[])
t=text(0.7*xlim,0.9*xlim,'');
set(t,'FontSize',16)

for k=1:length(time)
    
    % real cart
    xpos = p(k) + 0.5*cart.w*[-1 1];
    set(h(1),'XData',xpos([1 1 2 2]));
    set(h(2),'XData',p(k) - params.l*[0 sin(theta(k))]);
    set(h(2),'YData',cart.h + params.l*[0 cos(theta(k))]);
    set(m(1),'XData',p(k)-params.l*sin(theta(k)),'YData',cart.h+params.l*cos(theta(k)))
    
    % estimated cart
    xpos = phat(k) + 0.5*cart.w*[-1 1];
    set(h(3),'XData',xpos([1 1 2 2]));
    set(h(4),'XData',phat(k) - params.l*[0 sin(thetahat(k))]);
    set(h(4),'YData',cart.h + params.l*[0 cos(thetahat(k))]);
    set(m(2),'XData',phat(k)-params.l*sin(thetahat(k)),'YData',cart.h+params.l*cos(thetahat(k)))
    
    set(t,'String',sprintf('%.1f',time(k)));
    drawnow
    pause(0.01)
end