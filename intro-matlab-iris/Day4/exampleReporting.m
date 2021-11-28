
clear, clc, close

% Load data
load("../data/data.mat", "db")

% Set the ranges

rngDb = databank.range(db);

% Range for the figrue
rngFig    = rngDb(end)-79 : rngDb(end);
rngFigHlt = rngDb(end)-59 : rngDb(end);

% Range for the tables
rngTbl    = rngDb(end)-15 : rngDb(end);
rngTblHlt = rngDb(end)-11 : rngDb(end);

% Range for annual tables
ld = convert(rngDb(end), 'y');
rngTblY = ld-5 : ld;

% Create the reports
r = report.new('First report');

% Start a new section
r.section('Figures');

% Do not print the header
r.tex('', '\thispagestyle{empty}');
r.pagebreak('');
r.tex('', '\pagenumbering{arabic}'); % Restart the numbering

% Create a new figure
r.figure('First figure', ...
  'subplot',        [2, 1], ...
  'legend',         false, ...
  'legendLocation', 'southEast', ...
  'range',          rngFig, ...
  'plotOptions',    {'linewidth', 2, 'color', [0.4, 0.4, 0.8], 'linestyle', ':'} ...
  );

% Create a new graph
r.graph('GDP growth');

% Add a series to the graph
r.series('', pct(db.GDP));

% Highlight (shade) part of the graph
r.highlight('', rngFigHlt);

% Create a new graph
r.graph('Inflation');

% Add a series
r.series('', pct(db.INFL));

% Create a new figure
r.figure('Second figure');

% Create a new graph
r.graph('Inflation');

% Add a bar plot of a series
r.series('', pct(db.INFL), ...
  'plotFunc', @bar);

% Start a new section
r.section('Tables');
r.pagebreak('');

% Create a table
r.table('First table', ...
  'range',      rngTbl, ...
  'typeface',   '\scriptsize', ...
  'decimal',    1, ...
  'highlight',  rngTblHlt, ...
  'vline',      rngTblHlt(1)-1);

% Add series to the table
r.series('Profit, level',     db.Profit);
r.series('Profit, % change',  pct(db.Profit), ...
  'footnote', 'Footnote');

r.pagebreak('');

% Create a table
r.table('Second table', ...
  'range', rngTblY, ...
  'typeface', '\scriptsize');

% Add series to the table
r.series('Profit, level',     convert(db.Profit, 'y'));
r.series('Profit, % change',  pct(convert(db.Profit, 'y')));

% Publish
r.publish('firstReport.pdf', ...
  'makeTitle',  true, ...
  'display',    false);
