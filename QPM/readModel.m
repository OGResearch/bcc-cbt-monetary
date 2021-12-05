function readModel

% Porcess options
opts        = mainSettings();
steadyVars  = opts.model.steadyVars;
altParams   = opts.model.altParams;

% Read model
m = Model("model/qpm.model", "Linear", true, "Growth", false);

% Set parameters, solve, and calculate the steady state

p = parameters.setParamBase();
m = assign(m, p);

if ~isempty(altParams)
  p = feval("parameters." + altParams);
  tmp = assign(m, p);
  m = [m, tmp];
end

m = solve(m);
m = sstate(m);

% Save the model
save("results/model.mat", "m");

% Display the steady state if required

if ~isempty(steadyVars)
  
  t = table(m, ["SteadyLevels", "SteadyChange"]);
  disp(t(steadyVars, :))
  
end

end