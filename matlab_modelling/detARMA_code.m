value = csvread('DailyDeterministic_final.csv');
value = value - mean(value);
N=length(value);
Cycle=1;
Data=iddata(value);

%Initializing
CurrentModel=armax(Data,[2 1]);
n=1;
r=resid(CurrentModel,Data);
residuals=r.y;
CurrentRSS=sum(residuals.^2); %residual sum of squares

while Cycle
    n=n+1;
    OldModel=CurrentModel;
    OldRSS=CurrentRSS;
    CurrentModel=armax(Data,[2*n 2*n-1]);
    
    r=resid(CurrentModel,Data);
    residuals=r.y;
    CurrentRSS=sum(residuals.^2); %residual sum of squares

    TestRatio=((OldRSS-CurrentRSS)/4)/(CurrentRSS/(N-4*n));
    if TestRatio<2.37
        Cycle=0;
        PreliminaryModel=OldModel;
        PreliminaryRSS=OldRSS;
    end
end
AR_Order=length(PreliminaryModel.a)-1;
MA_Order=length(PreliminaryModel.c)-1;
%Now check if the odd valued model is good
CurrentModel=armax(Data,[AR_Order-1 AR_Order-2]);
r=resid(CurrentModel,Data);
residuals=r.y;
CurrentRSS=sum(residuals.^2); %residual sum of squares
TestRatio=((CurrentRSS-PreliminaryRSS)/2)/(PreliminaryRSS/(N-(2*AR_Order-2)));
if TestRatio<3
    PreliminaryModel=CurrentModel;
    PreliminaryRSS=CurrentRSS;
end

%Now, removing the unnecessary MA parameters.
AR_Order=length(PreliminaryModel.a)-1;
MA_Order=length(PreliminaryModel.c)-1;
CurrMA=MA_Order;
CurrentModel=PreliminaryModel;
CurrentRSS=PreliminaryRSS;

if CurrMA>1
    Cycle=1;
else
    Cycle=0;
    Det_Model=PreliminaryModel;
    RSS=PreliminaryRSS;
end

while Cycle
    OldModel=CurrentModel;
    OldRSS=CurrentRSS;
    CurrMA=CurrMA-1;
    CurrentModel=armax(Data,[AR_Order CurrMA]);
    r=resid(CurrentModel,Data);
    residuals=r.y;
    CurrentRSS=sum(residuals.^2); %residual sum of squares
    
    NumOfParams=AR_Order+CurrMA+1;
    TestRatio=((CurrentRSS-PreliminaryRSS)/1)/(PreliminaryRSS/(N-NumOfParams));
    if TestRatio>3.84
        Cycle=0;
        Det_Model=OldModel;
        RSS=OldRSS;
    end
end %Done

r=resid(Det_Model,Data);
res=r.y;
% save the file in text form so that acf can be plot in r as it's not
% working in Matlab
csvwrite('A_res.csv',res);
res=res';save A_det_arma.txt res -ASCII;
% roots of AR_order and MA_order
ARMA_RSS_det = sum(res.^2)
% valuecheck_2 = value(3:N);
% valuecheck_1 = value(2:N-1);
% valuecheck_0 = value(1:N-2);
% Data_less2 = iddata(valuecheck_2);
% real_part = [
% -0.9980
%  
%    -0.9659
%     -0.5000
%  
%     0.0006
%  
%     0.5000
%  
%     0.7064
%  
%     0.8660
%  
%     0.9658]
% 
% Pars_RSS = [];
% F_value = [];
% 
% for i = 1:length(real_part)
%     value_new = valuecheck_2 - 2*real_part(i)*valuecheck_1 + valuecheck_0;
%     %N=length(value);
%     %value_new(1:10);
%     %Cycle=1;
%     Data_1=iddata(value_new);
%     Pars_model=armax(Data_1,[16 17]);
%     Pars_r=resid(Pars_model,Data_1);
%     Pars_residuals=Pars_r.y;
%     Pars_RSS(i)=sum(Pars_residuals.^2);
%     F_value(i) = ((Pars_RSS(i) - ARMA_RSS)/2)/(ARMA_RSS/(N-2-35));
% end

AR_Poly_Det=Det_Model.a;
MA_Poly_Det=Det_Model.c;
l_Det=roots(AR_Poly_Det);
k_Det=roots(MA_Poly_Det);
% roots on unit circle
zplane(AR_Poly_Det);
zplane(MA_Poly_Det);
 
% Pars_model=armax(Data,[14 15]);
% Pars_r=resid(Pars_model,OriginalData);
% Pars_residuals=Pars_r.y;
% Pars_RSS=sum(Pars_residuals.^2);
% % check the f_value to see whether there is seasonality or not and do
% % similiarly for stochastic trend.
% %parsimonious model this time is (1-B)Xt
% Pars_model1=armax(Data,[15 16]);
% Pars_r1=resid(Pars_model1,Data);
% Pars_residuals1=Pars_r1.y;
% Pars_RSS1=sum(Pars_residuals1.^2);
% % forecasting for next 74 months to compare it with test data
%prediction=forecast(Model,value,30)%using original model;
% prediction1=forecast(Pars_model,value,74)%using parsimonious model assuming seasonality
% prediction2=forecast(Pars_model1,value,74)%using parsimonious model assuming trend