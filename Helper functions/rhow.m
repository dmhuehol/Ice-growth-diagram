function [rhoDiff] = rhow(RHpercent,T)
%%rhow
    %Calculates vapor density for a given RH percent and T. Uses the
    %Improved August-Roche-Magnus saturation vapor pressure equation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
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

%Constants originally required by MEA312 saturation equation
%Lsub = 2.834*10^6; %J/(kg)
%Lvap = 2.501*10^6; %J/Kg
%es0 = 611; %Pa

RHdecimal = RHpercent/100; %Equations use decimal instead of percent
Rv = 461.5; %J/(kgK)
Tk = T+273.15;

% Original MEA312 equation
%eswStandard = es0*exp(Lvap/Rv*(1/273.15-(1./Tk))); %Saturated vapor pressure with respect to water
%esiStandard = es0*exp(Lsub/Rv*(1/273.15-(1./Tk))); %Saturated vapor pressure with respect to ice

eswStandard = 6.1094.*exp((17.625.*T)./(243.04+T));
esiStandard = 6.1121.*exp((22.587.*T)./(273.86+T));
eswStandard = eswStandard*100;
esiStandard = esiStandard*100;
eswPercent = eswStandard.*RHdecimal;

rhow = eswPercent./(Rv*Tk);
rhoi = esiStandard./(Rv*Tk);

rhoDiff = rhow-rhoi;
rhoDiff = rhoDiff.*10^3;


end