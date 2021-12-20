
close all
clear

load mat/readModel.mat m


d = zerodb(m, 0:40);
d.shock_dl_cpi_core(5) = 1;


s = simulate(m, d, 1:40, "prependInput", true, "deviation", true);


ch = databank.Chartpack();
ch.Range = 0:20;
ch.Highlight = 5;
ch.YLine = 0;

ch < ["l_y_gap", "dl_cpi_core", "dl_cpi", "i", "dl_s"];
draw(ch, s);


