function [eswLineData] = eswLine(percent,Tlower,Tupper)
%%eswLine
    %Makes arrays of water RH difference from ice saturation. Used to plot
    %isohumes on s-T diagram.
    %
    %General form: [eswLineData] = eswLine(percent,Tlower,Tupper)
    %
    %Output
    %eswLineData: array where elements are given in difference between water
    %saturation RH and ice saturation.
    %
    %Input
    %percent: A water saturation RH in percent
    %Tlower: lower bound of temperature in Celsius to calculate saturations
    %Tupper: upper bound of temperature in Celsius to calculate saturations
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/26/2019
    %Last major revision: 
    %

%Constants
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.501*10^6; %J/Kg
Rv = 461.5; %J/(kgK)
es0 = 611; %Pa

percent = percent/100;

TlineStandardC = Tupper:-0.1:Tlower;
TlineStandard = TlineStandardC+273.15;
eswStandard = es0*exp(Lvap/Rv*(1/273.15-1./TlineStandard)); %Saturated vapor pressure with respect to water
esiStandard = es0*exp(Lsub/Rv*(1/273.15-1./TlineStandard)); %Saturated vapor pressure with respect to ice
eswPercent = eswStandard.*percent;
eswLineData = eswPercent./esiStandard-1;


end