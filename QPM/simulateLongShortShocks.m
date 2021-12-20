%% Simulate long-lived vs short-lived shocks to inflation

close all
clear

load mat/readModel.mat m

for T = [1, 5]

    % Long-lived shock
    d1 = zerodb(m, 1:40);
    d1.shock_dl_cpi_core(T) = 1;
    s1 = simulate(m, d1, 1:40, "deviation", true, "prependInput", true);

    % Short-lived shock
    d2 = zerodb(m, 1:40);
    d2.shock_dl_cpi_core_short(T) = 1;
    s2 = simulate(m, d2, 1:40, "deviation", true, "prependInput", true);

    % Combination
    d3 = zerodb(m, 1:40);
    d3.shock_dl_cpi_core(T) = 0.4;
    d3.shock_dl_cpi_core_short(T) = 0.6;
    s3 = simulate(m, d3, 1:40, "deviation", true, "prependInput", true);


    s = databank.merge("horzcat", s1, s2, s3);

    ch = databank.Chartpack();
    ch.Range = 0:40;
    ch.PlotSettings = {"marker", "s"};

    ch < ["l_y_gap", "dl_cpi_core", "dl_cpi", "l_cpi", "i", "l_s", "r", "l_z", "xxx"];
    draw(ch, s);

    legend("Long-lived", "Short-lived", "Combination");
    visual.heading("Cost-push shocks in period " + string(T));
end
