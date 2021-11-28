
clear, clc, close all

% Read nonlinear model

s.nonlinear = true;

m0 = Model("rbc.model", "Linear", false, "Growth", false, ...
  "Assign", s);

m0.beta  = 0.995;
m0.sigma = 1;
m0.phi   = 0;
m0.delta = 0.05;
m0.alpha = 0.4;
m0.rho_A = 0.7;

m0 = sstate(m0);
m0 = solve(m0);
chksstate(m0);

% Read linearized model

s.nonlinear = false;

m1 = Model("rbc.model", "Linear", true, "Growth", false, ...
  "Assign", s);
m1 = assign(m1, get(m0, "Parameters"));

ss0 = get(m0, "SteadyLevels");

m1.cy   = ss0.c  / ss0.y;
m1.ivy  = ss0.iv / ss0.y;

m1 = solve(m1);
m1 = sstate(m1);
chksstate(m1);

% Simulate both model using first order approximation

rngSim = 0:10;

db0 = sstatedb(m0, rngSim);
db0.shock_A(0) = 1;
db0 = simulate(m0, db0, rngSim); 

db1 = sstatedb(m1, rngSim);
db1.shock_A(0) = 1;
db1 = simulate(m1, db1, rngSim); 

[log(db0.k/ss0.k) - db1.k]