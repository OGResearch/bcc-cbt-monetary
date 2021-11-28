
% Housekeeping

clear, clc

%% Logical variables

a = 7;

b = a + 8;
c = a < 8;

T1 = true(3,4);

T2 = false(3,4);

A = randn(5,3)

d = A <= 0;

% Logical operations

X = randn(1000,1);

ind1 = X < -2.5;
ind2 = X > 2.5;

ind3 = ind1 | ind2;
ind4 = ind1 & ind2;

% Logical indexing

X1 = X(ind1)
X2 = X(ind2)

ind5 = ~ind1 & ~ind2

X1 = X(find(ind5)) % Much slower!!!

X1 = X(ind5)

min(X1)
max(X1)

%% Rounding

round(0.6) % 1, standard rounding

fix(0.6) % Towards 0
fix(-0.6)

floor(0.6) % Towards the nearest smaller
floor(-0.6) % Towards the nearest smaller

ceil(0.6) % Towards the nearest larger
ceil(-0.6) % Towards the nearest smaller

%% Statistical function

X = randn(10^4, 5);

sum(X)

% Careful with vectors!!!
v = randn(1, 5);
sum(v)

% Rowwise operation
sum(X,2) % Second input: along which dimenstion the sum should be calculated

sum(v,1)

% min/max/diff behave differently

min(3,2) % Smaller of the two

min(X,2) % Smaller of the two (an array of the same size as X)

min(X,[],2) % Minimum for each row

diff(X,2) % This is second difference, and not difference by columns

diff(X,[],2) % Columnwise difference

% Sorting vectors

X = rand(10,1);

[X, sort(X)]

[X, sort(X, 'descend')]

[X, I] = sort(X) % The index of the sorting

% % Sorting matrices by rows
% 
% X = rand(10, 2)
% 
% [X, sortrows(X)]
% 
% [X, sortrows(X,2,'descend')]
% 
% 

%% For loop

clc

% for i = 1:10
%   i
% end

% v = 1:10 % This is a ROW vector
% for i = v
%   i
% end

% v = (1:10)' % This is a COLUMN vector
% for i = v
%   i
% end

% v = rand(5,3) % This is an ARRAY
% for i = v
%   i
% end

for i = 10 : -3 : 2
  i
end
