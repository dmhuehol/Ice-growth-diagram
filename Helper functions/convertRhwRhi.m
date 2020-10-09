function [rhi] = convertRhwRhi(percent,temp)
%%eswLine
    %Converts relative humidity with respect to water to relative humidity
    %with respect to ice
    %Equation is the Improved August-Roche-Magnus approximation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 21 and 23 from above citation.
    %
    %General form: [rhi] = eswLine(percent,temp)
    %
    %Output
    %rhi: relative humidity with respect to ice percentage
    %
    %Input
    %percent: relative humidity with respect to water percentage
    %temp: temperature in Celsius
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 10/8/2020
    %Last major revision: 10/8/2020
    %

percent = percent/100;

eswStandard = 6.1094.*exp((17.625.*temp)./(243.04+temp));
esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp));

vaporPressure = eswStandard.*percent;
rhi = vaporPressure./esiStandard;
rhi = rhi.*100;

end