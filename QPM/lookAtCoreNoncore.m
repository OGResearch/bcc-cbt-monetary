
close all
clear


h = databank.fromCSV("csv/initial-conditions.csv");
load mat/readModel.mat m


figure();
tiledlayout("flow");

nexttile();
plot([h.l_cpi_ncore-h.l_cpi_core]);
yyaxis right
plot([h.dl_cpi_ncore, h.dl_cpi_core]);
title("Relative price ncore-core");
legend("Relative price level", "Noncore inflation", "Core inflation");
