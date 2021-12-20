
close all
clear

load mat/readModel.mat m

% Create an initial steady-state databank with high inflation target
d = steadydb(m, -8:40);


% Create thre new models
%
% * all have a low inflation target
% * model #1 is baseline calibration
% * model #2 is with lower weight on fwl expectations in Phillips curve
% * model #3 is with reduced sensitivity of fx to interest differential

m1 = m;

m1.ss_dl_cpi_tar = 3;
m1.rho_dl_cpi_tar = 0;

% m1.b1(2) = m1.b1(2) - 0.1;
% m1.e2(3) = m1.e2(3) - 0.1;

m1 = solve(m1);
m1 = steady(m1);

table(m1, ["steadyLevel"])

s = simulate(m1, d, 1:40, "prependInput", true);

ch = databank.Chartpack();
ch.Range = -8:40;
ch.Highlight = -8:0;
ch.PlotSettings = {"marker", "s"};

ch < ["l_y_gap", "cumsum(l_y_gap)/4", "dl_cpi_core", "dl_cpi", "i", "dl_s", "l_s", "r"];
draw(ch, databank.merge("horzcat", s));

% legend("Baseline", "Lower weight on fwl expectations", "Reduced sensitivity of fx to interest differential");


