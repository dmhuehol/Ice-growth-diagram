function [vaporPressure] = iceSupersatToVapor(iceSupersat,temp)
%%iceSupersatToRH
    %Converts ice supersaturation in percent to vapor pressure excess in
    %Pa. Uses the Improved August-Roche-Magnus saturation vapor pressure equation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equation 23 from above citation.
    %
    %General form: [RH] = iceSupersatToVapor(iceSupersat,temp)
    %
    %Output
    %RH: relative humidity (with respect to water) in %
    %
    %Inputs:
    %iceSupersat: supersaturation with respect to ice in %
    %temp: temperature in deg C
    %
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 2/23/2020
    %Last major revision: 2/23/2020
    %
    %See also iceSupersatToRH
    %

esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp)); % Saturation vapor pressure at input temperature
vaporPressure = iceSupersat.*esiStandard;

end