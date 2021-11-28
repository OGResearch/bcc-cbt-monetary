
clear, clc

N = 10^3;

A = randn(N,N);
b = randn(N,1);

tic
x1 = inv(A) * b;
toc

tic
x2 = A\b;
toc

max(abs(x1-x2))