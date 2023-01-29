function [RHw] = iceSupersatToRHw(iceSupersat,temp)
%%iceSupersatToRHw
    %Converts ice supersaturation in percent to RH in percent. Uses the
    %Improved August-Roche-Magnus saturation vapor pressure equation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 21 and 23 from above citation.
    %
    %General form: [RHw] = iceSupersatToRH(iceSupersat,temp)
    %
    %Output
    %RHw: 
    %   relative humidity (with respect to water) in %
    %
    %Inputs:
    %iceSupersat: 
    %   supersaturation with respect to ice in %, e.g. enter 28 for 128% RHi
    %temp: 
    %   temperature in deg C
    %
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 1/2023
    %Last major revision: 10/31/2020
    %
    %See also iceSupersatToVaporExc
    %

classNum = {'numeric'};
attribute = {};
validateattributes(iceSupersat,classNum,attribute); %Check to ensure numeric
validateattributes(temp,classNum,attribute); %Check to ensure numeric input

iceSupersatDecimal = iceSupersat./100;

eswStandard = 6.1094.*exp((17.625.*temp)./(243.04+temp));
esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp));

esw = esiStandard.*(iceSupersatDecimal+1);

RHw = esw./eswStandard.*100;

end