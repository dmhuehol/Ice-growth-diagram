function [fig,legendEntries,legendTexts] = iceGrowthDiagramWater(hd,ventLog,legLog,legendLocStr,xlimRange,ylimRange,printFig,yRight)
%%iceGrowthDiagramWater
    %Function to plot an ice growth diagram in terms of relative humidity
    %with respect to water. This is the version of the diagram highlighted
    %in the submitted paper this code accompanies, tentatively:
    % Hueholt, D.M., Yuter, S.E., and M.A. Miller, submit 2020/revised 2022:
    % Revisiting Diagrams of Ice Growth Environments, Bulletin of the American
    % Meteorological Society.
    %
    %We strongly recommend this diagram in educational and research
    %contexts outside of specific applications where the relative humidity
    %with respect to ice or vapor density excess versions are necessary.
    %
    %General form: [fig,legendEntries,legendTexts] = iceGrowthDiagram(hd,ventLog,legLog,legendLocStr,xlimRange,ylimRange,printFig,yRight)
    % iceGrowthDiagram() is equivalent to iceGrowthDiagramWater(hd,0,1,'southoutside',[55 105],[-70 0],0,1)
    %
    %Output
    %fig: figure handle for the ice growth diagram
    %legendEntries: figure legend data, used when called by growthDiagramProfile
    %legendTexts: figure legend texts, used when called by growthDiagramProfile
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %ventLog: logical 1/0 to show ventilation
    %legLog: logical 1/0 to show the legend
    %legendLocStr: legend location string ('southoutside' is default)
    %xlimRange: determines the range for the x-axis, input as 2-element array (i.e. [55 124])
    %ylimRange: determines range for the y-axis (in deg C), input as
    %   2-element array in increasing order (i.e. [-56.5 0]). Minimum
    %   temperature cannot be less than -70 degrees Celsius.
    %printFig: 1/0 to save/not save figure as PNG (0 by default)
    %yRight: 1/0 to enable/disable right y-axis (ICAO atmosphere, 1 by default)
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Edits made as part of HON499: Capstone II
    %Version date: 6/2/2022
    %Last major revision: 6/1/2022
    %
    %See also makeGrowthDiagramStruct
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
        disp('Default RHwater range for x-axis is 55 to 105%')
    end    
end
if ~exist('ylimRange','var')
    ylimRange = [-70 0];
    disp(['Default temperature range for y-axis is -70 to 0' char(176) 'C'])
end
if legendLocStr == 0
    legendLocStr = 'none';
end
if ~exist('printFig','var')
    printFig = 0;
end
if ~exist('yRight','var')
    yRight = 1;
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

intermediatePlatesP = patch([83.4409,hd.VariousPlates.waterBounds(end)-3,100 100],[-22.1 -20 -20 -22.1],reshape([hd.PolycrystalsP.Color; hd.VariousPlates.Color; hd.VariousPlates.Color; hd.PolycrystalsP.Color],4,[],3));
intermediatePlatesP.EdgeColor = 'none';
intermediateSectorP = patch([100 100 200 200],[-22.1 -20 -20 -22.1],reshape([hd.PolycrystalsP.Color; hd.SectorPlates.Color; hd.SectorPlates.Color; hd.PolycrystalsP.Color],4,[],3));
intermediateSectorP.EdgeColor = 'none';

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
mixed1.EdgeColor = hd.Mixed.Color;
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

brdThc = 3; brdCol = [105,105,105]./255; brdSt = '--';
tabEdge = line([iceSupersatToRH(0,-4.05),105],[-4.05,-4.05]);
tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
colEdge = line([iceSupersatToRH(0,-8.05),105],[-8.05,-8.05]);
colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
varEdge = line([100.1,100.1],[-8,-22]);
varEdge.LineWidth = brdThc; varEdge.LineStyle = brdSt; varEdge.Color = brdCol;
polyBorderStrg = line([89.8227,105],[-40.2,-40.2]);
polyBorderStrg.LineWidth = brdThc; polyBorderStrg.LineStyle = brdSt; polyBorderStrg.Color = brdCol;
polyBorderAng = line([68.6524,89.8227],[-45.875,-40.2]);
polyBorderAng.LineWidth = brdThc; polyBorderAng.LineStyle = brdSt; polyBorderAng.Color = brdCol;
mixedEdge1 = line([66.5,83.4409,95.8841],[-46.2,-22,-8]);
mixedEdge1.LineWidth = brdThc; mixedEdge1.LineStyle = brdSt; mixedEdge1.Color = brdCol;
mixedEdge15 = line([66.5,68.6274],[-46.2,-45.9]);
mixedEdge15.LineWidth = brdThc; mixedEdge15.LineStyle = brdSt; mixedEdge15.Color = brdCol;
mixedEdge2 = line(hd.Mixed.waterBounds(2,5:end)+0.025, hd.Mixed.TempBounds(2,5:end)+0.025);
mixedEdge2.LineWidth = brdThc; mixedEdge2.LineStyle = brdSt; mixedEdge2.Color = brdCol;

hold on

legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 subsaturated];
legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Subsaturated wrt ice, no crystal growth'};

%% Plot other lines
for rhwc = [90:-10:0, 100, 102.5, 105]
    actHandle = num2str(rhwc);
    actHandleNoPunct = actHandle(actHandle~='.');
    eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot([rhwc rhwc],[-70,0]);
    if rhwc >= 100
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
    else
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
    end
    eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [255/255 230/255 0 0.8];
    eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 3.2;
end
legendEntries(end+1) = eswLine_Handles.p90Plot;
legendEntries(end+1) = eswLine_Handles.p105Plot;
legendTexts{end+1} = 'RH_w (10% intervals)';
legendTexts{end+1} = 'RH_w (100%, 102.5%, 105%)';

for rhic = 60:-10:-100 %-100% ice supersaturation = 0% ice saturation
    if rhic > 0
        actRhiHandle = num2str(rhic);
    else
        actRhiHandle = ['sub',num2str(abs(rhic))];
    end
    esiLine_Handles.(['p', actRhiHandle, 'Num']) = iceSupersatToRH(rhic,TlineStandardC);
    esiLine_Handles.(['p', actRhiHandle, 'Plot']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num']),TlineStandardC);
    esiLine_Handles.(['p', actRhiHandle, 'Plot']).Color = [255/255 230/255 0 0.8];
    esiLine_Handles.(['p', actRhiHandle, 'Plot']).LineWidth = 3.2;
end

legendEntries(end+1) = esiLine_Handles.p60Plot;
legendTexts{end+1} = 'RH_{ice} (10% intervals, 60% min, 160% max)';

%% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 20;

yyaxis right %Add ICAO reference atmosphere
if yRight == 1
    [zLabels, tempsInRange, rightLimits, icaoAxLabel] = ylimitsForIceDiagram(ylimRange);
    axe.YTick = tempsInRange;
    yticklabels(zLabels);
    ylim(rightLimits)
    axe.Layer = 'top';
    yLab = ylabel(icaoAxLabel);
    yLab.FontName = 'Lato Bold';
else
    yticks([])
end

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
    axe.XTick = [50 55 60 65 70 75 80 85 90 95 100 105];
end
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
axe.YDir = 'reverse';

if legLog == 1
    leg = legend(legendEntries,legendTexts);
    leg.Location = legendLocStr;
    leg.NumColumns = 3;
    leg.FontSize = 16;
else
    %no legend
end

set(gcf, 'PaperUnits','points','PaperPosition', [1 1 1440 849]);
set(gcf,'renderer','Painters')
if printFig == 1
    saveFilename = 'igd_rhw';
    disp(['Saving figure as: ' saveFilename '.png'])
    saveas(gcf,saveFilename,'png');
end

end