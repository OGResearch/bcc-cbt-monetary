
clear, clc

N = 10^7;

x = randn(N,1);

tic
y1 = x(x < 0);
toc

tic
y2 = x(find(x < 0));
toc