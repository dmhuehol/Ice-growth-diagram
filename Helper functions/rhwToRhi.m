function [rhi] = rhwToRhi(rhw,temp)
%%rhwToRhi
    %Converts relative humidity with respect to water to relative humidity
    %with respect to ice
    %Equation is the Improved August-Roche-Magnus approximation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 21 and 23 from above citation.
    %
    %General form: [rhi] = rhwToRhi(percent,temp)
    %
    %Output
    %rhi: 
    %   relative humidity with respect to ice percentage
    %
    %Input
    %rhw: 
    %   relative humidity with respect to water percentage (e.g. enter 90 for 90% RHw)
    %temp: 
    %   temperature in Celsius
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 1/2023
    %Last major revision: 10/31/2020
    %
    
classNumeric = {'numeric'};
attrPositive = {};
validateattributes(rhw,classNumeric,attrPositive); %Check to make sure rhw is numeric
    
rhw = rhw/100;

eswStandard = 6.1094.*exp((17.625.*temp)./(243.04+temp));
esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp));

vaporPressure = eswStandard.*rhw;
rhi = vaporPressure./esiStandard;
rhi = rhi.*100;

end