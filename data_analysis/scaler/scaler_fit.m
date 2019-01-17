
clear; 

% read data
data = csvread('scaler_data.csv');
angle = data(:,1);
angle = angle/180*pi;
small = data(:,2);
N = data(:,3);

% compute errors and weights
D_N = sqrt(N);                  % absolute error of N
D_N_90 = sqrt(N(7));
W = N/N(7);
d_W = sqrt(1./N + 1/N(7));      % relative error of W
D_W = d_W .* W;                 % absolute error of W
D_W(7) = 1e-10;                 % absolute error of W(90) -> small!
weights = 1./D_W.^2;  % weights for least squares

% fit model (already done, maybe redo with errors of angles)
a1 = 0.3138;
a2 = -0.1553;
f_fitted = @(x) 1+a1*cos(x*pi/180).^2+a2*cos(x*pi/180).^4;

% % analytic function
% a1 = 1/8;
% a2 = 1/24;
% f_analytic = @(x) 1+a1*cos(x*pi/180).^2+a2*cos(x*pi/180).^4;

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
