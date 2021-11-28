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
  
  plot(rngPlot, db.(sh));
  hold on
  shStd = Series(rngPlot, m.("std_" + sh));
  plot(rngPlot,   2*shStd,  "b:", "linewidth", 1.5);
  plot(rngPlot,  -2*shStd, "b:", "linewidth", 1.5);
  
  yline(0);
  title(sh, "interpreter", "none");
  grid on
  
  if 1 < numAlt 
    hl = legend(["Baseline", "Alternative"], "location", "best");
    set(hl, 'tag', sh);
  end
  
  set(gca, 'tag', sh);
  
end

utils.popaxes();

end