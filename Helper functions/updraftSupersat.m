function [s_upper] = updraftSupersat(c,k,updraft)
%%updraftSupersat
    %Function to calculate maximum possible supersaturation inside an
    %updraft. These equations come from Twomey 1959 "The nuclei of
    %natural cloud formation part II".
    % These equations are ONLY valid at P=800 hPa and T=10C.
    %
    %General form: [s_upper,s_lower] = updraftSupersat(c,k,updraft)
    %
    %Output
    %s_max: the maximum supersaturation in the updraft. Output in
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

% In progress
% m = k+2;
% A = 2.^(-3/2);
% a = A./m;
% alpha = 4.35*10^(-4).*(7.93*10^(-5)*updraft).^(k+0.5).*(c.*k)./(m).*B;
% s_lower = alpha.*time.*(1-(a.*m)./(m+1).*time.^m+(a.^2.*m.^2)./((m+1).*(2.*m+1)).*time.^(2.*m)-((a.^3.*m.^3)./((m+1).*(2.*m+1).*(3.*m+1)).*time.^(3.*m))); % Equation 7



end