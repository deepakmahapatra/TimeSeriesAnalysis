ARMA_RSS = 7.1653e+13;


value_matrix = csvread('lagdettotaldaily.csv',1,0);
value_1 = value_matrix(:,2);
value_0 = value_matrix(:,3);


    value_new = [];
    value_new = value_0 - value_1;
    Data_1=iddata(value_new);
    Pars_model_trend_det=armax(Data_1,[7 7]);
    Pars_r_trend_det=resid(Pars_model_trend_det,Data_1);
    Pars_residuals_trend_det=Pars_r_trend_det.y;
    Pars_RSS_trend_det=sum(Pars_residuals_trend_det.^2);
    F_value_trend_det = ((Pars_RSS_trend_det - ARMA_RSS)/1)/(ARMA_RSS/(N-1-15));