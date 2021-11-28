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

% Create the new figure
hf = figure('visible', 'off');

% Copy the axes and the legend to the new figure
hn = copyobj([h, hl], hf);

% Set positions

n = length(h);

if n == 1
  
  set(hn(1), ...
    'Units',                  get(0,'DefaultAxesUnits'), ...
    'OuterPosition',          get(0,'DefaultAxesOuterPosition'), ...
    'Position',               get(0,'DefaultAxesPosition'), ...
    'ActivePositionProperty', get(0,'DefaultAxesActivePositionProperty'), ...
    'FontSize',               20, ...
    'ButtonDownFcn',          '')
  
else
  
  % Create a temporary subtightplot to get the positions
  hft = figure('visible', 'off');
  for i = 1:n
    ht(i) = utils.subtightplot(2, 1, i, 0.1, [0.075, 0.025], 0.025);
  end
    
  % Set the positions
  for i = 1:n
    for p = ["Units", "OuterPosition", "Position", "ActivePositionProperty"]
      set(hn(i), p, get(ht(i), p));
    end
    set(hn(i), 'FontSize', 12);
  end
  
  close(hft);
  
end

set(hf, 'visible', 'on');

end