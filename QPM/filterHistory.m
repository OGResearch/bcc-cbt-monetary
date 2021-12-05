function filterHistory

% Porcess options
opts    = mainSettings();
rngFilt = opts.filter.rngFilt;
dbMult  = opts.filter.dbMult;
dbTunes = opts.filter.dbTunes;

% Load the model
tmp = load("results/model.mat");
m   = tmp.m;

% Load the data
tmp   = load("results/data.mat");
dbObs = tmp.dbObs;

% Add tunes
dbObs = databank.merge("vertcat", dbObs, dbTunes, "missingField", Series());

% Calculate unobserved variables
[~, dbFilt] = filter(m, dbObs, rngFilt, ...
  'relative', false, ...
  'Multiply', dbMult);

% Save the results
save("results/filter.mat", "dbFilt", "rngFilt", "dbMult");

end