function [RH] = iceSupersatToRH(iceSupersat,T)
%%iceSupersatToRH
    %Converts ice supersaturation in decimal to RH in percent. Uses the
    %Improved August-Roche-Magnus saturation vapor pressure equation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 25 and 27 from above citation.
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
    %Version date: 8/29/2019
    %Last major revision: 8/29/2019
    %
    %See also rhow
    %
%Constants for MEA312 equation
% Lsub = 2.834*10^6; %J/(kg)
% Lvap = 2.501*10^6; %J/Kg
% Rv = 461.5; %J/(kgK)
% es0 = 611; %Pa

iceSupersat = iceSupersat./100;

eswStandard = 6.1094.*exp((17.625.*T)./(243.04+T));
esiStandard = 6.1121.*exp((22.587.*T)./(273.86+T));

% Old MEA312 equation
%Tk = T+273.15;
%eswStandard = es0*exp(Lvap/Rv*(1/273.15-1./Tk)); %Saturated vapor pressure with respect to water
%esiStandard = es0*exp(Lsub/Rv*(1/273.15-1./Tk)); %Saturated vapor pressure with respect to ice
%esiStandard = esiStandard./100;

esw = esiStandard.*(iceSupersat+1);

RH = esw./eswStandard.*100;
end