
close all
clear


db = databank.fromCSV("data/data_tunisia.csv");

db.cpi = x13.season(db.cpi);
db.cpi_core = x13.season(db.cpi_core1);
db.l_cpi_ncore = (100*(log(x13.season(db.cpi_freshfood)))*0.127 + 100*(log(x13.season(db.cpi_administ)))*0.265) / (0.127 + 0.265);

db.l_s = 100*log(db.eur_tnd);
db.l_cpi = 100*log(db.cpi);
db.l_cpi_core1 = 100*log(x13.season(db.cpi_core1));
db.l_z = 100*log(db.cpi_ea * db.eur_tnd / db.cpi);
db.l_cpif = 100*log(x13.season(db.cpi_ea));

db.l_s_tnd = hpf( clip(db.l_s, -Inf, qq(2017,1)), qq(2000,1):qq(2021,3));
db.l_z_tnd = hpf( clip(db.l_z, -Inf, qq(2017,1)), qq(2000,1):qq(2021,3));


db.dl_cpi = adiff(db.l_cpi);
db.dl_cpif = adiff(db.l_cpif);
db.dl_cpi_core1 = adiff(db.l_cpi_core1);
db.dl_cpi_ncore = adiff(db.l_cpi_ncore);


h.i = redate(db.mmr, qq(2017, 1), 0) - db.mmr(qq(2017,1));
h.l_s = redate(db.l_s - db.l_s_tnd, qq(2017, 1), 0);
h.l_z = redate(db.l_z - db.l_z_tnd, qq(2017, 1), 0);
h.dl_cpi = redate(db.dl_cpi, qq(2017, 1), 0) - 4;
h.dl_cpif = redate(db.dl_cpif, qq(2017, 1), 0) - 1;
h.dl_cpi_core = redate(db.dl_cpi_core1, qq(2017, 1), 0) - 4;
h.dl_cpi_ncore = redate(db.dl_cpi_ncore, qq(2017, 1), 0) - 4;


%% Plot 

plotRange = qq(2010,1):qq(2021,4);

figure();

subplot(2, 2, 1);
plot(plotRange, [db.l_s, db.l_s_tnd]);
visual.highlight(qq(2017,1));
title("Nominal exchange rate");

subplot(2, 2, 2);
plot(plotRange, [db.l_z, db.l_z_tnd]);
visual.highlight(qq(2017,1));
title("Real exchange rate");

subplot(2, 2, 3);
plot(plotRange, [db.dl_cpi, 4]);
visual.highlight(qq(2017,1));
title("Headline CPI Q/Q PA");

subplot(2, 2, 4);
plot(plotRange, [db.mmr, db.mmr(qq(2017,1))]);
visual.highlight(qq(2017,1));
title("Policy rate");


%%

save mat/prepareDataForPassThrough.mat h
