%% Reconcile two consecutive forecasts

close all
clear

load mat/readModel.mat m

prevStartFcast = qq(2021,3);
currStartFcast = prevStartFcast + 1;
currEndFcast = currStartFcast + 5*4 - 1;
startChart = prevStartFcast - 2*4;
endChart = currEndFcast;

prev = databank.fromCSV("csv/baseline-forecast-2021Q3.csv");

curr = databank.fromCSV("csv/baseline-forecast-2021Q4.csv");
hist = databank.clip(curr, -Inf, currStartFcast-1);


%% Compare previous and current forecasts

ch = databank.Chartpack();
ch.Range = startChart:endChart;
ch.Highlight = currStartFcast;

ch < ["i", "dl_cpi", "dl_cpi_core", "dl_cpi_ncore", "dl_y", "l_y_gap", "exp(l_s/100)"];


%% Reconcile the differences in previous and current forecasts


% Simulate with old initial conditions and old shocks
prev0 = simulate(m, prev, currStartFcast:currEndFcast, "prependInput", true);




% Effect of initial conditions
% Simulate with new initial conditions and old shocks
% Copy over all variables (but not shocks) from curr to temp
temp = prev;
temp = databank.copy(curr, "sourceNames", access(m, "transition-variables"), "targetDb", temp);

recon1 = simulate(m, temp, currStartFcast:currEndFcast, "prependInput", true);





% Effect of external assumptions and trend assumptions
% Simulate with new initial conditions, new external shock, old other
% shocks
temp = prev;
temp = databank.copy(curr, "sourceNames", access(m, "transition-variables"), "targetDb", temp);
externalShocks = ["shock_l_yf_gap", "shock_if", "shock_dl_cpif"];
trendShocks = ["shock_g_y_tnd", "shock_r_tnd", "shock_dl_z_tnd", "shock_rf_tnd"];
temp = databank.copy(curr, "sourceNames", [externalShocks, trendShocks], "targetDb", temp);

recon2 = simulate(m, temp, currStartFcast:currEndFcast, "prependInput", true);




% Effect of NTF
temp = prev;
temp = databank.copy(curr, "sourceNames", access(m, "transition-variables"), "targetDb", temp);
externalShocks = ["shock_l_yf_gap", "shock_if", "shock_dl_cpif"];
trendShocks = ["shock_g_y_tnd", "shock_r_tnd", "shock_dl_z_tnd", "shock_rf_tnd"];
ntfShocks = ["shock_dl_cpi_core", "shock_dl_cpi_ncore", "shock_l_y_gap", "shock_l_s", "shock_i"];
temp = databank.copy(curr, "sourceNames", [externalShocks, trendShocks, ntfShocks], "targetDb", temp);

recon3 = simulate(m, temp, currStartFcast:currEndFcast, "prependInput", true);




%% Chart results

draw(ch, databank.merge("horzcat", curr, prev0, recon1, recon2, recon3));

visual.hlegend( ...
    "bottom" ...
    , "Current" ...
    , "Previous" ...
    , "Effect of initials" ...
    , "Effect of externals" ...
    , "Effect of NTF" ...
);


%% Tabular results for output gap


[
    prev.l_y_gap ...
    , curr.l_y_gap ...
    , recon1.l_y_gap-prev.l_y_gap ...
    , recon2.l_y_gap-recon1.l_y_gap ...
    , recon3.l_y_gap-recon2.l_y_gap ...
    , curr.l_y_gap-recon3.l_y_gap ...
]
