
clear; 

% define data
angle = [180, 165, 150, 135, 120, 105, 90, 75, 60] * pi/180;
N = [3033,2981,2914,2891,2686,2635,2526,2640,2809]
D_N = [36, 35.5, 35.5, 35, 32.5, 33, 34, 35, 35.5]

% compute errors and weights
d_N = D_N./N                    % relative error of N
W = N/N(7);
d_W = sqrt(d_N.^2 + d_N(7)^2);      % relative error of W
D_W = d_W .* W;                 % absolute error of W
D_W(7) = 1e-10;                 % absolute error of W(90) -> small!
weights = 1./D_W.^2;  % weights for least squares

% fit model (already done, maybe redo with errors of angles)
a1 = 0.386;
a2 = -0.2016;
f_fitted = @(x) 1+a1*cos(x*pi/180).^2+a2*cos(x*pi/180).^4;

% analytic function
a1 = 1/8;
a2 = 1/24;
f_analytic = @(x) 1+a1*cos(x*pi/180).^2+a2*cos(x*pi/180).^4;

% plot
x = angle*180/pi;
x2 = linspace(55,185,1000);
y = W;
errorbar(x,y,D_W,'o');
hold on;
plot(x2,f_fitted(x2),'linewidth',2);
% hold on;
% plot(x2, f_analytic(x2), 'linewidth',2);
xlabel('\Theta [°]');
ylabel('W(\Theta) / W(90°)');
legend('data points','fit','theoretical');
set(gca,'fontsize',13);
grid on;
