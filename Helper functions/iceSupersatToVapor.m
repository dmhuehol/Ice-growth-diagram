function [vaporPressure] = iceSupersatToVapor(iceSupersat,temp)
esiStandard = 6.1121.*exp((22.587.*temp)./(273.86+temp)); % Saturation vapor pressure at input temperature
vaporPressure = iceSupersat.*esiStandard;
end