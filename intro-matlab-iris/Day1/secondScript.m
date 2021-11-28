
% Housekeeping

clear, clc

%% Basic matrix creation

A = [1, 2; 3, 4]

size(A)

B = [
  1 2
  3 4
  ]

% Be careful with spaces!!
c1 = [1, -1]
c2 = [1 -1]
c3 = [1, - 1]
c4 = [1 - 1]

% Special matrices

D0 = zeros(7,3)

D1 = ones(7,3)

I = eye(10)

% Special vectors

v1 = 1:10

v2 = 1:2:10

v3 = 1/3 : 2.1 : 10

v4 = 10 : -1.7 : 0.1

v5 = 0.1 : -1.7 : 10

v6 = linspace(0, 1, 21)

% Transpose

v1t = v1'

% Special values

s1 = 1/0

I1 = inf(3,4)

s2 = 0/0

I2 = nan(13,1)

% Random matrices

R1 = rand(13, 3)

R2 = randn(13, 3)

%% Basic matric calculations

% Simple operators

nrows = 13;
ncols = 5;

A = rand(nrows, ncols);

B = rand(nrows, ncols);

C = A + B

D = A - B

% E = A * B % Error!!!

E = A * B'

% Elementwise operation

F = A .* B

% F = A .* B' % Error!!!

G = A ./ B

H = A .^ B

% Vectorization

v = linspace(0, 1, 21);

sqrtv = sqrt(v);

% Concatenation

cc1 = [v, sqrtv]

cc2 = [v', sqrtv']

% cc2 = [v', sqrtv] % Error!!!

cc3 = [v; sqrtv]'

% Extracting parts of a matrix

I = rand(10,10)

Id = diag(I)

% Creating a diagonal matrix

v = rand(10,1)

Dv = diag(v)

% Reshaping a matrix

K = rand(6,2)

reshape(K, 1, [])

reshape(K, [], 1) % this is the vec operator of many economteric textbooks

reshape(K, 3, 4)

%% Indexing into a matrix

A = randn(5,3)

% a = A(4,2)

% b = A(4,:)

% c = A(:,2)

% d = A(:, [1, 3])

% e = A(2, [1, 3])

e = A([2, 5], [1, 3])

% Assigning to particular elements

A([2, 5], [1, 3]) = 0

A(:,2) = 1

A(:,3) = 1:5

l = A(1, end)

l = A(end, 1)

l = A(3, end-1)

l = A(end-1:end, 1)
