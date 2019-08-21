% 21 July 2019 Figures for Mesoscale conference
% simplest diagram

[hd] = makeGrowthDiagramStruct(1,1)
% just max natural supersat and RHwater=100
fig=iceGrowthDiagram_SEY(hd,0,2,1,0,1,'southeast',[0,0.6])
fig.Position=[2561 -679 1920 1080]
figne=iceGrowthDiagram_SEY(hd,0,2,1,0,1,'northeast',[0,0.6])
figne.Position=[2561 -679 1920 1080]
% no legend
fignl=iceGrowthDiagram_SEY(hd,0,2,1,0,0,'northeast',[0,0.6])
fignl.Position=[2561 -679 1920 1080]


figure('Position',[0 0 500 300])


% with isohumes
% just max natural supersat, RHwater=100, and other lines
figseiso=iceGrowthDiagram_SEY(hd,0,1,1,0,1,'southeast',[0,0.6])
figseiso.Position=[2561 -679 1920 1080]
%need to save these figures manually...

figupton2=openfig('Upton2014and2015.fig');
figupton2.Position[0,0,1920,1080];

load('barrow_sample.mat');

%


findsnd(2018,1,1,0,barrow_sample);
findsnd(2018,4,30,0,barrow_sample);
% with legend
growthDiagramProfile(barrow_sample,[1:74],1)
growthDiagramProfile_SEY(barrow_sample,[1:74],1)
title({['Ice phase space for Jan - Feb 2018'],'Barrow, AK'});

% figures to use for Mesoscale Conference

findsnd(2018,1,1,0,barrow_sample);
findsnd(2018,4,30,0,barrow_sample);
growthDiagramProfile_SEY(barrow_sample,[1:171],1)
title({['Ice phase space for Jan - April 2018'],'Barrow, AK'});


findsnd(2018,3,1,0,McMurdo); % 28431
findsnd(2018,9,30,0,McMurdo); %28654
figmcmurdosummer=growthDiagramProfile_SEY(McMurdo,[28431:28654],1)
title({['Ice phase space for March - Sept 2018'],'McMurdo, Antarctica'});
figmcmurdosummer.Position=[2561 -679 1920 1080];

findsnd(2017,10,1,0,McMurdo); % 28137
findsnd(2018,2,28,0,McMurdo); %28430
figmcmurdowinter=growthDiagramProfile_SEY(McMurdo,[28137:28430],1)
title({['Ice phase space for Oct 2017 - Feb 2018'],'McMurdo, Antarctica'});
figmcmurdowinter.Position=[2561 -679 1920 1080];


%%Upton
figupton2015=growthDiagramProfile_SEY(Upton,[findsnd(2015,12,1,0,Upton):findsnd(2016,3,31,0,Upton)],1)
title({['Ice phase space for Dec 2015 - Mar 2016'],'Upton, NY'});
figupton2015.Position=[2561 -679 1920 1080];
figupton2016=growthDiagramProfile_SEY(Upton,[findsnd(2016,12,1,0,Upton):findsnd(2017,3,31,0,Upton)],1)
title({['Ice phase space for Dec 2016 - Mar 2017'],'Upton, NY'});
figupton2016.Position=[2561 -679 1920 1080];

% multi-year
growthDiagramProfile_SEY(Upton,[findsnd(2014,12,1,0,Upton):findsnd(2015,3,31,0,Upton),...
    findsnd(2015,12,1,0,Upton):findsnd(2016,3,31,0,Upton),...
    findsnd(2016,12,1,0,Upton):findsnd(2017,3,31,0,Upton)],1)
title({['Ice phase space for Dec-Mar 2014-15, 2015-16, 2016-17'],'Upton, NY'});\

figupton2014to2016=growthDiagramProfile_SEY(Upton,[findsnd(2014,12,1,0,Upton):findsnd(2015,2,28,0,Upton),...
    findsnd(2015,12,1,0,Upton):findsnd(2016,2,29,0,Upton),...  % leap year
    findsnd(2016,12,1,0,Upton):findsnd(2017,2,28,0,Upton)],1)
title({['Ice phase space for Dec-Feb 2014-15, 2015-16, 2016-17'],'Upton, NY'});
figupton2014to2016.Position=[2561 -679 1920 1080];
% use openfig(figupton2014to2016); to open figure

figupton2014to2015=growthDiagramProfile_SEY(Upton,[findsnd(2014,12,1,0,Upton):findsnd(2015,2,28,0,Upton),findsnd(2015,12,1,0,Upton):findsnd(2016,2,29,0,Upton)],1)
title({['Ice phase space for Dec-Feb 2014-15, 2015-16'],'Upton, NY'});
figupton2014to2015.Position=[2561 -679 1920 1080];

% Salt Lake City
growthDiagramProfile_SEY(SaltLakeCity,[findsnd(2015,12,1,0,SaltLakeCity):findsnd(2016,3,31,0,SaltLakeCity)],1)
title({['Ice phase space for Dec 2015 - Mar 2016'],'Salt Lake City, UT'});
growthDiagramProfile_SEY(SaltLakeCity,[findsnd(2016,12,1,0,SaltLakeCity):findsnd(2017,3,31,0,SaltLakeCity)],1)
title({['Ice phase space for Dec 2016 - Mar 2017'],'Salt Lake City, UT'});

figureSLC2015to2016=growthDiagramProfile_SEY(SaltLakeCity,[findsnd(2015,12,1,0,SaltLakeCity):findsnd(2016,3,31,0,SaltLakeCity),...
    findsnd(2016,12,1,0,SaltLakeCity):findsnd(2017,3,31,0,SaltLakeCity)],1)
title({['Ice phase space for Dec-Mar 2015-16, 2016-17'],'Salt Lake City, UT'});
figureSLC2015to2016.Position=[2561 -679 1920 1080];

% Denver
figureDenver2016to2017=growthDiagramProfile_SEY(Denver,[findsnd(2016,12,1,0,Denver):findsnd(2017,3,31,0,Denver),...
    findsnd(2017,12,1,0,Denver):findsnd(2018,3,31,0,Denver)],1)
title({['Ice phase space for Dec-Mar 2016-17, 2017-18'],'Denver, CO'});
figureDenver2016to2017.Position=[2561 -679 1920 1080];

% Barrow, no Barrow data in 2018
figureBarrow2015to2016=growthDiagramProfile_SEY(Barrow,[findsnd(2015,12,1,0,Barrow):findsnd(2016,3,31,0,Barrow),...
    findsnd(2016,12,1,0,Barrow):findsnd(2017,3,31,0,Barrow)],1)
title({['Ice phase space for Dec-Mar 2015-16, 2016-17'],'Barrow, AK'});
figureBarrow2015to2016.Position=[2561 -679 1920 1080]; %sets size of figure
% moving axis
get(gca,'Position');
set(gca,'Position',[.11 0.11 0.775 0.850]); % from bottom left is x and y 0, 0, scaled to zero to 1

% Greensboro
figureGreensboro2015to2016=growthDiagramProfile_SEY(Greensboro,[findsnd(2015,12,1,0,Greensboro):findsnd(2016,2,29,0,Greensboro),...
    findsnd(2016,12,1,0,Greensboro):findsnd(2017,2,28,0,Greensboro)],1)
title({['Ice phase space for Dec-Feb 2015-16, 2016-17'],'Greensboro, NC'});
figureGreensboro2015to2016.Position=[2561 -679 1920 1080]; %sets size of figure



%%%%%%%%%%%%%%%%%%%%

% get sounding data in right format
%file1='USM00072501-data.txt';
%this took a long time to load) 
% [Upton]=fullIGRAimpv2(file1);
%this is saved to upton-soundings.mat
load('upton-soundings.mat'); %creates variable Upton

% Salt Lake City
%file1='USM00072572-data.txt';
%[SaltLakeCity]=fullIGRAimpv2(file1);
load('saltlakecity-soundings.mat');



%Grey, ME
file1='USM00074389-data.txt';
[GreyME]=fullIGRAimpv2(file1);
load('GreyME-soundings.mat');

%Denver, CO
file1='USM00072469-data.txt';
[Denver]=fullIGRAimpv2(file1);
load('denver-soundings.mat');



%Barrow, AK
file1='USM00070026-data.txt';
[Barrow]=fullIGRAimpv2(file1);
load('barrow-soundings.mat');

%McMurdo, Antarctica
file1='AYM00089664-data.txt';
[McMurdo]=fullIGRAimpv2(file1);
load('mcmurdo-soundings.mat'); % small file, good for testing

%Anchorage, AK
file1='USM00070273-data.txt';
[Anchorage]=fullIGRAimpv2(file1);
load('anchorage-soundings.mat'); 

%Greensboro, NC, not done yet
file1='USM00072317-data.txt';
[Greensboro]=fullIGRAimpv2(file1);
load('greensboro-soundings.mat');



% get the indices
findsnd(2015,12,1,0,Upton);  %15459
findsnd(2016,2,1,0,Upton);  %15587

findsnd(2016,12,1,0,Upton);  %16205
findsnd(2017,2,1,0,Upton); %16328


growthDiagramProfile_SEY(Upton,[15459:15587],1)
title({['Ice phase space for Dec 2015- Feb 2016'],'Upton, NY'});

growthDiagramProfile_SEY(Upton,[16205:16328],1)
title({['Ice phase space for Dec 2016- Feb 2017'],'Upton, NY'});





% Warning: MATLAB previously crashed due to a low-level graphics error. To
% prevent another crash in this session, MATLAB is using software OpenGL instead
% of using your graphics hardware. To save this setting for future sessions, use
% the opengl('save', 'software') command. For more information, see Resolving
% Low-Level Graphics Issues. 


