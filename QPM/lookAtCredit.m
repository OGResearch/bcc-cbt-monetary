%% Look at outstanding and new credit


load mat/readModel.mat mx

db = databank.fromCSV("csv/raw-data.csv");


figure();

subplot(2, 2, 1);
plot([1 - (db.credxa-db.cred_new_flows2)/db.credit_total{-1}, mx.c1_l_bc]);
title("Repayment coefficient");


subplot(2, 2, 2);
plot([db.cred_new_flows2 / db.gdpxa_nom, real(mx.bc_new_to_ny)]);
title("New credit to nominal GDP ratio");


subplot(2, 2, 3);
plot([db.credxa / (4*db.gdpxa_nom), real(mx.bc_to_ny)]);
title("Outstanding credit to nominal GDP ratio, PA");
