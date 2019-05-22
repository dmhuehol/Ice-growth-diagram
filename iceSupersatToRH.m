function [RH] = iceSupersatToRH(iceSupersat,T)
%%iceSupersatToRH
    %Converts ice supersaturation in decimal to RH in percent
    %
    %General form: [RH] = iceSupersatToRH(iceSupersat,T)
    %
    %Output
    %RH: relative humidity (with respect to water) in %
    %
    %Inputs:
    %iceSupersat: supersaturation with respect to ice in %
    %
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/30/2019
    %Last major revision: 4/30/2019
    %
    %See also rhow
    %
%Constants
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.501*10^6; %J/Kg
Rv = 461.5; %J/(kgK)
es0 = 611; %Pa

iceSupersat = iceSupersat./100;

Tk = T+273.15;
eswStandard = es0*exp(Lvap/Rv*(1/273.15-1./Tk)); %Saturated vapor pressure with respect to water
esiStandard = es0*exp(Lsub/Rv*(1/273.15-1./Tk)); %Saturated vapor pressure with respect to ice
%esiStandard = esiStandard./100;

esw = esiStandard.*(iceSupersat+1);

RH = esw./eswStandard.*100;
end