function [vaporDensExc] = iceSupersatToVaporExc(iceSupersat,temp)
%%iceSupersatToVaporExc
    %Converts ice supersaturation in decimal to vapor density excess in
    %g/m^3. Uses the Improved August-Roche-Magnus saturation vapor pressure equation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equation 23 from above citation.
    %
    %General form: [vaporDensExc] = iceSupersatToVaporExc(iceSupersat,temp)
    %
    %Output
    %vaporDensExc: vapor density excess in g/m^3
    %
    %Inputs:
    %iceSupersat: supersaturation with respect to ice as a decimal
    %temp: temperature in deg C
    %
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Research Assistant at Environment Analytics
    % Created as part of HON499: Capstone II
    %Version date: 8/14/2020
    %Last major revision: 2/23/2020
    %
    %See also iceSupersatToRH
    %
Rv = 461.5; %J/(kgK)
Tk = temp+273.15;
esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp)); % Saturation vapor pressure at input temperature
vaporPressure = iceSupersat*100.*esiStandard;
vaporDensExc = vaporPressure./(Rv*Tk);
vaporDensExc = vaporDensExc.*10^3;

end