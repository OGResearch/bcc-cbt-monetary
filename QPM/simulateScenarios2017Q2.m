%% Run forecast scenarios


%% Clear workspace

close all
clear


%% Load models and data

load mat/readModel.mat m
load mat/dates-2017Q2.mat startHist endHist startFcast endFcast
h = databank.fromCSV("csv/initial-conditions-2017Q2.csv");
hh = databank.fromCSV("csv/initial-conditions.csv");

endExternals = endHist + 2;
startChart = startFcast - 5*4;

m.c1 = 0.85;
m.c2 = 1.70;
m = solve(m);



%% Hands-free

f0 = simulate( ...
    m, h, startFcast:endFcast ...
    , "prependInput", true ...
);


%% Add trend and external projections

p1 = Plan.forModel(m, startFcast:endFcast);
% p1 = swap( ...
%     p1, startFcast:endFcast ...
%     , ["dl_y_tnd", "shock_g_y_tnd"] ...
%     , ["r_tnd", "shock_r_tnd"] ...
%     , ["dl_z_tnd", "shock_dl_z_tnd"] ...
%     , ["rf_tnd", "shock_rf_tnd"] ...
% );

p1 = swap( ...
    p1, startFcast:endExternals ...
    , ["dl_cpif", "shock_dl_cpif"] ...
    , ["if", "shock_if"] ...
    , ["l_yf_gap", "shock_l_yf_gap"] ...
    , ["l_s", "shock_l_s_long"] ...
);


h.shock_dl_cpi_core_short = Series();
h.shock_dl_cpi_core_short(qq(2018,1)) = 1;

f1 = simulate( ...
    m, h, startFcast:endFcast ...
    , "prependInput", true ...
    , "plan", p1 ...
    , "method", "stacked" ...
);



%% Chart forecast scenarios


ch = databank.Chartpack();
ch.Range = startChart:endFcast;
ch.Highlight = startChart:endHist;

ch < ["i", "dl_cpi", "dl_cpi_core", "dl_cpi_ncore", "l_y_gap", "exp(l_s/100)", "l_z_gap", "il", "il_ceil-il"];
draw(ch, databank.merge("horzcat", hh, f1));


