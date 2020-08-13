%% makeFigures
% This script loads the necessary data and makes the exact figures shown
% in the ice diagram paper.
%
% Written by: Daniel Hueholt
% North Carolina State University
% Research Assistant at Environment Analytics
% Version date: 8/13/2020
% Last major revision: 

%% Fig: okx_djf1415
load('okx_djf1415.mat'); %Load radiosonde data for Upton, NY DJF 2014-2015
growthDiagramProfile(okx_djf1415,1:178,1,'water',0);
% Enter 'Dec-Feb 2014-2015' when prompted for date
% Enter 'Upton, NY' when prompted for location

%% Fig: okx_djf1920
load('okx_djf1920.mat'); %Load radiosonde data for Upton, NY DJF 2019-2020
growthDiagramProfile(okx_djf1920,1:185,1,'water',0);
% Enter 'Dec-Feb 2019-2020' when prompted for date
% Enter 'Upton, NY' when prompted for location

%% Fig: utq_djf1415
load('utq_djf1415.mat'); %Load radiosonde data for Utqiagvik, AK DJF 2014-2015
growthDiagramProfile(utq_djf1415,1:180,1,'water',0);
% Enter 'Dec-Feb 2014-2015' when prompted for date
% Enter 'Utqiagvik, AK' when prompted for location

%% Fig: utq_djf1718
load('utq_djf1718.mat'); %Load radiosonde data for Utqiagvik, AK DJF 2017-2018
growthDiagramProfile(utq_djf1718,1:121,1,'water',0);
% Enter 'Dec-Feb 2017-2018' when prompted for date
% Enter 'Utqiagvik, AK' when prompted for location

%% Fig: dnr_djf1718
load('dnr_djf1718.mat'); %Load radiosonde data for Denver, CO DJF 2017-2018
growthDiagramProfile(dnr_djf1718,1:180,1,'water',0);
% Enter 'Dec-Feb 2017-2018' when prompted for date
% Enter 'Denver, CO' when prompted for location

%% Fig: dnr_djf1819
load('dnr_djf1819.mat'); %Load radiosonde data for Denver, CO DJF 2018-2019
growthDiagramProfile(dnr_djf1819,1:179,1,'water',0);
% Enter 'Dec-Feb 2018-2019' when prompted for date
% Enter 'Denver, CO' when prompted for location

%% Fig: impactsUIUC_20200207_1200UTC
load('impUIUC_20200207_1200.mat'); %Load single radiosonde data from UIUC launch north of Syracuse on 2020 02 07
% Change the launchname variable in growthDiagramProfile to
% 43.1025,-76.1891 (north of Syracuse, NY)
growthDiagramProfile(impUIUC_20200207_1200,1,1,'water')



