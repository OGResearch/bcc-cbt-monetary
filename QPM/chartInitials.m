
close all
clear

h = databank.fromCSV("csv/initial-conditions.csv");
load mat/dates.mat startHist endHist startFcast endFcast
startChart = endHist - 10*4;


%% Input data


ch = databank.Chartpack();
ch.Range = startHist:endHist+3;
ch < ["dl_cpi", "dl_cpi_core", "dl_cpi_ncore"];
ch < ["i", "dl_y", "l_s"];
ch < ["dl_cpif", "if", "dl_yf", "l_rp_oil"];
draw(ch, h);


%% GDP

figure();
subplot(2, 2, 1);
plot(startChart:endFcast, [h.l_y, h.l_y_tnd]);
title("Potential output");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 2);
plot(startChart:endFcast, 4*diff([NaN, h.l_y_tnd]));
yline(0, "lineWidth", 2);
title("Potential output, Q/Q PA");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 3);
plot(startChart:endFcast, [NaN, h.l_y_gap]);
yline(0, "lineWidth", 2);
title("Output gap");
legend("Data", "Judgmentally adjusted");


%% Foreign demand

figure();
subplot(2, 2, 1);
plot(startChart:endFcast, [h.l_yf, h.l_yf_tnd]);
title("Foreign demand trend");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 2);
plot(startChart:endFcast, 4*diff([NaN, h.l_yf_tnd]));
yline(0, "lineWidth", 2);
title("Foreign demand trend, Q/Q PA");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 3);
plot(startChart:endFcast, [NaN, h.l_yf_gap]);
yline(0, "lineWidth", 2);
title("Foreign demand gap");
legend("Data", "Judgmentally adjusted");


%% RFX

figure();
subplot(2, 2, 1);
plot(startChart:endFcast, [h.l_z, h.l_z_tnd]);
title("RFX trend");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 2);
plot(startChart:endFcast, 4*diff([NaN, h.l_z_tnd]));
yline(0, "lineWidth", 2);
title("RFX trend, Q/Q PA");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 3);
plot(startChart:endFcast, [NaN, h.l_z_gap]);
yline(0, "lineWidth", 2);
title("RFX gap");
legend("Data", "Judgmentally adjusted");


%% RIR

figure();
subplot(2, 2, 1);
plot(startChart:endFcast, [h.r1, h.r_tnd]);
yline(0, "lineWidth", 2);
title("RIR trend");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 3);
plot(startChart:endFcast, [NaN, h.r_gap]);
yline(0, "lineWidth", 2);
title("RIR gap");
legend("Data", "Judgmentally adjusted");


%% Foreign RIR

figure();
subplot(2, 2, 1);
plot(startChart:endFcast, [h.rf1, h.rf_tnd]);
yline(0, "lineWidth", 2);
title("Foreign RIR trend");
legend("Data", "Judgmentally adjusted");

subplot(2, 2, 3);
plot(startChart:endFcast, [NaN, h.rf_gap]);
yline(0, "lineWidth", 2);
title("RIR gap");
legend("Data", "Judgmentally adjusted");


%% Other

figure();

subplot(2, 2, 1);
plot(startChart:endFcast, h.prem);
title("Implied UIP disparit");

subplot(2, 2, 2);
plot(startChart:endFcast, [h.def, h.str_def]);
title("Structural deficit");

