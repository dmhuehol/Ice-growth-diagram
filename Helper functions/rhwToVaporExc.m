function [rhoDiff] = rhwToVaporExc(rhw,temp)
%%rhwToVaporExc
    %Calculates vapor density for a given RH percent and T. Uses the
    %Improved August-Roche-Magnus saturation vapor pressure equation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    %
    %General form: [rhoDiff] = rhwToVaporExc(rhw,temp)
    %
    %Output
    %rhoDiff: vapor density excess in g/m^3
    %
    %Input
    %rhw: Relative humidity (with respect to water) in %
    %temp: Temperature in Celsius
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 10/31/2020
    %Last major revision: 10/31/2020
    %

classNum = {'numeric'};
attribute = {};
validateattributes(rhw,classNum,attribute); %Check to ensure numeric
validateattributes(temp,classNum,attribute); %Check to ensure numeric;

thwDecimal = rhw/100; %Equations use decimal instead of percent
Rv = 461.5; %J/(kgK)
tempK = temp+273.15; %Convert temperatures to Kelvin

eswStandard = 6.1094.*exp((17.625.*temp)./(243.04+temp));
esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp));
eswStandard = eswStandard*100;
esiStandard = esiStandard*100;
eswPercent = eswStandard.*thwDecimal;

rhow = eswPercent./(Rv*tempK);
rhoi = esiStandard./(Rv*tempK);

rhoDiff = rhow-rhoi;
rhoDiff = rhoDiff.*10^3;

end