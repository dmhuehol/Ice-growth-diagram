function [fig] = growthDiagramModelProfile(sounding,timeIndex,legLog,input_title)
%%growthDiagramModelProfile
    %Function to plot a modeled temperature/humidity profile on the ice growth
    %diagram. Saturation vapor pressure equations use the Improved
    %August-Roche-Magnus equation from
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 25 and 27 from above citation.
    %
    %General form: growthDiagramProfile(sounding,timeIndex,legLog)
    %
    %Inputs
    %sounding: a processed sounding data structure, must include moisture data
    %timeIndex: the index of the desired sounding within the structure
    %legLog: logical 1/0 to plot/not plot the rather giant legend. Enabled by default.
    %
    %Requires secondary functions makeGrowthDiagramStruct,
    %iceGrowthDiagram, and eswLine
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 10/24/2019
    %Last major revision: 10/24/2019
    %
    %See also makeGrowthDiagramStruct, iceGrowthDiagram, eswLine
    %

%% Variable checks
if ~exist('legLog','var')
    legLog = 1;
    disp('Legend enabled by default')
end
if legLog~=0 && legLog~=1
    legLog = 1;
    disp('Legend enabled by default')
end

%% Setup growth diagram
crystalLog = 1; otherLog = 1;
[hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information

freezingLineLog = 1; isohumesLog = 1; ventLog = 1; updraftLog = 0; legLogForGeneration = 1;
supersatLim = [-0.6,0.6]; %[0,0.6] is standard
tempLim = [-56.5,30]; % [-56.5,0] is standard, omits stratosphere
[fig,legendEntries,legendText] = iceGrowthDiagram(hd,freezingLineLog,isohumesLog,ventLog,updraftLog,legLogForGeneration,'southeast',supersatLim,tempLim); %Plot the growth diagram

space = ' ';
t = title(['Ice phase space for ' space input_title]);
t.FontName = 'Lato Bold';
t.FontSize = 20;

%% Plot points on the parameter space defined by the ice growth diagram
disp('Plotting in progress!')
totalNumber = length(timeIndex);
disp(['Total number of soundings to plot is ', num2str(totalNumber)]);  % Reports number of soundings to plot
markers = ['o','+','*','x','s','d','p','h','^','v','>','<'];
for c = 1:length(timeIndex)
    
    %Provide some info about progress
    loopTime = timeIndex(c);
    if mod(loopTime,100)==0
        disp(strcat(num2str(round((loopTime-timeIndex(1))/totalNumber*100)), '% complete')) % Progress report at command window
    end
    
    radiosondeHeight = [sounding(loopTime).height];
    radiosondeHeight1 = radiosondeHeight<=2000;
    radiosondeHeight2 = radiosondeHeight<=4000 & radiosondeHeight>2000;
    radiosondeHeight3 = radiosondeHeight<=6000 & radiosondeHeight>4000;
    radiosondeHeight4 = radiosondeHeight<=8000 & radiosondeHeight>6000;
    radiosondeHeight5 = radiosondeHeight<=10000 & radiosondeHeight>8000;
    radiosondeHeightRest = radiosondeHeight>10000;
    
    rhumDecimal = [sounding(loopTime).rhum]./100; %Need humidity in decimal to plot balloon data
    
    rhumDecimal = round(rhumDecimal,3); %Rounding forces the points to fall more clearly along isohumes!
    
    radiosondeTemp = [sounding(loopTime).temp]; %Celsius for plotting
    
    % Original equations from MEA312 notes
    %radiosondeTempK = radiosondeTemp+273.15; %Kelvins for supersaturation calculations
    %eswStandardFromRadiosonde = hd.Constants.es0*exp(hd.Constants.Lvap/hd.Constants.Rv*(1/273.15-1./radiosondeTempK)); %Saturated vapor pressure with respect to water
    %esiStandardFromRadiosonde = hd.Constants.es0*exp(hd.Constants.Lsub/hd.Constants.Rv*(1/273.15-1./radiosondeTempK)); %Saturated vapor pressure with respect to ice
    
    eswStandardFromRadiosonde = (6.1094.*exp((17.625.*radiosondeTemp)./(243.04+radiosondeTemp))).*100;
    esiStandardFromRadiosonde = (6.1121.*exp((22.587.*radiosondeTemp)./(273.86+radiosondeTemp))).*100;
    soundingHumidity = rhumDecimal.*eswStandardFromRadiosonde;
    %soundingHumidity = 0.6.*eswStandardFromRadiosonde;
    soundingHumidityPoints = (soundingHumidity-esiStandardFromRadiosonde)./esiStandardFromRadiosonde;
    
    shp1 = soundingHumidityPoints(radiosondeHeight1);
    shp2 = soundingHumidityPoints(radiosondeHeight2);
    shp3 = soundingHumidityPoints(radiosondeHeight3);
    shp4 = soundingHumidityPoints(radiosondeHeight4);
    shp5 = soundingHumidityPoints(radiosondeHeight5);
    shpRest = soundingHumidityPoints(radiosondeHeightRest);
    if length(timeIndex)<length(markers)
        markerSelect = markers(c);
    else
        markerSelect = markers(1);
        disp('Too many profiles to give unique markers! All profiles plotted as circles.')
    end
    plot(soundingHumidityPoints,radiosondeTemp,'LineWidth',2);
    hold on
    pc1 = scatter(shp1,radiosondeTemp(radiosondeHeight1),'filled','MarkerEdgeColor',[213,94,0]./255,'MarkerFaceColor',[213,94,0]./255,'Marker',markerSelect);
    hold on
    pc2 = scatter(shp2,radiosondeTemp(radiosondeHeight2),'filled','MarkerEdgeColor',[0 114 178]./255,'MarkerFaceColor',[0 114 178]./255,'Marker',markerSelect);
    pc3 = scatter(shp3,radiosondeTemp(radiosondeHeight3),'filled','MarkerEdgeColor',[86 180 233]./255,'MarkerFaceColor',[86 180 233]./255,'Marker',markerSelect);
    pc4 = scatter(shp4,radiosondeTemp(radiosondeHeight4),'filled','MarkerEdgeColor',[0 158 115]./255,'MarkerFaceColor',[0 158 115]./255,'Marker',markerSelect);
    pc5 = scatter(shp5,radiosondeTemp(radiosondeHeight5),'filled','MarkerEdgeColor',[0 0 0]./255,'MarkerFaceColor',[0 0 0]./255,'Marker',markerSelect);
    pcRest = scatter(shpRest,radiosondeTemp(radiosondeHeightRest),'filled','MarkerEdgeColor',[145 144 143]./255,'MarkerFaceColor',[145 144 143]./255);
end

legendEntries(end+1) = pc1;
legendText{end+1} = 'Model height: 0-2 km';
legendEntries(end+1) = pc2;
legendText{end+1} = 'Model height: 2-4 km';
legendEntries(end+1) = pc3;
legendText{end+1} = 'Model height: 4-6 km';
legendEntries(end+1) = pc4;
legendText{end+1} = 'Model height: 6-8 km';
legendEntries(end+1) = pc5;
legendText{end+1} = 'Model height: 8-10 km';
legendEntries(end+1) = pcRest;
legendText{end+1} = 'Model height: >10 km';
leg = legend(legendEntries,legendText);
leg.Location = 'southeast';
leg.FontSize = 10;
if legLog==0
    leg.Visible = 'off';
end


end