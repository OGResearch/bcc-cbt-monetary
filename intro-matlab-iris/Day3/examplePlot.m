
clear, clc, close all

% Load data
load("../data/data.mat", "db")

% Simple plot of a time series
plot(db.GDP);

% A customized plot of a time series
plot(db.GDP, "b*-.");
grid on
title("GDP")
ylabel("Level")

% A customized plot of a time series
plot(db.GDP, ...
  "color",      "b", ...
  "linestyle",  ":", ...
  "linewidth",  2, ...
  "marker",     "o", ...
  "markersize", 9 ...
);
grid on
title("GDP")
ylabel("Level")

% Plot another series in the same axis
hold on
plot(db.INFL,  ...
  "color",      "g", ...
  "linestyle",  "--", ...
  "linewidth",  0.5, ...
  "marker",     "x", ...
  "markersize", 12 ...
);

% Plot multiple time series
figure(); % Create a new figure window for comparison
plot(pct([db.GDP, db.INFL], -4));
grid on
legend(["GDP",    "Price level"], ...
  "location",     "southOutside", ...
  "orientation",  "horizontal");
ylabel("% change, y-on-y")

% % Plot multiple axis plots
% figure(); % Create a new figure window for comparison
% plotyy(db.GDP, db.INFL);
% grid on
% legend(["GDP", "Price level"]);