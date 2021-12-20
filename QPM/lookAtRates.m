
close all
clear

h = databank.fromCSV("csv/initial-conditions.csv");
load mat/readModel.mat m

chartRange = qq(2010,1):qq(2021,4);

figure();
tiledlayout("flow");

nexttile();
plot(chartRange, [h.il, real(m.il)]);
title("Lending rate");

nexttile();
plot(chartRange, [h.i, real(m.i)]);
title("Policy rate");

nexttile();
plot(chartRange, [h.il_spread, real(m.il_spread)]);
title("Lending spread");
