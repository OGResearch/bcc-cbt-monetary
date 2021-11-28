
clear, clc

N = 10^4;

tic
for n = 1:N
  a = 1 + 1
end
toc

tic
for n = 1:N
  a = 1 + 1;
end
toc