%% Simulate pro-inflationary shocks with and without ceiling

close all
clear

load mat/readModel.mat m


m = alter(m, 2);
m.switch_ceiling = [1, 0];
m.a7 = 0.05;
m.b9 = 0.1;
m.b23 = 0.5;
m.b22 = 0;
m.c1 = 0.85;
m.c2 = 2.25;
m = solve(m);

d = steadydb(m, 1:40);
d.shock_l_y_gap(1:6) = 1;
d.shock_dl_cpi_core(1:6) = 1;


s = simulate(m, d, 1:40, "prependInput", true, "method", "stacked");

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Round = 8;

ch < ["l_y_gap", "dl_cpi_core", "i", "il" "il_ceil", "il-il_ceil", "l_s"];
ch < ["dl_cpi_ncore", "dl_cpi", "l_cpi_rel"];

draw(ch, s);
visual.heading("Monetary policy with lending rate ceiling");
visual.hlegend("bottom", "Ceiling", "No ceiling");

