function plotShocks

% Get options
opts = mainSettings();

% Load the model
tmp   = load("results/model.mat");
m     = tmp.m;

% Load the filter results
tmp     = load("results/filter.mat");
db      = tmp.dbFilt.mean;
rngPlot = tmp.rngFilt;

% Get shock names
if isempty(opts.shocks.shockNames)
  shockNames = string(get(m, "eNames"));
else
  shockNames = opts.shocks.shockNames;
end

% Determine subplot size
numShocks = numel(shockNames);
[numRows, numCols] = utils.calcSubplotSize(numShocks);

% Close an earlier figure window
figureTag = "shocks";
close(findobj('Tag', figureTag));
figure('Tag', figureTag);

numAlt = length(m);

c = 0;
for sh = shockNames(:)'
  
  c = c + 1;
  utils.subtightplot(numRows, numCols, c, [0.05, 0.03], 0.05, 0.05);
  
  hold on
  h1 = plot(rngPlot, db.(sh){:,1}, "color", opts.general.baseColor);
  
  stdBase = m(1).("std_" + sh);
  shStd = Series(rngPlot, stdBase);
  plot(rngPlot,   2*shStd, ":", "linewidth", 1.5, "color", opts.general.baseColorL);
  plot(rngPlot,  -2*shStd, ":", "linewidth", 1.5, "color", opts.general.baseColorL);
  
  title(sh, "interpreter", "none");
  grid on
  yline(0);
  
  if 1 < numAlt
    
    h2 = plot(rngPlot, db.(sh){:,2}, "color", opts.general.altColor);
    
    hl = legend([h1, h2], ["Baseline", "Alternative"], "location", "best");
    set(hl, 'tag', sh);
    
    stdAlt = m(1).("std_" + sh);
    
    if stdBase ~= stdAlt
      shStd = Series(rngPlot, stdAlt);
      plot(rngPlot,   2*shStd, ":", "linewidth", 1.5, "color", opts.general.altColorL);
      plot(rngPlot,  -2*shStd, ":", "linewidth", 1.5, "color", opts.general.altColorL);
    end
    
  end
  
  set(gca, 'tag', sh);
  
end

utils.popaxes();

end