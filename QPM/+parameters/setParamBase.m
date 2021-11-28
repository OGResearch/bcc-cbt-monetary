function p = setParamBase()

% Steady states

p.ss_dl_y_tnd       = 2.0;
p.ss_dl_cpi_tar     = 4.0;
p.ss_dl_cpi_ncore   = 4.0;
p.ss_dl_z_tnd       = 2.0;
p.ss_prem           = 2.0;
p.ss_str_def        = 3.0;

% Output gap parameters

p.a1  = 0.20;  % Expectation
p.a2  = 0.50;  % Lag
p.a3  = 0.05;  % r_gap
p.a4  = 0.20;  % foreign output gap
p.a5  = 0.05;  % l_z_gap
p.a6  = 0.60;  % fisc_impulse

% Core Phillips curve

p.b1 = 0.45; % Expectation
p.b2 = 0.05; % Direct imported
p.b3 = 0.25; % RMC
p.b4 = 0.35; % l_z_gap in RMC
p.b5 = 0.02; % oil

% Non-core Phillips curve

p.b21 = 0.40; % Lag
p.b22 = 0.05; % Oil

% Headline CPI

p.w_core = 1 - 0.127 - 0.265;

% Policy rule

p.c1 = 0.7; % Lag
p.c2 = 1.5; % Inflation reaction
p.c3 = 0.0; % Output gap

% UIP

p.e1 = 0.8; % Share of forward looking agents
p.e2 = 0.3; % Weight of exchange rate target

% Fiscal

p.f1 = 0.2;
p.f2 = 0.5;

% Trends

p.rho_g_y_tnd     = 0.99;
p.rho_dl_z_tnd    = 0.90;
p.rho_prem        = 0.70;
p.rho_dl_s_tar    = 0.90;
p.rho_dl_cpi_tar  = 0.90;
p.rho_r_tnd       = 0.90;
p.rho_str_def     = 0.90;

% Standard deviations

p.std_shock_l_y_gap       = 0.75;
p.std_shock_dl_cpi_core   = 1.20;
p.std_shock_dl_cpi_ncore  = 3.20;
p.std_shock_i             = 0.25;
p.std_shock_l_s           = 1.75;
p.std_shock_def           = 2.00;

p.std_shock_g_y_tnd     = 0.10;
p.std_shock_l_y_tnd     = 0.10;
p.std_shock_dl_z_tnd    = 0.20;
p.std_shock_prem        = 0.20;
p.std_shock_dl_s_tar    = 0.25;
p.std_shock_dl_cpi_tar  = 0.01;
p.std_shock_r_tnd       = 0.20;
p.std_shock_str_def     = 0.10;

% External variables

p.ss_dl_cpi_f     = 2.00;
p.ss_r_f_tnd      = 1.00;

p.rho_dl_cpi_f      = 0.41;
p.rho_i_f           = 0.76;
p.rho_r_f_tnd       = 0.97;
p.rho_l_y_f_gap     = 0.90;
p.rho_l_rp_oil_gap  = 0.74;

p.std_shock_dl_cpi_f      =  1.31;
p.std_shock_i_f           =  0.75;
p.std_shock_r_f_tnd       =  0.15;
p.std_shock_l_y_f_gap     =  0.53;
p.std_shock_l_rp_oil_gap  = 14.98;

end