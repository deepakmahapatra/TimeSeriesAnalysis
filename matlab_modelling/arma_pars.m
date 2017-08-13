ARMA_RSS = 7.2444e+13;


%real_part = [-0.9658 -0.8660 -0.7071 -0.5000 -0.2587 0.9659 0.8660 0.7069 0.5000 0.2588 0.0750 0.0000];

%real_part = [-0.9658 -0.8660 -0.7071 -0.5000 -0.2587 0.0000 0.0374 0.2588 0.5000 0.7068 0.9659 0.8660];
%real_part = [-0.9002 -0.2225 0.6235];
real_part = [-0.9002 -0.2225 0.6235];
% value = csvread('TotalHourly.csv');
% value = value - mean(value);
% csvwrite("value_avg_totalHr.csv",value)


value_matrix = csvread('lagtotaldaily.csv',1,0);
value_2 = value_matrix(:,1);
value_1 = value_matrix(:,2);
value_0 = value_matrix(:,3);



Pars_RSS = [];
F_value = [];
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
for i=1:length(real_part)
    value_new = [];
    value_new = value_2 - 2*real_part(i)*value_1 + value_0;
    Data_1=iddata(value_new);
    Pars_model=armax(Data_1,[8 9]);
    Pars_r=resid(Pars_model,Data_1);
    Pars_residuals=Pars_r.y;
    
    Pars_RSS(i)=sum(Pars_residuals.^2);
    F_value(i) = ((Pars_RSS(i) - try_RSS)/2)/(ARMA_RSS/(N-2 -19));
end
Pars_r=Pars_r';save A_pars.txt res -ASCII;

csvwrite("actual_pars.csv", value_new);






    
    


