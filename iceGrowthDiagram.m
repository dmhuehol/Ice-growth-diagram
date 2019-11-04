function [fig,legendEntries,legendTexts] = iceGrowthDiagram(hd,freezingLineLog,isohumeFlag,ventLog,updraftLog,legLog,legendLocStr,xlimRange,ylimRange)
%%iceGrowthDiagram
    %Function to plot an ice growth diagram. Returns the figure handle
    %so further modifications are possible.
    %
    %General form: [fig] = iceGrowthDiagram(hd,freezingLineLog,isohumeFlag,ventLog,updraftLog,legLog,legendLocStr,xlimRang,ylimRange)
    %
    %Output
    %fig: figure handle for the ice growth diagram
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %freezingLineLog: logical 1/0 to draw a line at 0 deg C
    %isohumeFlag: flag for drawing lines of constant RH with respect to water.
    %    1 draws RH lines at 10% intervals from 0 to 100, and at 2.5% and
    %       5% supersaturations with respect to water
    %    2 draws only the water saturation line (RH=100%)
    %    0 and all other values don't plot any isohumes
    %ventLog: logical 1/0 to draw the maximum natural supersaturation line
    %updraftLog: logical 1/0 to draw guesstimated maximum supersaturation in updraft.
    %   Requires secondary function updraftSupersat
    %   CAUTION: this is OF VERY DUBIOUS ACCURACY!
    %legLog: logical 1/0 to show the legend
    %legendLocStr: legend location string ('southeast' is standard, call
    % with 'southoutside' to move legend below the figure)
    %xlimRange: determines the range for the x-axis, input as 2-element array (i.e. [0 0.6])
    %ylimRange: determines range for the y-axis (in deg C), input as
    %2-element array in increasing order (i.e. [-60 0]). Minimum
    %temperature cannot be less than -70 degrees Celsius.
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 11/4/2019
    %Last major revision: 11/4/2019
    %
    %See also makeGrowthDiagramStruct, eswLine, ylimitsForIceDiagram
    %

%% Check variables
if ~exist('hd','var')
    crystalLog = 1;
    otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information
end
if ~exist('updraftLog','var')
    updraftLog = 0;
    disp('Updraft guesstimation disabled by default');
end
if ~exist('legendLocStr','var')
    legendLocStr = 'southeast';
    disp('Legend location defaults to southeast');
end
if ~exist('xlimRange','var')
    xlimRange = [0 0.6];
    disp('Default ice supersaturation range for x-axis is 0 to 60%')
end
if ~exist('ylimRange','var')
    ylimRange = [-56.5 0];
    disp(['Default temperature range for y-axis is -56.5 to 0' char(176) 'C'])
end

%% Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

%% Draw the growth types
plates = patch(hd.Plates.supersatBounds, hd.Plates.TempBounds,hd.Plates.Color);
plates.EdgeColor = 'none';
columnlike = patch(hd.ColumnLike.supersatBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.Color);
columnlike.EdgeColor = 'none';
variousplates = patch(hd.VariousPlates.supersatBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.Color);
variousplates.EdgeColor = 'none';
polycrystalsP1 = patch(hd.PolycrystalsP.supersatBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.Color);
polycrystalsP1.EdgeColor = 'none';
polycrystalsP2 = patch(hd.PolycrystalsP.supersatBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.Color);
polycrystalsP2.EdgeColor = 'none';
polycrystalsC1 = patch(hd.PolycrystalsC.supersatBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.Color);
polycrystalsC1.EdgeColor = 'none';
polycrystalsC2 = patch(hd.PolycrystalsC.supersatBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.Color);
polycrystalsC2.EdgeColor = 'none';
polycrystalsI = patch(hd.PolycrystalsIntermediate.supersatBounds,hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.Color(1,:));
polycrystalsI2 = patch(hd.PolycrystalsIntermediate.supersatBounds,hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.Color(2,:));
polycrystalsI.EdgeColor = 'none'; polycrystalsI.FaceAlpha = 1;
polycrystalsI2.EdgeColor = 'none'; polycrystalsI2.FaceAlpha = 1;
sectorplates1 = patch(hd.SectorPlates.supersatBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.Color);
sectorplates1.EdgeColor = 'none';
sectorplates2 = patch(hd.SectorPlates.supersatBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.Color);
sectorplates2.EdgeColor = 'none';
sectorplates3 = patch(hd.SectorPlates.supersatBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.Color);
sectorplates3.EdgeColor = 'none';
dendrites = patch(hd.Dendrites.supersatBounds,hd.Dendrites.TempBounds,hd.Dendrites.Color);
dendrites.EdgeColor = 'none';
intermediateSPD_floor = patch([hd.Dendrites.supersatBounds(1),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(2) hd.Dendrites.supersatBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color; hd.SectorPlates.Color],4,[],3));
intermediateSPD_floor.EdgeColor = 'none';
intermediateSPD_wall = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_wall.EdgeColor = 'none';
intermediateSPD_ceiling = patch([hd.Dendrites.supersatBounds(4),hd.Dendrites.supersatBounds(4) hd.SectorPlates.supersatBounds(6) hd.SectorPlates.supersatBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.Color; hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_ceiling.EdgeColor = 'none';
intermediateSPD_cursedTriangle = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.SectorPlates.Color],3,[],3));
intermediateSPD_cursedTriangle.EdgeColor = 'none';
mixed1 = patch(hd.Mixed.supersatBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.Color);
mixed1.EdgeColor = 'none';
mixed2 = patch(hd.Mixed.supersatBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.Color);
mixed2.EdgeColor = 'none';
warmerThanFreezing = patch(hd.warm.supersatBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.supersatBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
unnatural = patch(hd.unnatural.supersatBounds,hd.unnatural.TempBounds,hd.unnatural.Color);
unnatural.EdgeColor = 'none';
hold on

%legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 subsaturated];
legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1]; %Disabling subsaturated to make images
%legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Subsaturated'};
legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit};

%% Plot other lines
if freezingLineLog==1
    %Draw line at 0 deg C
    TlineFreezing = plot([-20,100],[0,0]);
    TlineFreezing.LineWidth = 3.2;
    TlineFreezing.Color = [255 0 255]./255;
    legendEntries(end+1) = TlineFreezing;
    legendTexts{end+1} = 'Freezing line';
end

Tupper = 15; Tlower = -70;
TlineStandardC = Tupper:-0.1:Tlower;
[eswLineData] = eswLine(100,Tlower,Tupper);
if isohumeFlag==1
    %Draw isohumes, below 100% is one line style and above 100% is another
    %line style
    eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
    eswSupersatLineStandard.Color = [255 230 0]./255;
    eswSupersatLineStandard.LineWidth = 3.2;
    
    eswLine90Data = eswLine(90,Tlower,Tupper);
    eswSupersatLineStandard90 = plot(eswLine90Data,TlineStandardC);
    eswSupersatLineStandard90.LineStyle = ':';
    eswSupersatLineStandard90.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard90.LineWidth = 3.2;
    
    eswLine80Data = eswLine(80,Tlower,Tupper);
    eswSupersatLineStandard80 = plot(eswLine80Data,TlineStandardC);
    eswSupersatLineStandard80.LineStyle = ':';
    eswSupersatLineStandard80.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard80.LineWidth = 3.2;
    
    eswLine70Data = eswLine(70,Tlower,Tupper);
    eswSupersatLineStandard70 = plot(eswLine70Data,TlineStandardC);
    eswSupersatLineStandard70.LineStyle = ':';
    eswSupersatLineStandard70.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard70.LineWidth = 3.2;
    
    eswLine60Data = eswLine(60,Tlower,Tupper);
    eswSupersatLineStandard60 = plot(eswLine60Data,TlineStandardC);
    eswSupersatLineStandard60.LineStyle = ':';
    eswSupersatLineStandard60.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard60.LineWidth = 3.2;
    
    eswLine50Data = eswLine(50,Tlower,Tupper);
    eswSupersatLineStandard50 = plot(eswLine50Data,TlineStandardC);
    eswSupersatLineStandard50.LineStyle = ':';
    eswSupersatLineStandard50.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard50.LineWidth = 3.2;
    
    eswLine40Data = eswLine(40,Tlower,Tupper);
    eswSupersatLineStandard40 = plot(eswLine40Data,TlineStandardC);
    eswSupersatLineStandard40.LineStyle = ':';
    eswSupersatLineStandard40.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard40.LineWidth = 3.2;
    
    eswLine30Data = eswLine(30,Tlower,Tupper);
    eswSupersatLineStandard30 = plot(eswLine30Data,TlineStandardC);
    eswSupersatLineStandard30.LineStyle = ':';
    eswSupersatLineStandard30.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard30.LineWidth = 3.2;
    
    eswLine20Data = eswLine(20,Tlower,Tupper);
    eswSupersatLineStandard20 = plot(eswLine20Data,TlineStandardC);
    eswSupersatLineStandard20.LineStyle = ':';
    eswSupersatLineStandard20.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard20.LineWidth = 3.2;
    
    eswLine10Data = eswLine(10,Tlower,Tupper);
    eswSupersatLineStandard10 = plot(eswLine10Data,TlineStandardC);
    eswSupersatLineStandard10.LineStyle = ':';
    eswSupersatLineStandard10.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard10.LineWidth = 3.2;
    
    eswLine0Data = eswLine(0,Tlower,Tupper);
    eswSupersatLineStandard0 = plot(eswLine0Data,TlineStandardC);
    eswSupersatLineStandard0.LineStyle = ':';
    eswSupersatLineStandard0.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard0.LineWidth = 3.2;
    
    eswLinep25Data = eswLine(102.5,Tlower,Tupper);
    eswSupersatLineStandardp25 = plot(eswLinep25Data(151:end),TlineStandardC(151:end));
    eswSupersatLineStandardp25.LineStyle = '-.';
    eswSupersatLineStandardp25.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandardp25.LineWidth = 3.2;
    
    eswLinep5Data = eswLine(105,Tlower,Tupper);
    eswSupersatLineStandardp5 = plot(eswLinep5Data(151:end),TlineStandardC(151:end));
    eswSupersatLineStandardp5.LineStyle = '-.';
    eswSupersatLineStandardp5.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandardp5.LineWidth = 3.2;
    
    
    legendEntries(end+1) = eswSupersatLineStandard;
    legendEntries(end+1) = eswSupersatLineStandard90;
    legendEntries(end+1) = eswSupersatLineStandardp5;
    
    legendTexts{end+1} = 'Water saturation line (T_{ice} = T_{air})';
    legendTexts{end+1} = 'Saturation with respect to water (10% intervals)';
    legendTexts{end+1} = 'Saturation with respect to water (102.5%, 105%)';
    
elseif isohumeFlag==2
    %Draw isohumes, just 100% only
    Tupper = 15; Tlower = -70;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
    eswSupersatLineStandard.Color = [255 230 0]./255;
    eswSupersatLineStandard.LineWidth = 3.2;
    
    legendEntries(end+1) = eswSupersatLineStandard;
    legendTexts{end+1} = 'Water saturation line (T_{ice} = T_{air})';
else
    %do nothing, don't plot isohumes
end

if ventLog==1
    %Approximate maximum supersaturation line
    maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
    maxVentLine.Color = [0 26 255]./255;
    maxVentLine.LineWidth = 3.2;
    
    legendEntries(end+1) = maxVentLine;
    legendTexts{end+1} = 'Approximate max natural supersat (with ventilation)';
end
if updraftLog == 1
    %Plot guesstimated maximum updraft supersaturation (of questionable use)
    [s_max] = updraftSupersat(1000,1,1);
    s_maxUsable = 1+s_max;
    [updraftMaxSupersatPoints] = eswLine(s_maxUsable*100,Tlower,Tupper);
    lineSupersat = plot(updraftMaxSupersatPoints,TlineStandardC);
    lineSupersat.LineWidth = 2;
    
    legendEntries(end+1) = lineSupersat;
    legendTexts{end+1} = 'Guesstimated max supersat in updraft';
end

%% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 18;

yyaxis right
[zLabels, tempsInRange, rightLimits] = ylimitsForIceDiagram(ylimRange);
axe.YTick = tempsInRange;
yticklabels(zLabels);
ylim(rightLimits)
axe.Layer = 'top';
yLab = ylabel('Height above freezing level in m (ICAO standard atmosphere)');
yLab.FontName = 'Lato Bold';

yyaxis left %Changes what axis dot notation refers
ylim(ylimRange)
xlim(xlimRange)

t = title('Ice growth diagram');
t.FontName = 'Lato Bold';
t.FontSize = 20;
yLab = ylabel(['Temperature in ' char(176) 'C']);
yLab.FontName = 'Lato Bold';
xLab = xlabel('Relative humidity with respect to ice (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
xTickLabels = {'100' '105' '110' '115' '120' '125' '130' '135' '140' '145' '150' '155' '160'}; %these would change if RHice to plus 100
xticklabels(xTickLabels);
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
axe.YDir = 'reverse';

leg = legend(legendEntries,legendTexts);
leg.Location = legendLocStr;
leg.NumColumns = 3;
leg.FontSize = 14;

if legLog==0
    leg.Visible = 'off';
end

end