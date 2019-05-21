function [s_max] = updraftSupersat(C,k,w)
%%updraftSupersat
    %Function to calculate maximum possible supersaturation inside an
    %updraft. This equation comes from MEA412: Atmospheric Physics at NC
    %State, and is originally derived from Twomey 1959 "The nuclei of
    %natural cloud formation part II".
    %
    %General form: [s_max] = updraftSupersat(C,k,w)
    %
    %Output
    %s_max: the maximum possible supersaturation in the updraft, with
    %respect to water
    %
    %Inputs
    %C: magic parameter having to do with aerosols?
    %k: magic parameter having to do with aerosols?
    %w: updraft speed in m/s (cm/s conversion handled within the function)
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 5/21/2019
    %Last major revision: 5/21/2019
    %

if ~exist('C','var')
    C = 1000; %default parameter value for continental airmass, picked arbitrarily from the 300 to 3000 range
end
if ~exist('k','var')
    k = 1; %default parameter value for continental airmass, picked arbitrarily from the 0.2 to 2.0 range
end
if ~exist('w','var')
    msg = 'Using default updraft speed of 1 m/s';
    warning(msg);
    w = 1;
end

w = w*100; %Convert from m/s to cm/s

s_max = 3.6*(((1.6*10^(-3)*w^(3/2)))/C)^(1/(k+2));


end