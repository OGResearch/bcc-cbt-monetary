function opts = mainSettings()

%% Read model options

% Name of the file containing alternative parametrization (in +parameters)

% opts.model.altParams = string.empty;
% opts.model.altParams = "setParamAlt";
opts.model.altParams = "setParamEst";

% The steady state of these variables will be displayed
opts.model.steadyVars = [
  "l_y_gap"
  "r_gap"
  "dl_cpi_core"
  "dl_cpi_ncore"
  "dl_cpi"
  "i"
  "r"
  "l_z_gap"
  "dl_z_tnd"
  "dl_cpi_f"
  "i_f"
  "ss_dl_cpi_tar"
  "ss_dl_z_tnd"
  "ss_dl_cpi_f"
  "ss_r_f_tnd"
  ];

%% Estimation options

% Range
opts.estim.rngEst = qq(2000, 1) : qq(2019, 4);

% Prior specification

opts.estim.spec.b1 = {0.50, 0.3, 0.7, distribution.Normal.fromMeanStd(0.50, 0.05)};
opts.estim.spec.b2 = {0.15, 0.0, 0.3, distribution.Normal.fromMeanStd(0.15, 0.15)};
opts.estim.spec.b3 = {0.25, 0.0, 1.0, distribution.Normal.fromMeanStd(0.25, 0.125)};
opts.estim.spec.b4 = {0.35, 0.0, 1.0, distribution.Normal.fromMeanStd(0.35, 0.15)};
opts.estim.spec.b5 = {0.05, 0.0, 0.1, distribution.Normal.fromMeanStd(0.05, 0.01)};

opts.estim.spec.a1 = {0.50, 0.0, 1.0, distribution.Normal.fromMeanStd(0.50, 0.10)};
opts.estim.spec.a2 = {0.50, 0.0, 1.0, distribution.Normal.fromMeanStd(0.50, 0.10)};
opts.estim.spec.a3 = {0.15, 0.0, 0.2, distribution.Normal.fromMeanStd(0.15, 0.10)};
opts.estim.spec.a4 = {0.75, 0.0, 1.5, distribution.Normal.fromMeanStd(0.75, 0.50)};
opts.estim.spec.a5 = {0.15, 0.0, 0.2, distribution.Normal.fromMeanStd(0.05, 0.10)};

% MCMC draws
opts.estim.numDraws = 3000;

% Plot posterior
opts.estim.plotPost = false;

%% Filter options

% Range
opts.filter.rngFilt = qq(2000, 1) : qq(2019, 4);

% Tunes

% CPI target
opts.filter.dbTunes.obs_dl_cpi_tar = Series();
opts.filter.dbTunes.obs_dl_cpi_tar(qq(2000,1) : qq(2010,4)) = 3;
opts.filter.dbTunes.obs_dl_cpi_tar(qq(2011,1) : qq(2021,2)) = 4;

% Real exchange rate gap
opts.filter.dbTunes.obs_l_z_gap = Series();
opts.filter.dbTunes.obs_l_z_gap(qq(2002,1)) = -7;

% Level shock for potential during Covid19
opts.filter.dbTunes.obs_shock_l_y_tnd = Series();
opts.filter.dbTunes.obs_shock_l_y_tnd(qq(2020, [1 2])) = [-5, -5];

% Multipliers

% Core inflation
tmp = Series();
tmp(qq(2015, 1:5))  = 3; % House prices increase, Lybian refugees
tmp(qq(2018, 2:5))  = 3; % Reversal of House prices increase
tmp(qq(2016, 4))    = 3; % Tax
tmp(qq(2018, 1))    = 3; % Tax
opts.filter.dbMult.std_shock_dl_cpi_core = tmp;

% Output gap
tmp = Series();
tmp(qq(2011, 1))      = 5;
tmp(qq(2020, [1, 2])) = [5, 5];
opts.filter.dbMult.std_shock_l_y_gap = tmp;

% Potential growth
tmp = Series();
tmp(qq(2011, 1))      = 5;
opts.filter.dbMult.std_shock_g_y_tnd = tmp;

% % Potential level shock
tmp = Series();
tmp(qq(2011, 1))      = 100;
opts.filter.dbMult.std_shock_l_y_tnd = tmp;

% % RER trend
% rngMult = [qq(2002,1), qq(2004,4)];
% valMult = [10, 5];
% opts.filter.dbMult.std_shock_dl_z_tnd = Series(rngMult, valMult);

% % FX target
% rngMult = qq(2002, 1);
% valMult = 10;
% opts.filter.dbMult.std_shock_dl_s_tar = Series(rngMult, valMult);

% Deficit
tmp = Series();
tmp(qq(2020, 4)) = 3.5;
opts.filter.dbMult.std_shock_def = tmp;

%% IRF options

opts.irf.horizon = 20;

opts.irf.shockNames = [
  "shock_l_y_gap"
  "shock_dl_cpi_core"
  "shock_i"
  "shock_prem"
  ];

opts.irf.varNames = [
  "l_y_gap"
  "dl_cpi_core"
  % "dl_cpi"
  "i"
  "r_gap"
  "l_z_gap"
  "l_s"
  "dl_s"
  ];

%% Shock plot options

opts.shocks.shockNames = [
  %   "shock_l_y_gap"
  %   "shock_dl_cpi_core"
  %   "shock_i"
  %   "shock_l_s"
  %   "shock_prem"
  ];

%% General options

red   = [1, 0, 0];
green = [0, 1, 0];
blue  = [0, 0, 1];
white = [1, 1, 1];

baseColor = red*0/5 + green*2/5 + blue*3/5;
altColor  = red*4/5 + green*1/5 + blue*1/5;

opts.general.baseColor  = 7/8*baseColor + 1/8*white;
opts.general.altColor   = 7/8*altColor  + 1/8*white;

opts.general.baseColorL  = 3/8*baseColor + 5/8*white;
opts.general.altColorL   = 3/8*altColor  + 5/8*white;

% hold on
% plot([0,1], [0,1],      "linewidth", 2, "color", opts.general.baseColor)
% plot([0,1], [0,1]+0.1,  "linewidth", 2, "color", opts.general.baseColor1)
% plot([0,1], [0,1]+1,    "linewidth", 2, "color", opts.general.altColor)
% plot([0,1], [0,1]+1.1,  "linewidth", 2, "color", opts.general.altColor1)

end