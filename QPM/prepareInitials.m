%% Prepare data initials


%% Clear workspace

close all
clear

%% Load basic and extended versions of the model

load mat/readModel.mat m mx

% Read the data from the CSV file
db = databank.fromCSV("data/forecast_tunisia.csv");


% Process data
startHist = qq(2000,1);
endHist = qq(2021,2);
startFcast = endHist + 1;
endFcast = endHist + 5*4;

h = struct();

h.l_y = 100*(log(db.gdp - db.gdp_agriculture));
h.dl_y = 4*diff(h.l_y);

h.l_cpi = 100*log((db.cpi));
h.l_cpi_core  = 100*log((db.cpi_core1));
h.l_cpi_ncore = (100*log((db.cpi_freshfood))*0.127 + 100*log((db.cpi_administ))*0.265) / (0.127 + 0.265);
h.w_core = 1 - (0.127 + 0.265);
h.dl_cpi = 4*diff(h.l_cpi);
h.dl_cpi_core = 4*diff(h.l_cpi_core);
h.dl_cpi_ncore = 4*diff(h.l_cpi_ncore);
h.dl_cpi_tar = Series(qq(2015,1):endFcast, 4);

h.i = 100*log(1 + db.mmr/100);
h.l_s = 100*log(db.eur_tnd);
h.dl_s = 4*diff(h.l_s);
h.il = db.cred_new_ir;
h.il_ceil = db.il_ceil;

h.l_cpif = 100*log((db.cpi_ea));
h.dl_cpif = 4*diff(h.l_cpif);

h.l_yf = 100*log(db.gdp_ea);
h.dl_yf = 4*diff(h.l_yf);
h.if = db.nr_ea;

h.l_rp_oil = 100*log(db.wp_oil/db.cpi_us);
[h.l_rp_oil_tnd, h.l_rp_oil_gap] = hpf(h.l_rp_oil);

h.rf = h.if - h.dl_cpif;
[h.rf_tnd, h.rf_gap] = hpf(h.rf{qq(2000,1) : qq(2019,4)}, 'lambda', 1600*0.5);

h.def = -x13.season(db.fisc_bal);

%% Auxiliary variables for short and long shocks

h.aux_dl_cpi_core_short = Series(startHist:endFcast, 0);
h.aux_l_s_long = Series(startHist:endFcast, 0);


%% Define composite variables 

h.l_z = h.l_cpif + h.l_s - h.l_cpi;

h.r1 = h.i - h.dl_cpi;

h.rf1 = h.if - h.dl_cpif;


%% Fiscal deficit

level = Series();
level(endFcast) = real(m.str_def);

change = Series();
change(endFcast) = 0;

[h.str_def, h.cyc_def] = hpf( ...
    h.def, startHist:endFcast ...
    , "level", level ...
    , "change", change ...
);


%% Potential output

[h.l_y_tnd0, h.l_y_gap0] = hpf(h.l_y, startHist:endFcast);

level = Series();
level(qq(2019,4)) = h.l_y(qq(2019,4)) - 1;
level(qq(2021,1)) = h.l_y(qq(2021,1)) + 4;

change = Series();
change(endFcast) = real(m.dl_y)/4;

[h.l_y_tnd, h.l_y_gap] = hpf( ...
    h.l_y, startHist:endFcast ...
    , "change", change ...
    , "level",  level ...
);

h.dl_y_tnd = 4*diff(h.l_y_tnd);
h.g_y_tnd = h.dl_y_tnd;


%% Foreign demand trend

[h.l_yf_tnd0, h.l_yf_gap0] = hpf(h.l_yf, startHist:endFcast);

level = Series();
level(qq(2019,4)) = h.l_yf(qq(2019,4)) - 0.5;
level(qq(2021,2)) = h.l_yf(qq(2021,2)) + 2.5;

change = Series();
change(endFcast) = 1.5/4;

[h.l_yf_tnd, h.l_yf_gap] = hpf( ...
    h.l_yf, startHist:endFcast ...
    , "change", change ...
    , "level",  level ...
);

h.dl_yf_tnd = 4*diff(h.l_yf_tnd);


%% Real exchange rate

[h.l_z_tnd0, h.l_z_gap0] = hpf(h.l_z, startHist:endFcast);

level = Series();
level(qq(2021,3)) = h.l_z(qq(2021,3)) + 3;

change = Series();
change(endFcast) = real(m.dl_z)/4;

[h.l_z_tnd, h.l_z_gap] = hpf( ...
    h.l_z, startHist:endFcast ...
    , "level", level ...
    , "change", change ...
);

h.dl_z_tnd = 4*diff(h.l_z_tnd);


%% Real interest rate

[h.r_tnd0, h.r_gap0] = hpf(h.r1, startHist:endFcast);

level = Series();
level(endFcast) = real(m.r);

change = Series();
change(endFcast) = 0;

[h.r_tnd, h.r_gap] = hpf( ...
    h.r1, startHist:endFcast ...
    , "level", level ...
    , "change", change ...
);


%% Foreign real rates

[h.rf_tnd0, h.rf_gap0] = hpf(h.rf1, startHist:endFcast);

level = Series();
level(endFcast) = real(m.rf);

change = Series();
change(endFcast) = 0;

[h.rf_tnd, h.rf_gap] = hpf( ...
    h.rf1, startHist:endFcast ...
    , "level", level ...
    , "change", change ...
);


%% Implied real trend disparity

h.prem = h.r_tnd - h.rf_tnd - h.dl_z_tnd{+1};



%% Direct pass-through auxiliary term

% h.dpt = h.dl_cpif + h.dl_s - h.dl_cpi_core - h.dl_z_tnd;
h.dpt = Series(startHist:endFcast, 0);



%% Bank credit data


db.gdpxa_nom = db.gdp_nom - db.gdp_agr_nom;
db.credxa = db.credit_total - db.credit_agriculture;
h.l_ny = 100*log(db.gdpxa_nom);
h.dl_ny = 4*diff(h.l_ny);

% GDP deflator
h.l_py = h.l_ny - h.l_y;
h.dl_py = 4*diff(h.l_py);

h.l_bc = 100*log(db.credxa);
h.dl_bc = 4*diff(h.l_bc);
h.l_bch = 100*log(db.credit_houshl);
h.l_bcf = 100*log(db.credit_eses - db.credit_agriculture);
h.bc_to_ny = db.credxa/(4*db.gdpxa_nom);
h.l_bc_to_ny = 100*log(h.bc_to_ny);
h.l_bch_to_ny = 100*log(db.credit_houshl/(4*db.gdpxa_nom));
h.l_bcf_to_ny = 100*log((db.credit_eses-db.credit_agriculture)/(4*db.gdpxa_nom));

h.l_bch_to_ny_tnd = hpf( ...
    h.l_bc_to_ny ...
    , level=Series(endHist, 100*log(0.76)) ...
    , change=Series(endHist, 0) ...
    , lambda=15000 ...
);

db.cred_new_flows = x13.season(db.cred_new_flows_u);
db.cred_new_flows2 = 2*db.cred_new_flows;

h.l_bc_new = 100*log(db.cred_new_flows2);
h.bc_new_to_ny = db.cred_new_flows2/(db.gdpxa_nom);
h.l_bc_new_to_ny = 100*log(h.bc_new_to_ny);

h.i_bc_new = db.cred_new_ir;
h.i_bch_new = db.cred_new_hh_ir;
h.i_bcf_new = db.cred_new_eses_ir; 


%% Lending spread

h.il_spread = h.il - h.i;

[h.il_spread_tnd, h.il_spread_gap] = hpf( ...
    h.il_spread, Inf ...
    , "lambda", 5000 ...
    , "change", Series(endHist, 0) ...
    , "level", Series(endHist, real(m.il_spread)) ...
);


%% Relative price CPI ncore-core

h.l_cpi_rel = h.l_cpi_ncore - h.l_cpi_core;

h.l_cpi_rel_tnd = hpf( ...
    h.l_cpi_rel, Inf ...
    , "lambda", 100000 ...
    , "change", Series(endHist, 0) ...
    , "level", h.l_cpi_rel{endHist} ...
);


%% Verify completeness of initial conditions

checkInitials(m, h, startFcast);
checkInitials(mx, h, startFcast);


%% Save to CSV file

databank.toCSV(h, "csv/initial-conditions.csv", "decimals", 16);
databank.toCSV(db, "csv/raw-data.csv", "decimals", 16);

save mat/dates.mat startHist endHist startFcast endFcast
