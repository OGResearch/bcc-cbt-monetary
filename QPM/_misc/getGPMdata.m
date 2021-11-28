function getGPMdata

dbGPM = databank.fromCSV("C:\svn\published_results\gpm202110\fo\results\gpm_forecast_20211027.csv");

db.l_y_ez     = dbGPM.L_GDP_EZ;
db.l_y_ez_gap = dbGPM.L_GDP_GAP_EZ;

db.l_cpi_ez = dbGPM.L_CPI_EZ/100;
db.l_cpi_us = dbGPM.L_CPI_EZ/100;

db.i_ez = dbGPM.RS_EZ;

db.eur_usd = dbGPM.S_EZ;

db.r_ez_gap = dbGPM.RR_GAP_EZ;
db.r_ez_tnd = dbGPM.RR_BAR_EZ;

db.l_wp_oil     = dbGPM.L_OIL_US;
db.l_rp_oil_gap = dbGPM.L_QOIL_GAP_US;

databank.toCSV(db, "../data/dataGPM.csv", "comment", false, "class", false);

end