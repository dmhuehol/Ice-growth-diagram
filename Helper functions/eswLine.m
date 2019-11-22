function [eswLineData] = eswLine(percent,Tlower,Tupper)
%%eswLine
    %Makes arrays of water RH difference from ice saturation. Used to plot
    %isohumes on s-T diagram.
    %Equation is the Improved August-Roche-Magnus approximation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 21 and 23 from above citation.
    %
    %General form: [eswLineData] = eswLine(percent,Tlower,Tupper)
    %
    %Output
    %eswLineData: array where elements are given in difference between water
    %saturation RH and ice saturation.
    %
    %Input
    %percent: water saturation RH in percent
    %Tlower: lower bound of temperature in Celsius to calculate saturations
    %Tupper: upper bound of temperature in Celsius to calculate saturations
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 11/22/2019
    %Last major revision: 8/29/2019
    %

percent = percent/100;

TlineStandardC = Tupper:-0.1:Tlower;

eswStandard = 6.1094.*exp((17.625.*TlineStandardC)./(243.04+TlineStandardC));
esiStandard = 6.1121.*exp((22.587.*TlineStandardC)./(273.86+TlineStandardC));

eswPercent = eswStandard.*percent;
eswLineData = (eswPercent-esiStandard)./esiStandard;

end