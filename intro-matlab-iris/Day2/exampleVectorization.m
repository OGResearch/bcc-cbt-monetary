
clear, clc

N = 10^6;

x = linspace(0,1,N);

tic
y = nan(size(x));
for i = 1:N
  y(i) = log(x(i));
end
toc

tic
y = log(x);
toc