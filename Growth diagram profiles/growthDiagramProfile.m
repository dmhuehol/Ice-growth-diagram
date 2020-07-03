function [fig] = growthDiagramProfile(sounding,timeIndex,legLog,phaseFlag,manual)
%%growthDiagramProfile
    %Function to plot a balloon temperature/humidity profile on the ice growth
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
    %legLog: logical 1/0 to plot/not plot legend. Enabled by default.
    %phaseFlag: 'water' to plot as relative humidity with respect to water,
    %   'ice' to plot as relative humidity with respect to ice
    %manual: 'm' to use date and launchname designated in code, any other
    %   value or leave off for user to be prompted for these
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 7/2/2020
    %Last major revision: 7/2/2020
    %
    %See also makeGrowthDiagramStruct, iceGrowthDiagram, iceGrowthDiagramWater, eswLine
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
if ~exist('manual','var')
    manual = 0;
end

%% Set up growth diagram
crystalLog = 1; otherLog = 1;
[hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information

if strcmp(phaseFlag,'ice')==1  
    isohumesLog = 1; ventLog = 0; updraftLog = 0; legLogForGeneration = 1;
    legLocation = 'southeast';
    satLim = [0,0.6]; %[0,0.6] is standard
    tempLim = [-56.5,0]; % [-56.5,0] is standard
    [fig,legendEntries,legendText] = iceGrowthDiagram(hd,isohumesLog,ventLog,updraftLog,legLogForGeneration,legLocation,satLim,tempLim); %Plot the growth diagram
elseif strcmp(phaseFlag,'water')==1
    legLogForGeneration = 1;
    legLocation = 'southoutside';
    ventLog = 0;
    satLim = [55,105]; %[55 105] is standard without ventilation; [55 124] with ventilation
    tempLim = [-56.5,0]; % [-56.5,0] is standard
    [fig,legendEntries,legendText] = iceGrowthDiagramWater(hd,ventLog,legLogForGeneration,legLocation,satLim,tempLim); %Plot the growth diagram
end    

if length(timeIndex)==1
    % Autogenerate title for single profiles
    try
        dateString = datestr(datenum(sounding(timeIndex).valid_date_num(1),sounding(timeIndex).valid_date_num(2),sounding(timeIndex).valid_date_num(3),sounding(timeIndex).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
        [launchname] = stationLookupIGRAv2(sounding(timeIndex).stationID);
    catch ME %#ok
        dateString = datestr(datenum(sounding(timeIndex).valid_date_num(1),sounding(timeIndex).valid_date_num(2),sounding(timeIndex).valid_date_num(3),sounding(timeIndex).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
        launchname = 'Unknown';
    end
else
    if ~strcmp(manual,'m')
        dateString = input('Enter date for title: ','s');
        launchname = input('Enter location for title: ','s');
    else
        dateString = 'DJF 2019-2020';
        launchname = 'Upton, NY';
    end
end
t = title({['Ice growth profile for ' dateString],launchname});
t.FontName = 'Lato Bold';
t.FontSize = 20;

%% Plot points on the parameter space defined by the ice growth diagram
disp('Plotting in progress!')
totalNumber = length(timeIndex);
disp(['Total number of soundings to plot is ', num2str(totalNumber)]);  % Reports number of soundings to plot
for c = 1:length(timeIndex)   
    %Provide some info about progress
    loopTime = timeIndex(c);
    if mod(loopTime,100)==0
        disp(strcat(num2str(round((loopTime-timeIndex(1))/totalNumber*100)), '% complete')) % Progress report at command window
    end
    
    if isfield(sounding(loopTime),'geopotential')
        radiosondeHeight = [sounding(loopTime).geopotential];
    elseif isfield(sounding(loopTime),'height')
        radiosondeHeight = [sounding(loopTime).height];
        %TODO: rewrite sounding import functions so we no longer have this
        %ridiculous mismatch between naming conventions
    else
        msg = 'revenge of the good coding practices';
        error(msg)
    end
    radiosondeHeight1 = radiosondeHeight<=2000;
    radiosondeHeight2 = radiosondeHeight<=4000 & radiosondeHeight>2000;
    radiosondeHeight3 = radiosondeHeight<=6000 & radiosondeHeight>4000;
    radiosondeHeight4 = radiosondeHeight<=8000 & radiosondeHeight>6000;
    radiosondeHeight5 = radiosondeHeight<=10000 & radiosondeHeight>8000;
    radiosondeHeightRest = radiosondeHeight>10000;
    
    rhumDecimal = [sounding(loopTime).rhum]./100; %Need humidity in decimal to plot balloon data
    rhumDecimal = round(rhumDecimal,2); %Rounding forces the points to fall more clearly along isohumes!    
    radiosondeTemp = [sounding(loopTime).temp]; %Celsius for plotting
    
    eswStandardFromRadiosonde = (6.1094.*exp((17.625.*radiosondeTemp)./(243.04+radiosondeTemp))).*100;
    esiStandardFromRadiosonde = (6.1121.*exp((22.587.*radiosondeTemp)./(273.86+radiosondeTemp))).*100;
    soundingHumidity = rhumDecimal.*eswStandardFromRadiosonde;

    if strcmp(phaseFlag,'ice')==1 
        soundingIceHumidityPoints = (soundingHumidity-esiStandardFromRadiosonde)./esiStandardFromRadiosonde;
        
        shp1 = soundingIceHumidityPoints(radiosondeHeight1);
        shp2 = soundingIceHumidityPoints(radiosondeHeight2);
        shp3 = soundingIceHumidityPoints(radiosondeHeight3);
        shp4 = soundingIceHumidityPoints(radiosondeHeight4);
        shp5 = soundingIceHumidityPoints(radiosondeHeight5);
        shpRest = soundingIceHumidityPoints(radiosondeHeightRest);        
    elseif strcmp(phaseFlag,'water')==1
        soundingWaterHumidityPoints = rhumDecimal.*100;
        
        shp1 = soundingWaterHumidityPoints(radiosondeHeight1);
        shp2 = soundingWaterHumidityPoints(radiosondeHeight2);
        shp3 = soundingWaterHumidityPoints(radiosondeHeight3);
        shp4 = soundingWaterHumidityPoints(radiosondeHeight4);
        shp5 = soundingWaterHumidityPoints(radiosondeHeight5);
        shpRest = soundingWaterHumidityPoints(radiosondeHeightRest);
        
    end
    
    pc1 = scatter(shp1,radiosondeTemp(radiosondeHeight1),'filled','MarkerEdgeColor',[213,94,0]./255,'MarkerFaceColor',[213,94,0]./255);
    hold on
    pc2 = scatter(shp2,radiosondeTemp(radiosondeHeight2),'filled','MarkerEdgeColor',[0 114 178]./255,'MarkerFaceColor',[0 114 178]./255);
    pc3 = scatter(shp3,radiosondeTemp(radiosondeHeight3),'filled','MarkerEdgeColor',[86 180 233]./255,'MarkerFaceColor',[86 180 233]./255);
    pc4 = scatter(shp4,radiosondeTemp(radiosondeHeight4),'filled','MarkerEdgeColor',[0 158 115]./255,'MarkerFaceColor',[0 158 115]./255);
    pc5 = scatter(shp5,radiosondeTemp(radiosondeHeight5),'filled','MarkerEdgeColor',[0 0 0]./255,'MarkerFaceColor',[0 0 0]./255);
    pcRest = scatter(shpRest,radiosondeTemp(radiosondeHeightRest),'filled','MarkerEdgeColor',[145 144 143]./255,'MarkerFaceColor',[145 144 143]./255);
end

% If following two lines uncommented, legend contains only balloon height entries
legendEntries = [];
legendText = {};

legendEntries(end+1) = pc1;
legendText{end+1} = 'Balloon data: 0-2 km';
legendEntries(end+1) = pc2;
legendText{end+1} = 'Balloon data: 2-4 km';
legendEntries(end+1) = pc3;
legendText{end+1} = 'Balloon data: 4-6 km';
legendEntries(end+1) = pc4;
legendText{end+1} = 'Balloon data: 6-8 km';
legendEntries(end+1) = pc5;
legendText{end+1} = 'Balloon data: 8-10 km';
legendEntries(end+1) = pcRest;
legendText{end+1} = 'Balloon data: >10 km';
leg = legend(legendEntries,legendText);
leg.Location = legLocation;
leg.FontSize = 14;
if legLog==0
    leg.Visible = 'off';
end

end