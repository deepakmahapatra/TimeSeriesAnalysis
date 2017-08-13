ARMA_RSS_det = 7.1653e+13;
%real_part = [-0.9658 -0.8660 -0.7071 -0.5000 -0.2587 0.9659 0.8660 0.7069 0.5000 0.2588 0.0750 0.0000];

%real_part = [-0.9658 -0.8660 -0.7071 -0.5000 -0.2587 0.0000 0.0374 0.2588 0.5000 0.7068 0.9659 0.8660];
real_part = [-0.8976 -0.2226];
% value = csvread('TotalHourly.csv');
% value = value - mean(value);
% csvwrite("value_avg_totalHr.csv",value)


value_matrix = csvread('lagdettotaldaily.csv',1,0);
value_2 = value_matrix(:,1);
value_1 = value_matrix(:,2);
value_0 = value_matrix(:,3);

Pars_RSS_det = [];
F_value_det = [];
omega = [];
for i = 1:length(real_part)
    omega(i) = 2*pi/(acos(real_part(i)));
end  
% value_test = value_2 - 2*real_part(1)*value_1 + value_0;
%     Data_test=iddata(value_test);
%     test_model=armax(Data_test,[8 9]);
%     test_r=resid(test_model,Data_test);
%     test_residuals=test_r.y;
%     test_RSS=sum(test_residuals.^2);
%     F_test = ((test_RSS - ARMA_RSS)/2)/(ARMA_RSS/(N-2-19));
%for i=1:length(real_part)
    value_new = [];
    i=1;
    value_new = value_0 - 2*real_part(1)*value_1 + value_2;
    Data_1=iddata(value_new);
    Pars_model_det=armax(Data_1,[6 7]);
    Pars_r_det=resid(Pars_model_det,Data_1);
    Pars_residuals_det=Pars_r_det.y;
    Pars_RSS_det(i)=sum(Pars_residuals_det.^2);
    F_value_det(i) = ((Pars_RSS_det(i) - ARMA_RSS_det)/2)/(ARMA_RSS_det/(N-2 -15));
%end
Pars_r_det=Pars_r_det';save A_pars_det.txt res -ASCII;