function plotDecomp

% Load the filter results

tmp     = load("results/filter.mat");
db      = tmp.dbFilt.mean;
rngPlot = tmp.rngFilt;

numAlt = size(db.ttrend,2);

% Sorry about this ...
numEquations = 7;

if 1 == numAlt
  [numRows, numCols] = utils.calcSubplotSize(numEquations);
else
  numRows = 2;
  numCols = numEquations;
end

c = 0;

% Plot historical contributions

% Close an earlier figure window
figureTag = "filterDecomp";
close(findobj('Tag', figureTag));
figure('Tag', figureTag);

% Output gap
contr = [
  + db.a1   .* db.e_l_y_gap, ...
  + db.a2   .* db.l_y_gap{-1}, ...
  - db.a3   .* db.r_gap, ...
  + db.a4   .* db.l_y_f_gap, ...
  + db.a5   .* db.l_z_gap, ...
  + db.a6   .* db.fisc_impulse, ...
  + db.shock_l_y_gap ...
  ];
total = db.l_y_gap;
legendString  = ["Expect.", "Lag", "RIR gap", "Foreign gap", "RER gap", ...
  "Fiscal impulse", "Shock"];
titleString   = "Output gap, %";
createDecompChart()

% Core inflation
contr = [
  + db.b1 .* db.e_dl_cpi_core, ...
  + (1 - db.b1 - db.b2) .* db.dl_cpi_core{-1}, ...
  + db.b2 .* (db.dl_cpi_f + db.dl_s - db.dl_z_tnd), ...
  + db.b3 .* (1 - db.b4) .* db.l_y_gap, ...
  + db.b3 .* db.b4 .* db.l_z_gap, ...
  + db.b5 .* (db.l_z_gap + db.l_rp_oil_gap), ...
  + db.shock_dl_cpi_core;
  ];
total = db.dl_cpi_core;
legendString  = ["Expect.", "Lag", "Direct", "Output gap", "RER gap", "Oil", "Shock"];
titleString   = "Core inflation, qq % @ar";
createDecompChart()

% Non-core inflation
contr = [
  + db.b21 .* db.dl_cpi_ncore{-1}, ...
  + (1 - db.b21) .* db.ss_dl_cpi_ncore, ...
  + db.b22 .* (db.l_z_gap + db.l_rp_oil_gap), ...
  + db.shock_dl_cpi_ncore;
  ];
total = db.dl_cpi_ncore;
legendString  = ["Lag", "Steady state", "Oil", "Shock"];
titleString   = "Non-core inflation, qq % @ar";
createDecompChart()

% Interest rate
contr = [ ...
  + db.c1 .* db.i{-1}, ...
  + (1 - db.c1) .* (db.i_tnd), ...
  + (1 - db.c1) .* (db.c2 .* (db.e_dl_cpi_core - db.dl_cpi_tar)), ...
  + (1 - db.c1) .* (db.c3 .* db.l_y_gap), ...
  + db.shock_i ...
  ];
total = db.i;
legendString  = ["Lag", "Trend", "Response", "Output gap", "Shock"];
titleString   = "Interest rate, %";
createDecompChart()

% Exchange rate
contr = [ ...
  + (1 - db.e2) .* (db.e_l_s - db.l_s{-1}), ...
  - (1 - db.e2) .* (db.i - db.i_f)/4, ...
  + (1 - db.e2) .* db.prem/4, ...
  + db.e2 .* db.dl_s_tar/4, ...
  + db.shock_l_s ...
  ];
total = db.l_s - db.l_s{-1};
legendString  = ["Expected", "Intr. diff.",  "Premium", "Target", "Shock"];
titleString   = "Exchange rate, qq %";
createDecompChart()

% RIR trend
contr = [ ...
  + db.rho_r_tnd .* db.r_tnd{-1}, ...
  + (1 - db.rho_r_tnd) .* db.r_f_tnd, ...
  + (1 - db.rho_r_tnd) .* db.e_dl_z_tnd, ...
  + (1 - db.rho_r_tnd) .* db.prem, ...
  + db.shock_r_tnd;
  ];
total = db.r_tnd;
legendString  = ["Lag", "Foreign", "RER", "Premium", "Shock"];
titleString   = "RIR trend, %";
createDecompChart()

% Deficit
contr = [ ...
  + db.str_def, ...
  + db.cyc_def, ...
  + db.shock_def ...
  ];
total = db.def;
legendString  = ["Structural", "Cyclical", "Shock"];
titleString   = "Deficit, % of GDP";
createDecompChart()

utils.popaxes();

  function createDecompChart()
    
    c = c + 1;
    
    for p = 1 : numAlt
      
      contrp = contr{:, p : numAlt : end};
      totalp = total{:, p};
      
      discr = maxabs(totalp - sum(contrp, 2));
      if discr > 1e-9
        warning("Something wrong with the decomposition of [" + titleString + "]; maxabs = " + num2str(discr))
      end
      
      utils.subtightplot(numRows, numCols, c + (p-1)*numCols, 0.05, 0.05, 0.05)
      
      barcon(rngPlot, contrp, 'colormap', parula);
      hold on
      plot(rngPlot, totalp, "linewidth", 4, "color", "w");
      plot(rngPlot, totalp, "linewidth", 2, "color", "k");
      grid on
      hl = legend(legendString, "location", "southOutside", "orientation", "horizontal", ...
        "numColumns", 4);
      
      if numAlt == 1
        title(titleString)
      else
        if p == 1
          title(titleString + " (baseline)")
        else
          title(titleString + " (alternative)")
        end
      end
      
      % To be able to copy the legend in utils.popaxes
      ha = gca;
      hl.Tag = titleString;
      ha.Tag = titleString;
      
    end
    
    
  end

end
