function plotIRF

% Porcess options

opts = mainSettings();

shockNames  = opts.irf.shockNames;
varNames    = opts.irf.varNames;
rngIRF      = 0 : opts.irf.horizon;

% Load the model
tmp = load("results/model.mat");
m   = tmp.m;

% Calculate the responses
ir = srf(m, rngIRF, 'select', shockNames, ...
  'size', 1);

% Plot the responses

% Close an earlier figure window
figureTag = "IRF";
close(findobj('Tag', figureTag));
figure('Tag', figureTag);

numVars   = length(varNames);
numShocks = length(shockNames);

numAlt = length(m);

c = 0;

for j = 1 : numVars
  for i = 1 : numShocks
    
    c = c + 1;
    ha = utils.subtightplot(numVars, numShocks, c, 0.05, 0.05, 0.05);
    
    plot(rngIRF, ir.(varNames(j)){:, i, 1}, '.-', 'color', opts.general.baseColor);
    if 1 < numAlt
      hold on
      plot(rngIRF, ir.(varNames(j)){:, i, 2}, '.-', 'color', opts.general.altColor);
    end
    
    grid on
    yline(0);
    
    titleString = "Resp. of " + varNames(j) + " to " + shockNames(i);
    title(titleString, "interpreter", "none");
    
    set(ha, 'tag', titleString);
    
    if 1 < numAlt
      hl = legend(["Baseline", "Alternative"], "location", "best");
      set(hl, 'tag', titleString);
    end
    
    
    
  end
end

utils.popaxes();

end