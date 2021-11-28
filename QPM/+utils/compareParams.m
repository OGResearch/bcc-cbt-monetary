function compareParams()

% Load model
tmp = load("results/model.mat");
m = tmp.m;

% Get parameters
paramVals   = get(m, "parameters");
paramNames  = string(fieldnames(paramVals));

% Create the table
compTable = array2table(double.empty(0,2), ...
  "VariableNames", ["Baseline", "Alternative"]);
diffParamNames = string.empty();

% Fill the table with differing parameters
for pn = paramNames(:)'
  if paramVals.(pn)(1) ~= paramVals.(pn)(2)
    compTable{end+1, :}   = paramVals.(pn); %#ok<*AGROW>
    diffParamNames(end+1) = pn;    
  end
end
compTable.Properties.RowNames = diffParamNames;

% Display the table
disp(compTable)

end