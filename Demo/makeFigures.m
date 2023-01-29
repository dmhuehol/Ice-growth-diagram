%% makeFigures
% This script loads necessary data and makes the figures shown in:
% Hueholt, D.M., Yuter, S.E., and M.A. Miller, 2022: Revisiting
% Diagrams of Ice Growth Environments, Bulletin of the American
% Meteorological Society, doi.org/10.1175/BAMS-D-21-0271.1.
%
% Written by: Daniel Hueholt
% North Carolina State University
% Research Assistant at Environment Analytics
% Version date: 1/2023
% Last major revision: 1/2023

%% Fig 1: Ice growth diagram with respect to water
iceGrowthDiagramTextbook
% Enter 'water' when prompted for phase

%% Fig 2: Ice growth diagram with respect to ice
iceGrowthDiagramTextbook
% Enter 'ice' when prompted for phase

%% Fig 3: Ice growth diagram with respect to vapor density excess
iceGrowthDiagramTextbook
% Enter 'vde' when prompted for phase

% Figure 4 and 5 manually created, not generated with code

%% Fig 6a: Seasonal radiosonde data at Upton, NY on ice growth diagram
load('okx_djf1415.mat'); %Load radiosonde data for Upton, NY DJF 2014-2015
growthDiagramProfile(okx_djf1415,1:178,0,'water',0,0);
% Enter 'Dec-Feb 2014-2015' when prompted for date
% Enter 'Upton, NY' when prompted for location

%% Fig 6b: Seasonal radiosonde data at Utqiagvik, AK on ice growth diagram
load('utq_djf1415.mat'); %Load radiosonde data for Utqiagvik, AK DJF 2014-2015
growthDiagramProfile(utq_djf1415,1:180,1,'water',0,0);
% Enter 'Dec-Feb 2014-2015' when prompted for date
% Enter 'Utqiagvik, AK' when prompted for location

%% Fig 6c: Seasonal radiosonde data at Denver, CO on ice growth diagram
load('dnr_djf1415.mat'); % Load radiosonde data for Denver, CO DJF 2014-2015
growthDiagramProfile(dnr_djf1415,1:179,1,'water',0,0);
% Enter 'Dec-Feb 2014-2015' when prompted for date
% Enter 'Denver, CO' when prompted for location

%% Fig 7e: Subfigure for examples of sequential growth
% Figures 7a, 7b, 7c, 7d are in situ PHIPS images, not included in code
[hd] = makeGrowthDiagramStruct(1,1);
iceGrowthDiagramWater(hd,0,0,[],[90 105],[-25,0],0,0); %For all sequences
% Note that to perfectly replicate Fig 7e, adjust the tabBrnchEdge variable
% as documented in in-line comment on Line 191 in iceGrowthDiagramWater.

%% Bonus content: Illustrating more seasonal radiosonde profiles
%% Fig: okx_djf1920
load('okx_djf1920.mat'); %Load radiosonde data for Upton, NY DJF 2019-2020
growthDiagramProfile(okx_djf1920,1:185,1,'water',0,1);
% Enter 'Dec-Feb 2019-2020' when prompted for date
% Enter 'Upton, NY' when prompted for location

%% Fig: utq_djf1718
load('utq_djf1718.mat'); %Load radiosonde data for Utqiagvik, AK DJF 2017-2018
growthDiagramProfile(utq_djf1718,1:121,1,'water',0,1);
% Enter 'Dec-Feb 2017-2018' when prompted for date
% Enter 'Utqiagvik, AK' when prompted for location

%% Fig: dnr_djf1718
load('dnr_djf1718.mat'); %Load radiosonde data for Denver, CO DJF 2017-2018
growthDiagramProfile(dnr_djf1718,1:180,1,'water',0,1);
% Enter 'Dec-Feb 2017-2018' when prompted for date
% Enter 'Denver, CO' when prompted for location

%% Fig: dnr_djf1819
load('dnr_djf1819.mat'); %Load radiosonde data for Denver, CO DJF 2018-2019
growthDiagramProfile(dnr_djf1819,1:179,1,'water',0,1);
% Enter 'Dec-Feb 2018-2019' when prompted for date
% Enter 'Denver, CO' when prompted for location


