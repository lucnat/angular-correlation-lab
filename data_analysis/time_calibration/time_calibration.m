
clear;

data = csvread('csvdata/time_calibration.csv');
indices = find(data>0);

% get rid of undershoot
indices = indices(indices>2000);

% now the channels were grouped into towers by hand:
groups = [
  [2039,2040,2041],
  [2708,2709,2710],
  [3354,3355,3356],
  [4031,4032,4033],
  [4699,4700,4701],
  [5366,5367,5368],
  [6032,6033,6034],
  [6701,6702,6703]
];

% Now compute weighted sum
for i=1:8
  group = groups(i,:);
  weightedIndices(i) = sum(data(group)'.*group)/sum(data(group));
end

% fit
t = 0:8:56;
x = t;
y = weightedIndices;
[p,e] = polyfit(x,y,1);
fitted = polyval(p,[-2,58]);

% plot
plot(x,y,'o');
hold on;
plot([-2,58],fitted,'linewidth',1);
xlabel('\Delta t [ns]');
ylabel('channel no.');
legend('data points','linear fit');
set(gca,'fontsize',13);
grid on;
