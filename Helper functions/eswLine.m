function [eswLineNum] = eswLine(rhw,Tlower,Tupper)
%%eswLine
    %Makes arrays of RHw difference from saturation with respect to ice.
    %Used to plot isohumes on ice growth diagrams.
    %Equation is the Improved August-Roche-Magnus approximation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 21 and 23 from above citation.
    %
    %General form: [eswLineNum] = eswLine(rhw,Tlower,Tupper)
    %
    %Output
    %eswLineNum: 
    %   array where elements are given in difference between water
    %   saturation RHw and ice saturation
    %
    %Input
    %rhw: 
    %   water saturation RH in percent
    %Tlower: 
    %   lower bound of temperature in Celsius to calculate saturations
    %Tupper: 
    %   upper bound of temperature in Celsius to calculate saturations
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 1/2023
    %Last major revision: 10/31/2020
    %

classNum = {'numeric'};
attribute = {};
validateattributes(Tlower,classNum,attribute); %Check to ensure numeric
validateattributes(Tupper,classNum,attribute); %Check to ensure numeric input

if Tlower>Tupper %Check to make sure bounds are ordered correctly
    msg = 'Lower bound must be less than upper bound! Check input and try again.';
    error(msg);
end

rhw = rhw/100;

TlineStandardC = Tupper:-0.1:Tlower;

eswStandard = 6.1094.*exp((17.625.*TlineStandardC)./(243.04+TlineStandardC));
esiStandard = 6.1121.*exp((22.587.*TlineStandardC)./(273.86+TlineStandardC));

vaporPressure = eswStandard.*rhw;
eswLineNum = (vaporPressure-esiStandard)./esiStandard;

end