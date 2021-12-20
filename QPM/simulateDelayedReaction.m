
close all
clear


load mat/readModel.mat m



d = zerodb(m, 1:40);
d.shock_l_y_gap(1) = 1;


%% Plain vanilla demand shock
%
% * Look out for exchange rate behavior - first appreciation (interest rate
% differential), then long-run depreciation (because of cumulation of price
% level and unchange long-run real exchange rate)
%

s0 = simulate(m, d, 1:40, "deviation", true, "prependInput", true);


%% Delayed reaction
%
% * Look out for large build up in inflation and a large policy reaction
% needed
%

s = s0;

for T = 1 : 6
    p = Plan.forModel(m, 1:40);
    p = exogenize(p, 1:T, ["i"]);
    p = endogenize(p, 1:T, ["shock_i"]);
    
    d.i(1:T) = 0;
    
    s1 = simulate( ...
        m, d, 1:40, ...
        "deviation", true, ...
        "prependInput", true, ...
        "plan", p ...
    );

    s = databank.merge("horzcat", s, s1);
end

ch = databank.Chartpack();
ch.Range = 0:20;
ch.Highlight = 0:T;

ch < ["l_y_gap", "dl_cpi_core", "dl_cpi", "l_cpi", "i", "l_s", "r"];
draw(ch, s);

legend(["Immediate reaction", string(1:6)+" quarters delay"]);

