function popaxes

ha = findobj(gcf,'type','Axes');

set(ha,'ButtonDownFcn',@(h,ev) popaxes_(h,ev))

end

function popaxes_(h,~)

% Get the axis tag
tagString = get(h, 'Tag');

% Find any corresponding axis (in case of an alternative parametrization)
h = findobj(gcf, 'Type', 'axes', 'Tag', tagString);

% Find the legend
hl = findobj(gcf, 'Type', 'legend', 'Tag', tagString);

% Make baseline the first
if contains(h(1).Title.String, "alternative")
  h   = h([2,1]);
  hl  = hl([2,1]);
end

% Create the new figure
hf = figure('visible', 'off');

% Copy the axes and the legend to the new figure
hn = copyobj([h, hl], hf);

% Set properties of the new objects

n = length(h);

if n == 1
  
  % Set properties
  set(hn(1), ...
    "Position", [0.05, 0.10, 0.90, 0.85], ...
    "Fontsize", 16, ...
    "ButtonDownFcn", "");
  
  % Make the legend a row
  hn(2).NumColumns = 100;
  
else % We have a decomp chart
  
  % Set position
  hn(1).Position = [0.05, 0.575, 0.90, 0.375];
  hn(2).Position = [0.05, 0.075, 0.90, 0.375];
  
  % Set other properties
  set(hn, ...
    "Fontsize", 12, ...
    "ButtonDownFcn", "");
  
  % Make the legend a row
  hn(3).NumColumns = 100;
  hn(4).NumColumns = 100;
  
end

set(hf, 'visible', 'on');

end