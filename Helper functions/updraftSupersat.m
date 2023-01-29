function [s_upper] = updraftSupersat(c,k,updraft)
%%updraftSupersat
    %Function to calculate maximum possible supersaturation inside an
    %updraft. These equations come from Twomey 1959 "The nuclei of
    %natural cloud formation part II".
    % These equations are ONLY valid at P=800 hPa and T=10C. Because of
    % this they really have nothing to do with ice growth at all, and
    % cannot be applied in these contexts! This is only included out of
    % historical interest.
    %
    %General form: [s_upper] = updraftSupersat(c,k,updraft)
    %
    %Output
    %s_upper: the maximum supersaturation in the updraft. Output in
    %deg C which can be converted to % wrt water.
    %
    %Inputs
    %c: aerosol distribution constant
    %   pristine maritime: 125
    %   modified maritime: 160
    %   continental: 2000
    %   
    %k: aerosol distribution constant
    %   pristine maritime: 1/3
    %   modified maritime: 1/4
    %   continental: 2/5
    %updraft: updraft speed in cm/s
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    % Written as part of HON499: Capstone II
    %Version date: 10/31/2020
    %Last major revision: 10/31/2020
    %

classNum = {'numeric'};
attribute = {};
validateattributes(c,classNum,attribute); %Check to ensure numeric
validateattributes(k,classNum,attribute);
validateattributes(updraft,classNum,attribute);


%%
B = beta(3/2,k/2);
s_upper = ((1.63*10^(-3).*updraft.^(3/2))./(c.*k.*B))^(1/(k+2)); % Equation 10



end