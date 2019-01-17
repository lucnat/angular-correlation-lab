clear all;

file = 'angle_180.csv';
amountBins = 2^4;
y = csvread(file);
disp(size(y));
n = length(y);
j = 1;
for i = 1:amountBins:n
  binnedData(j) = sum(y(i:i+amountBins-1));
  j = j + 1;
end

plot(binnedData,'linewidth',2)
