
close all
clear all


load mat/readModel.mat m
load mat/prepareDataForPassThrough.mat h

m.rho_dl_z_tnd = 0;
m = solve(m);

%{
d0 = zerodb(m, 1:40);
d0.shock_l_s(1) = 10;

s0 = simulate( ...
    m, d0, 1:40 ...
    , "deviation", true ...
    , "prependInput", true ...
);
%}


d = zerodb(m, 1:40);

d.l_s(1:18) = h.l_s(1:18);
d.l_s(19:40) = h.l_s(18);
d.shock_dl_z_tnd(1) = 10*4;
d.dl_cpif = h.dl_cpif;

T = 40;
p = Plan.forModel(m, 1:40, "anticipate", true);
p = exogenize(p, 1:T, ["l_s"]);
p = endogenize(p, 1:T, ["shock_l_s"]);
p = exogenize(p, 1:18, ["dl_cpif"]);
p = endogenize(p, 1:18, ["shock_dl_cpi_f"]);

s = simulate( ...
    m, d, 1:40 ...
    , "deviation", true ...
    , "prependInput", true ...
    , "plan", p ...
);

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Highlight = 0:T;
ch.PlotSettings = {"marker", "s"};
ch.YLine = 0;

chartDb = databank.merge("horzcat", s, h, MissingField=NaN);

ch < ["l_s", "shock_l_s", "l_cpi", "l_cpi_core", "l_cpi_ncore", "l_y_gap"];
ch < ["dl_s", "dl_cpi", "dl_cpi_core", "dl_cpi_ncore", "i", "l_z", "l_z_gap"];
ch < ["l_z_tnd", "dl_cpif"];
draw(ch,chartDb);

