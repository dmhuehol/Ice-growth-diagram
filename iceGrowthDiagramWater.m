function [fig,legendEntries,legendTexts] = iceGrowthDiagramWater(hd,ventLog,legLog,legendLocStr,xlimRange,ylimRange)
%%iceGrowthDiagram
    %Function to plot an ice growth diagram with relative humidity with
    %respect to water as abscissa. Returns the figure handle so further
    %modifications are possible.
    %
    %General form: [fig] = iceGrowthDiagram(hd,legLog,legendLocStr,xlimRange,ylimRange)
    %
    %Output
    %fig: figure handle for the ice growth diagram
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %ventLog: logical 1/0 to show ventilation
    %legLog: logical 1/0 to show the legend
    %legendLocStr: legend location string ('southoutside' is standard)
    %xlimRange: determines the range for the x-axis, input as 2-element array (i.e. [55 124])
    %ylimRange: determines range for the y-axis (in deg C), input as
    %2-element array in increasing order (i.e. [-56.5 0]). Minimum
    %temperature cannot be less than -70 degrees Celsius.
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Edits made as part of HON499: Capstone II
    %Version date: 3/19/2020
    %Last major revision: 11/22/2019
    %
    %See also makeGrowthDiagramStruct, iceGrowthDiagram
    %

%% Check variables
if nargin == 0
    disp('Creating default ice diagram!')
    pause(1) %For the vibes
    crystalLog = 1;
    otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate full structure
end
if isnumeric(hd)==1
    msg = 'Make sure hd structure is first input!';
    error(msg)
end
if ~exist('hd','var')
    crystalLog = 1;
    otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate full structure
end
if ~exist('ventLog','var')
    ventLog = 0;
end
if ~exist('legLog','var')
    legLog = 1;
    disp('Legend enabled by default')
end
if ~exist('legendLocStr','var')
    legendLocStr = 'southoutside';
    disp('Legend location defaults to below the figure');
end
if ~exist('xlimRange','var')
    if ventLog
        xlimRange = [55 124];
        disp('Default RHwater range for x-axis (with ventilation) is 55 to 124%')
    else
        xlimRange = [55 105];
        disp('Default RHwater range for x-axis is 55 to 107%')
    end    
end
if ~exist('ylimRange','var')
    ylimRange = [-56.5 0];
    disp(['Default temperature range for y-axis is -56.5 to 0' char(176) 'C'])
end
if legendLocStr == 0
    legendLocStr = 'none';
end

%% Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

%% Draw the growth types
Tupper = 15; Tlower = -70;
TlineStandardC = Tupper:-0.1:Tlower;

plates = patch(hd.Plates.waterBounds, hd.Plates.TempBounds, hd.Plates.Color);
plates.EdgeColor = 'none';
columnlike = patch(hd.ColumnLike.waterBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.Color);
columnlike.EdgeColor = 'none';
variousplates = patch(hd.VariousPlates.waterBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.Color);
variousplates.EdgeColor = 'none';
polycrystalsP1 = patch(hd.PolycrystalsP.waterBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.Color);
polycrystalsP1.EdgeColor = 'none';
polycrystalsP2 = patch(hd.PolycrystalsP.waterBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.Color);
polycrystalsP2.EdgeColor = 'none';
polycrystalsC1 = patch(hd.PolycrystalsC.waterBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.Color);
polycrystalsC1.EdgeColor = 'none';
polycrystalsC2 = patch(hd.PolycrystalsC.waterBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.Color);
polycrystalsC2.EdgeColor = 'none';
sectorplates1 = patch(hd.SectorPlates.waterBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.Color);
sectorplates1.EdgeColor = 'none';
sectorplates2 = patch(hd.SectorPlates.waterBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.Color);
sectorplates2.EdgeColor = 'none';
sectorplates3 = patch(hd.SectorPlates.waterBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.Color);
sectorplates3.EdgeColor = 'none';
dendrites = patch(hd.Dendrites.waterBounds,hd.Dendrites.TempBounds,hd.Dendrites.Color);
dendrites.EdgeColor = 'none';

intermediateSPD_floor = patch([hd.Dendrites.waterBounds(1),hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(2) hd.Dendrites.waterBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color; hd.SectorPlates.Color],4,[],3));
intermediateSPD_floor.EdgeColor = 'none';
intermediateSPD_wall = patch([hd.SectorPlates.waterBounds(2,3) hd.SectorPlates.waterBounds(2,2) hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(4)], [hd.SectorPlates.TempBounds(3) hd.SectorPlates.TempBounds(2) hd.Dendrites.TempBounds(1) hd.Dendrites.TempBounds(3)],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_wall.EdgeColor = 'none';
intermediateSPD_ceiling = patch([hd.Dendrites.waterBounds(4),hd.Dendrites.waterBounds(4) hd.SectorPlates.waterBounds(6) hd.SectorPlates.waterBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.Color; hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_ceiling.EdgeColor = 'none';
intermediateSPD_triangleTop = patch([hd.SectorPlates.waterBounds(2,3) hd.Dendrites.waterBounds(4) hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(3) hd.Dendrites.TempBounds(3) hd.SectorPlates.TempBounds(3)], reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.SectorPlates.Color],3,[],3));
intermediateSPD_triangleTop.EdgeColor = 'none';
intermediateSPD_triangleBottom = patch([hd.SectorPlates.waterBounds(2,2), hd.Dendrites.waterBounds(1), hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(2), hd.Dendrites.TempBounds(1), hd.SectorPlates.TempBounds(2)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.SectorPlates.Color],3,[],3));
intermediateSPD_triangleBottom.EdgeColor = 'none';

mixed1 = patch(hd.Mixed.waterBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.Color);
mixed1.EdgeColor = 'none';

mixed2 = patch(hd.Mixed.waterBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.Color);
mixed2.EdgeColor = 'none';
warmerThanFreezing = patch(hd.warm.waterBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.waterBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
if ventLog
    unnaturalVent = patch(hd.unnaturalVent.waterBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
    unnaturalVent.EdgeColor = 'none';
end
unnatural105 = patch(hd.unnatural105.waterBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
unnatural105.EdgeColor = 'none';
hold on

legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 subsaturated];
legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Subsaturated wrt ice, no crystal growth'};

%% Plot other lines
esw50LineStandard = plot([50 50],[-70 0]);
esw50LineStandard.Color = [255 230 0]./255;
esw50LineStandard.LineWidth = 3.2;
esw50LineStandard.LineStyle = ':';

esw60LineStandard = plot([60 60],[-70 0]);
esw60LineStandard.Color = [255 230 0]./255;
esw60LineStandard.LineWidth = 3.2;
esw60LineStandard.LineStyle = ':';

esw70LineStandard = plot([70 70],[-70 0]);
esw70LineStandard.Color = [255 230 0]./255;
esw70LineStandard.LineWidth = 3.2;
esw70LineStandard.LineStyle = ':';

esw80LineStandard = plot([80 80],[-70 0]);
esw80LineStandard.Color = [255 230 0]./255;
esw80LineStandard.LineWidth = 3.2;
esw80LineStandard.LineStyle = ':';

esw90LineStandard = plot([90 90],[-70 0]);
esw90LineStandard.Color = [255 230 0]./255;
esw90LineStandard.LineWidth = 3.2;
esw90LineStandard.LineStyle = ':';

esw100SupersatLineStandard = plot([100 100],[-70 0]);
esw100SupersatLineStandard.Color = [255 230 0]./255;
esw100SupersatLineStandard.LineWidth = 3.2;
esw100SupersatLineStandard.LineStyle = ':';
legendEntries(end+1) = esw100SupersatLineStandard;
legendTexts{end+1} = 'Isohumes (10% intervals)';

if ventLog
    esw102p5LineStandard = plot([102.5 102.5],[-70 -2.6]);
else
    esw102p5LineStandard = plot([102.5 102.5],[-70 0]);
end
esw102p5LineStandard.Color = [255 230 0]./255;
esw102p5LineStandard.LineWidth = 3.2;
esw102p5LineStandard.LineStyle = '-.';

if ventLog
    esw105LineStandard = plot([105 105],[-70 -5.2]);
else
    esw105LineStandard = plot([105 105],[-70 0]);
end
esw105LineStandard.Color = [255 230 0]./255;
esw105LineStandard.LineWidth = 3.2;
esw105LineStandard.LineStyle = '-.';
legendEntries(end+1) = esw105LineStandard;
legendTexts{end+1} = 'Isohumes (102.5%, 105%)';

startMat = ones(1,length(TlineStandardC));

water_esi0LineData = iceSupersatToRH(startMat.*0,TlineStandardC);
esi0Line = plot(water_esi0LineData,TlineStandardC);
esi0Line.Color = [255 230 0]./255;
esi0Line.LineWidth = 3.2;
hold on

water_esi10LineData = iceSupersatToRH(startMat.*10,TlineStandardC);
if ventLog
    esi10Line = plot(water_esi10LineData(201:end),TlineStandardC(201:end));
else
    esi10Line = plot(water_esi10LineData(198:end),TlineStandardC(198:end));
end
esi10Line.Color = [255 230 0]./255;
esi10Line.LineWidth = 3.2;

water_esi20LineData = iceSupersatToRH(startMat.*20,TlineStandardC);
if ventLog
    esi20Line = plot(water_esi20LineData(248:end),TlineStandardC(248:end));
else
    esi20Line = plot(water_esi20LineData(285:end),TlineStandardC(285:end));
end
esi20Line.Color = [255 230 0]./255;
esi20Line.LineWidth = 3.2;

water_esi30LineData = iceSupersatToRH(startMat.*30,TlineStandardC);
if ventLog
    esi30Line = plot(water_esi30LineData(291:end),TlineStandardC(291:end));
else
    esi30Line = plot(water_esi30LineData(366:end),TlineStandardC(366:end));
end
esi30Line.Color = [255 230 0]./255;
esi30Line.LineWidth = 3.2;

water_esi40LineData = iceSupersatToRH(startMat.*40,TlineStandardC);
if ventLog
    esi40Line = plot(water_esi40LineData(335:end),TlineStandardC(335:end));
else
    esi40Line = plot(water_esi40LineData(441:end),TlineStandardC(441:end));
end
esi40Line.Color = [255 230 0]./255;
esi40Line.LineWidth = 3.2;

water_esi50LineData = iceSupersatToRH(startMat.*50,TlineStandardC);
if ventLog
    esi50Line = plot(water_esi50LineData(376:end),TlineStandardC(376:end));
else
    esi50Line = plot(water_esi50LineData(514:end),TlineStandardC(514:end));
end
esi50Line.Color = [255 230 0]./255;
esi50Line.LineWidth = 3.2;

water_esi60LineData = iceSupersatToRH(startMat.*60,TlineStandardC);
if ventLog
    esi60Line = plot(water_esi60LineData(416:end),TlineStandardC(416:end));
else
    esi60Line = plot(water_esi60LineData(584:end),TlineStandardC(584:end));
end
esi60Line.Color = [255 230 0]./255;
esi60Line.LineWidth = 3.2;
legendEntries(end+1) = esi60Line;
legendTexts{end+1} = 'Ice-isohumes (100% min, 160% max, 10% interval)';

if ventLog
    [eswLineData] = eswLine(100,Tlower,Tupper);
    water_ventLineData = iceSupersatToRH(2*eswLineData(151:end).*100,TlineStandardC(151:end));
    water_ventLine = plot(water_ventLineData,TlineStandardC(151:end));
    water_ventLine.Color = [0 26 255]./255;
    water_ventLine.LineWidth = 3.2;
    legendEntries(end+1) = water_ventLine;
    legendTexts{end+1} = 'Approximate max natural saturation with ventilation';
end

% 200% RH line (compare to 2*esw ventilation line)
%water_vent200Line = plot([200,200],[25,-75]);
%water_vent200Line.Color = [204,121,167]./255;
%water_vent200Line.LineWidth = 3.2;
%legendEntries(end+1) = water_vent200Line;
%legendTexts{end+1} = '200% RH';

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
yLab = ylabel(['Height above 0' char(176) 'C level in m (ICAO standard atmosphere)']);
yLab.FontName = 'Lato Bold';

yyaxis left %Changes what axis dot notation refers
ylim(ylimRange)
xlim(xlimRange)

t = title('Ice growth diagram');
t.FontName = 'Lato Bold';
t.FontSize = 20;
yLab = ylabel(['Temperature in ' char(176) 'C']);
yLab.FontName = 'Lato Bold';
xLab = xlabel('Relative humidity with respect to water (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
if ventLog
    axe.XTick = [50 55 60 70 80 90 100 110 120 130 140 150 160 170];
else
    axe.XTick = [50 55 60 70 80 90 100 102.5 105];
end
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