% forecasting for next 74 months to compare it with test data
value_train_arma = csvread('TotalDaily_train.csv')
TimeHorizon =30;
value_matrix = csvread('lagtotaldaily_pars_test.csv',1,0);
value_2 = value_matrix(:,1);
value_1 = value_matrix(:,2);
value_0 = value_matrix(:,3);
value_test_pars = value_2 - 2*0.6235*value_1 + value_0;
actual_pars_test = value_train_pars(14:58)
prediction=forecast(Model,value_train_arma,30);%using original model;
prediction1=forecast(Pars_model,value_train_pars,30);%using parsimonious model assuming seasonality

csvwrite('forecast_arma.csv',prediction);
csvwrite('forecast_pars.csv',prediction1);

%prediction2=forecast(Pars_model1,value,74);%using parsimonious model assuming trend

n=length(l_pars);
MA_Poly_pars = Pars_model.c;
for i=1:n
    Down=1;
    Up=polyval(MA_Poly_pars,l_pars(i));
    for j=1:n
        if j~=i
            Down=Down*(l_pars(i)-l_pars(j));
        end
    end
    C(i)=Up/Down;
end

for i=1:TimeHorizon
    G(i)=0;
    for j=1:n
        G(i)=G(i)+C(j)*l_pars(j)^i;
    end
end
        
G=[1 real(G)];
sigma2 = Pars_RSS(3)/(N-15);
temp = 0;
for k=1:TimeHorizon
    temp = temp + G(k)*G(k);
end
delta = 1.96*sqrt(temp*sigma2);
range_upper = [];
range_down  = [];

for k=1:TimeHorizon
    range_upper(k) = prediction1(k) + delta;
    range_lower(k) = prediction1(k) - delta;
end
range_upper = range_upper'
csvwrite('range_upper_pars.csv',range_upper);
csvwrite('range_lower_pars.csv',range_lower);




