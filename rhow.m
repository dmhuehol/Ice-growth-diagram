function [rhoDiff] = rhow(RHpercent,T)
%%rhow
    %Calculates vapor density for a given RH percent and T
    %
    %General form: [rhoDiff] = rhow(RHpercent,T)
    %
    %Output
    %rhoDiff: vapor density excess in g/m^3
    %
    %Input
    %RHpercent: Relative humidity (with respect to water) in %
    %T: Temperature in Celsius
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/30/2019
    %Last major revision: 
    %

%Constants
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.501*10^6; %J/Kg
Rv = 461.5; %J/(kgK)
es0 = 611; %Pa

RHdecimal = RHpercent/100; %Equations use decimal instead of percent

Tk = T+273.15;
eswStandard = es0*exp(Lvap/Rv*(1/273.15-(1./Tk))); %Saturated vapor pressure with respect to water
esiStandard = es0*exp(Lsub/Rv*(1/273.15-(1./Tk))); %Saturated vapor pressure with respect to ice

eswPercent = eswStandard.*RHdecimal;

rhow = eswPercent./(Rv*Tk);
rhoi = esiStandard./(Rv*Tk);

rhoDiff = rhow-rhoi;
rhoDiff = rhoDiff.*10^3;


end