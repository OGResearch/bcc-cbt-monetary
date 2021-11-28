function plotTrends

% Load the filter results

tmp     = load("results/filter.mat");
db      = tmp.dbFilt.mean;
rngPlot = tmp.rngFilt;

numCol = 3;
numAlt = size(db.ttrend,2);
c = 0;

% Plot historical contributions

% Close an earlier figure window
figureTag = "filterTrend";
close(findobj('Tag', figureTag));
figure('Tag', figureTag);

% Output
actual      = db.l_y;
trend       = db.l_y_tnd;
titleString = "Real GDP, 100*log";
createTrendChart();

% RER
actual      = db.l_z;
trend       = db.l_z_tnd;
titleString = "Real exchange rate, 100*log";
createTrendChart();

% RIR
actual      = db.r;
trend       = db.r_tnd;
titleString = "Real interest rate, %";
createTrendChart();

% Exchange rate target
actual      = db.dl_s;
trend       = db.dl_s_tar;
titleString = "Nominal exchange rate, qq % @ar";
createTrendChart();

% Inflation target
actual      = db.dl_cpi_core;
trend       = db.dl_cpi_tar;
titleString = "Implicit inflation target, qq % @ar";
createTrendChart();

% Deficit
actual      = db.def;
trend       = db.str_def;
titleString = "Deficit, % of GDP";
createTrendChart();

utils.popaxes();

  function createTrendChart
    
    c = c + 1;
    
    red   = [1,0,0];
    green = [0,1,0];
    blue  = [0,0,1];
    white = red + green + blue;
    
    utils.subtightplot(2, numCol, c, 0.05, 0.05, 0.05)
    hold on
    
    if numAlt == 1
      
      plot(rngPlot, actual{:,1}, 'color', red, 'linewidth', 1.5, ...
        'linestyle', ':');
      plot(rngPlot, trend{:,1}, 'color', blue, 'linewidth', 1);
      
      hl = legend(["Actual", "Trend"], "location", "best");
      
    else
      
      if maxabs(actual{rngPlot,2} - actual{rngPlot,1}) < 1e-9
        
        plot(rngPlot, actual{:,1}, 'color', red, 'linewidth', 1.5, ...
          'linestyle', ':');
        plot(rngPlot, trend{:,1}, 'color', blue, 'linewidth', 1);
        plot(rngPlot,  trend{:,2}, 'color', blue*3/8 + white*3/8 + green/4, 'linewidth', 1);
        
        hl = legend(["Actual", "TrendBase", "TrendAlt"], "location", "best");
        
      else
        
        plot(rngPlot, actual{:,1}, 'color', red, 'linewidth', 1.5, ...
          'linestyle', ':');
        plot(rngPlot, trend{:,1}, 'color', blue, 'linewidth', 1);
        plot(rngPlot, actual{:,2}, 'color', red*3/8 + white*3/8 + green/4, 'linewidth', 1.5, ...
        'linestyle', ':');
        plot(rngPlot,  trend{:,2}, 'color', blue*3/8 + white*3/8 + green/4, 'linewidth', 1);
        
        hl = legend(["ActualBase", "TrendBase", "ActualAlt", "TrendAlt"], "location", "best");
        
      end
      
    end
    
    grid on
    title(titleString)
    
    % To be able to copy the legend in utils.popaxes
    ha = gca;
    hl.Tag = titleString;
    ha.Tag = titleString;
    
  end

end