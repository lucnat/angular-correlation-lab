
clear;

% define data
A1 = [1, -1/3, 3/7, -3/29, -3,     5, -15/13,    0,  1/8];
A2 = [0,    0,   0,     0,  4, -16/3,   16/3, -1/3, 1/24];
angle = [180, 165, 150, 135, 120, 105, 90, 75, 60] * pi/180;
N = [3033,2981,2914,2891,2686,2635,2526,2640,2809];
D_N = [36, 35.5, 35.5, 35, 32.5, 33, 34, 35, 35.5];
W = N/N(7);

% compute errors and weights
d_N = D_N./N;                   % relative error of N
d_W = sqrt(d_N.^2 + d_N(7)^2);  % relative error of W
D_W = d_W .* W;                 % absolute error of W
D_W(7) = 1e-10;                 % absolute error of W(90) -> small!
weights = 1./D_W.^2;            % weights for least squares

for i=1:9
  a1 = A1(i);
  a2 = A2(i);
  f = @(x) 1+a1*cos(x).^2+a2*cos(x).^4;
  chi_squared(i) = sum(((f(angle)-W)./D_W).^2);
  P(i) = 1 - chi2cdf(chi_squared(i),8);
end
