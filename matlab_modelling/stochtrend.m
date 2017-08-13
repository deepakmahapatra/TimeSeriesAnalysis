ARMA_RSS = 7.2444e+13;


value_matrix = csvread('lagtotaldaily.csv',1,0);
value_1 = value_matrix(:,2);
value_0 = value_matrix(:,3);


    value_new = [];
    value_new = value_0 - value_1;
    Data_1=iddata(value_new);
    Pars_model_trend=armax(Data_1,[9 9]);
    Pars_r_trend=resid(Pars_model_trend,Data_1);
    Pars_residuals_trend=Pars_r_trend.y;
    Pars_RSS_trend=sum(Pars_residuals_trend.^2);
    F_value_trend = ((Pars_RSS_trend - ARMA_RSS)/1)/(ARMA_RSS/(N-1-19));