function dbComp = simulateDelayedResponse(m)

rngSim = 0:40;

dbInit = sstatedb(m, rngSim);
dbInit.shock_l_y_gap(0) = 1;

% Simple simulation (IRF)
dbSim0 = simulate(m, dbInit, rngSim);
dbSim0 = dbminuscontrol(m, dbSim0, dbInit);

% Simulate delayed policy response

fixRng = 0:5;

% With anticipated shocks

pln1 = Plan(m, rngSim, "anticipate", true);
pln1 = endogenize(pln1, fixRng, "shock_i");
pln1 =  exogenize(pln1, fixRng, "i");

dbSim1 = simulate(m, dbInit, rngSim, "plan", pln1);
dbSim1 = dbminuscontrol(m, dbSim1, dbInit);

% With surprise shocks

pln2 = Plan(m, rngSim, "anticipate", false);
pln2 = endogenize(pln2, fixRng, "shock_i");
pln2 =  exogenize(pln2, fixRng, "i");

dbSim2 = simulate(m, dbInit, rngSim, "plan", pln2);
dbSim2 = dbminuscontrol(m, dbSim2, dbInit);

% Plot the results

dbComp = databank.merge("horzcat", dbSim0, dbSim1, dbSim2);

dbComp = databank.retrieve(dbComp, ["i", "e_dl_cpi", "dl_cpi", "l_y_gap"]);

dbplot(dbComp, 'range', rngSim, 'zeroline', true, ...
  'linestyle',  '-', ...
  'marker',     '.');
legend(["No delay", "Anticipated delay", "Surprise delay"])

end