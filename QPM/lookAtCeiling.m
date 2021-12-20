
close all
clear

h = databank.fromCSV("csv/initial-conditions.csv");


h.il_ceil_ma = 0.5*(h.il{-1} + h.il{-2}) * 1.20 ;%+ 0.5 - (h.il{-1}-h.il{-2});

figure();
plot([h.il, h.il_ceil, h.il_ceil_ma]);
yyaxis right
bar(h.il_ceil_ma-h.il_ceil);

