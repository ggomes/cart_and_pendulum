function make_plots(time,x)

params = get_parameters();

% plot
figure('Position',[212 234 560 420])
plot(time,x,'LineWidth',2)
grid
legend('p','pdot','theta','thetadot')

% animate
llim = max([min([min(x(:,1))-3 -3]) -30]);
rlim = min([max([max(x(:,1))+3 3]) 30]);
boxwidth = rlim-llim;

cart.w = 1;
cart.h = 0.2;

p = x(:,1);
theta = x(:,3);

figure('Position',[788 234 560 420])
hold on
line([llim rlim],[-.01 -0.01])
xpos = 0.5*cart.w*[-1 1];
ypos = [0 cart.h];
h(1) = patch(xpos([1 1 2 2]),ypos([1 2 2 1]),'b');
h(2) = line([0 0],[cart.h cart.h+params.l]);
set(h(2),'LineWidth',2)
set(h(2),'Color',[0 1 0])
m = plot(0,0,'ro','MarkerSize',50/boxwidth,'MarkerEdgeColor','k','MarkerFaceColor','r');
set(m,'XData',p(1)-params.l*sin(theta(1)),'YData',params.l*cos(theta(1)))
axis([llim rlim llim rlim])
set(gca,'YTick',[])
set(gca,'XTick',[])
t=text(0.7*xlim,0.9*xlim,'');
set(t,'FontSize',16)

for k=1:length(time)
    xpos = p(k) + 0.5*cart.w*[-1 1];
    set(h(1),'XData',xpos([1 1 2 2]));
    set(h(2),'XData',p(k) - params.l*[0 sin(theta(k))]);
    set(h(2),'YData',cart.h + params.l*[0 cos(theta(k))]);
    set(m,'XData',p(k)-params.l*sin(theta(k)),'YData',cart.h+params.l*cos(theta(k)))
    set(t,'String',sprintf('%.1f',time(k)));
    drawnow
    pause(0.01)
end