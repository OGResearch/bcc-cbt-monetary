
clear, clc

% Read series from a CSV file
db = databank.fromCSV("../data/data.csv", ...
  "dateformat", "mm/dd/yyyy", ...
  "freq", 4);

% Save into MATLAB file
save("../data/data.mat", "db")

% Save into a CSV file
databank.toCSV(db, "../data/dataOut.csv", ...
  "class",    false, ...
  "comment",  false);

% Plot all series in a database
dbplot(db);