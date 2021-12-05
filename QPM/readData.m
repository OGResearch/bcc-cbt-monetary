function readData

% Read the data from the CSV file
db = databank.fromCSV("data/data_tunisia.csv");

% Read GPM data
dbGPM = databank.fromCSV("data/dataGPM.csv");

% Process data

dbObs.obs_l_y         = 100*(log(db.gdp - db.gdp_agriculture));
dbObs.obs_l_cpi_core  = 100*(x12(log(db.cpi_core1)));
dbObs.obs_l_cpi_ncore = (100*(x12(log(db.cpi_freshfood)))*0.127 + 100*(x12(log(db.cpi_administ)))*0.265) / (0.127 + 0.265);
dbObs.obs_i           = 100*log(1 + db.mmr/100);
dbObs.obs_l_s         = 100*log(db.eur_tnd);
dbObs.obs_def         = -x12(db.fisc_bal);

dbObs.obs_l_cpi_f   = 100*x12(log(db.cpi_ea));
dbObs.obs_l_y_f_gap = 100*hpf2(log(db.gdp_ea{qq(2000,1) : qq(2019,4)}));
dbObs.obs_i_f       = 100*log(1 + db.nr_ea/100);

obs_l_rp_oil = 100*log(db.wp_oil) - dbGPM.l_cpi_us;
dbObs.obs_l_rp_oil_gap = hpf2(obs_l_rp_oil);

obs_r_f = dbObs.obs_i_f - 4*diff(dbObs.obs_l_cpi_f);
dbObs.obs_r_f_tnd = hpf(obs_r_f{qq(2000,1) : qq(2019,4)}, 'lambda', 1600*0.5);

% Save the results
save("results/data.mat", "db", "dbObs", "dbGPM");

end