value = csvread('TotalDaily.csv');
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
    Model=PreliminaryModel;
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
        Model=OldModel;
        RSS=OldRSS;
    end
end %Done

r=resid(Model,Data);
res=r.y;
csvwrite('A_res.csv',res);
res=res';save A_arma.txt res -ASCII;
% roots of AR_order and MA_order
ARMA_RSS = sum(res.^2)


AR_Poly=Model.a;
MA_Poly=Model.c;
l=roots(AR_Poly);
k=roots(MA_Poly);
% roots on unit circle
zplane(AR_Poly);
zplane(MA_Poly);
 
