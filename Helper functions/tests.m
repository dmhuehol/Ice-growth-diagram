%% Check nothing is broken

%% 
iceGrowthDiagram

%%
iceGrowthDiagramWater

%%
iceGrowthDiagramVaporExc

%%
iceGrowthDiagramTextbook

%%
load('/Users/danielhueholt/Documents/GitHub/Ice-growth-diagram/Demo/okx_djf1415.mat');
growthDiagramProfile(okx_djf1415,30:40,1,'water','m');

%% 
growthDiagramProfile(okx_djf1415,30:40,1,'ice','m');

%%
growthDiagramProfile(okx_djf1415,30:40,1,'vde','m');