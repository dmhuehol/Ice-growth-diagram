function [fig,legendEntries,legendTexts] = iceGrowthDiagramWater(hd,freezingLineLog,legLog,legendLocStr,xlimRange,ylimRange)
%%iceGrowthDiagram
    %Function to plot an ice growth diagram in relative humidity with
    %respect to water phase space. Returns the figure handle so further
    %modifications are possible.
    %
    %General form: [fig] = iceGrowthDiagram(hd,freezingLineLog,isohumeFlag,ventLog,legLog,legendLocStr,xlimRang,ylimRange)
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
    %legLog: logical 1/0 to show the legend
    %legendLocStr: legend location string ('southeast' is standard)
    %xlimRange: determines the range for the x-axis, input as 2-element array (i.e. [0 0.6])
    %ylimRange: determines range for the y-axis (in deg C), input as
    %2-element array in increasing order (i.e. [-60 0]). Minimum
    %temperature cannot be less than -70 degrees Celsius.
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 11/1/2019
    %Last major revision: 
    %
    %See also makeGrowthDiagramStruct, eswLine, ylimitsForIceDiagram
    %

%% Check variables
if isnumeric(hd)==1
    msg = 'Make sure hd structure is first input!';
    error(msg)
end
if ~exist('hd','var')
    crystalLog = 1;
    otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information
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
if legendLocStr == 0
    legendLocStr = 'none';
end

%% Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

%% Draw the growth types
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
polycrystalsI = patch(hd.PolycrystalsIntermediate.waterBounds,hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.Color(1,:));
polycrystalsI2 = patch(hd.PolycrystalsIntermediate.waterBounds,hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.Color(2,:));
polycrystalsI.EdgeColor = 'none'; polycrystalsI.FaceAlpha = 1;
polycrystalsI2.EdgeColor = 'none'; polycrystalsI2.FaceAlpha = 1;
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
intermediateSPD_wall = patch([hd.SectorPlates.waterBounds(5),hd.Dendrites.waterBounds(4) hd.Dendrites.waterBounds(4) hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_wall.EdgeColor = 'none';
intermediateSPD_ceiling = patch([hd.Dendrites.waterBounds(4),hd.Dendrites.waterBounds(4) hd.SectorPlates.waterBounds(6) hd.SectorPlates.waterBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.Color; hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_ceiling.EdgeColor = 'none';
%intermediateSPD_cursedTriangle = patch([hd.SectorPlates.waterBounds(5),hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.SectorPlates.Color],3,[],3));
%intermediateSPD_cursedTriangle.EdgeColor = 'none';
intermediateSPD_cursedParallelogram = patch([101.5882 101.8739 102.2494 102.0930], [-17.6 -12.2 -12.2 -17.6],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_cursedParallelogram.EdgeColor = 'none';


mixed1 = patch(hd.Mixed.waterBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.Color);
mixed1.EdgeColor = 'none';
mixed2 = patch(hd.Mixed.waterBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.Color);
mixed2.EdgeColor = 'none';
warmerThanFreezing = patch(hd.warm.waterBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.waterBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
unnatural = patch(hd.unnatural.waterBounds,hd.unnatural.TempBounds,hd.unnatural.Color);
unnatural.EdgeColor = 'none';
%unnatural.FaceColor = 'none';
hold on

%legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 subsaturated];
legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 subsaturated]; %Disabling subsaturated to make images
%legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Subsaturated'};
legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Subsaturated wrt ice, crystal growth impossible'};

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
water_eswLineData = iceSupersatToRH(eswLineData.*100,TlineStandardC);
eswSupersatLineStandard = plot(water_eswLineData,TlineStandardC);
eswSupersatLineStandard.Color = [255 230 0]./255;
eswSupersatLineStandard.LineWidth = 3.2;

water_ventLineData = iceSupersatToRH(2*eswLineData(151:end).*100,TlineStandardC(151:end));
water_ventLine = plot(water_ventLineData,TlineStandardC(151:end));
water_ventLine.Color = [204 0 0]./255;
water_ventLine.LineWidth = 3.2;
legendEntries(end+1) = water_ventLine;
legendTexts{end+1} = 'Approximate max natural supersat (with ventilation)';

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
xLab = xlabel('Relative humidity with respect to water (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
%axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
%xTickLabels = {'100' '105' '110' '115' '120' '125' '130' '135' '140' '145' '150' '155' '160'}; %these would change if RHice to plus 100
%xticklabels(xTickLabels);
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