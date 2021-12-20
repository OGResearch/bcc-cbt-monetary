%% Create and calibrate model object 

%% Clear workspace 

close all
clear

if ~exist("mat", "dir")
    mkdir mat
end


%% Read model files 

% Basic QPM
m = Model.fromFile( ...
    ["model/qpm.model", "model/noCredit.model"] ...
    , "linear", false ...
    , "growth", true ...
);

% QPM with credit extension
mx = Model.fromFile( ...
    ["model/qpm.model", "model/credit.model"] ...
    , "linear", false ...
    , "growth", true ...
);


%% Assign parameters and solve model

p = struct();
p = parameters.baseline(p);

m = assign(m, p);
m = steady(m);
m = solve(m);

mx = assign(mx, p);


mx.bc_to_ny = 0.70;

mx = steady( ...
    mx ...
    , "exogenize", "bc_to_ny" ...
    , "endogenize", "c1_l_bc" ...
);
mx = solve(mx);


%% Save the model to Matlab MAT file 

save mat/readModel.mat m mx


%% Tabularize steady state 

t = table( ...
    mx, ["steadyLevels", "steadyChange",  "Description"] ...
    , "round", 8 ...
    , "writeTable", "steady-state.xlsx" ...
)

