
clear, clc, close all

% Load the data
load("../data/data.mat", "db");

% Set range
rngHP = qq(1999,1) : qq(2011,4);

% HP filtering

y = 100*log(db.GDP{rngHP});
[y_tnd, y_gap] = hpf(y, "lambda", 1600);

subplot(2,1,1)
plot([y, y_tnd]);
grid
legend(["Actual", "HP trend"]);
title("GDP")
ylabel("100*log")

subplot(2,1,2)
bar(y_gap);
grid
title("Output gap")
ylabel("Percent")

% Seasonal adjustment

% Adjustment range
rngSA = qq(1999,1) : qq(2011,4);

y = 100*log(db.Profit{rngSA});
y_sa = x12(y);

figure();
plot([y, y_sa]);
grid on
hax = gca;
hax.FontSize = 16;
hax.FontWeight = "bold";
legend(["Actual", "Seasonally adjusted"])

% OLS regression, AR(p) estimation

rngEst = qq(1999,1) : qq(2014,4);
y = diff(100*log(db.INFL));
y = y{rngEst};

rhs = [y{-1}, y{-2}, y{-3}];
[b, bstd] = regress(y, rhs, "intercept", true);
fit = rhs * b(1:3) + b(4);

figure();
plot([y, fit]);
legend(["Actual", "Fitted"]);
grid
