% forecasting for next 30 days to compare it with test data
value_train_arma_det = csvread('DailyDeterministic_train.csv');

value_matrix = csvread('lagdettotaldaily_train.csv',1,0);
value_2 = value_matrix(:,1);
value_1 = value_matrix(:,2);
value_0 = value_matrix(:,3);
value_train_pars_det = value_2 - 2*-0.8976*value_1 + value_0;

prediction_det=forecast(Det_Model,value_train_arma_det,30);%using original model;
prediction1_det=forecast(Pars_model_det,value_train_pars_det,30);%using parsimonious model assuming seasonality

csvwrite('forecast_arma_det.csv',prediction_det);
csvwrite('forecast_pars_det.csv',prediction1_det);

% %prediction2=forecast(Pars_model1,value,74);%using parsimonious model assuming trend
% l_try = roots()
 %n=length(l_Det);
 
MA_Poly_pars_det = Pars_model_det.c;

AR_Poly_pars_det = Pars_model_det.a;
l_try = roots(AR_Poly_pars_det);
n=length(l_try);
for i=1:n
    Down=1;
    Up=polyval(MA_Poly_pars_det,l_try(i));
    for j=1:n
        if j~=i
            Down=Down*(l_try(i)-l_try(j));
        end
    end
    C(i)=Up/Down;
end

for i=1:TimeHorizon
    G(i)=0;
    for j=1:n
        G(i)=G(i)+C(j)*l_try(j)^i;
    end
end
        
G=[1 real(G)];
sigma2 = Pars_RSS_det(1)/(N-13);
temp = 0;
for k=1:TimeHorizon
    temp = temp + G(k)*G(k);
end
delta = 1.96*sqrt(temp*sigma2);
range_upper = [];
range_down = [];

for k=1:TimeHorizon
    range_upper(k) = prediction1_det(k) + delta;
    range_lower(k) = prediction1_det(k) - delta;
end
range_upper = range_upper';
csvwrite('range_upper_det_pars.csv',range_upper);
csvwrite('range_lower_det_pars.csv',range_lower);