function filterHistory

% Porcess options

opts = mainSettings();

rngFilt = opts.filter.rngFilt;

% Load the model

tmp = load("results/model.mat");
m   = tmp.m;

% Load the data

tmp = load("results/data.mat");
db   = tmp.dbObs;

% Create default multiplier database

dbMult = struct();
shockNames = string(get(m, "eNames"));
for n = shockNames
  dbMult.("std_" + n) = Series(rngFilt, 1);
end

% Apply std multipliers

multNames = string(fieldnames(opts.filter.dbMult));
for mn = multNames(:)'
  dbMult.(mn) = opts.filter.dbMult.(mn);
end

% Calculate unobserved variables

[~, dbFilt] = filter(m, db, rngFilt, ...
  'relative', false, ...
  'Multiply', dbMult);

% Save the results

save("results/filter.mat", "dbFilt", "rngFilt", "dbMult");

end