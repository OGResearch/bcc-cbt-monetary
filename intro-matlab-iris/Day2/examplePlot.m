
clear, clc, close all

readData

GDP_QQ = diff(log(GDP))*100*4;
CPI_QQ = diff(log(INFL))*100*4;
quarters_QQ = quarters(2:end);

figure;

plot(quarters_QQ, GDP_QQ, ...
  'color',      'r', ...
  'linewidth',  2, ...
  'marker',     '*', ...
  'markersize', 16)

hold

plot(quarters_QQ, CPI_QQ, ...
  'color',      [0.3 0.1 0.7], ...
  'linewidth',  0.5, ...
  'marker',     '+', ...
  'markersize', 6)

datetick('x', 'mmm-yyyy')
grid
%title('GDP')
legend 'GDP' 'CPI'
% xlabel('Time')
ylabel('Annualized q-on-q change')

% figure;
% plot(quarters, INFL)
% datetick('x', 'mmm-yyyy')

