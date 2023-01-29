function [fig,legendEntries,legendTexts] = iceGrowthDiagramWater( ...
    hd, bh09VentLog, legLog, legendLocStr, xlimRange, ylimRange, printFig, ...
    yRight)
%%iceGrowthDiagramWater
    %QUICK START: You can just run iceGrowthDiagramWater() to obtain the
    %diagram with all default settings!
    %
    %Function to plot an ice growth diagram in terms of relative humidity
    %with respect to water. This is the version of the diagram highlighted
    %in the paper this code accompanies:
    % Hueholt, D.M., Yuter, S.E., and M.A. Miller, 2022: Revisiting
    % Diagrams of Ice Growth Environments, Bulletin of the American
    % Meteorological Society, doi.org/10.1175/BAMS-D-21-0271.1.
    %
    %We recommend this diagram in educational contexts outside of specific
    %applications where the relative humidity with respect to ice or vapor
    %density excess versions are necessary. Additionally, this diagram
    %simplifies radiosonde data plotting.
    %
    %General form: [fig,legendEntries,legendTexts] = iceGrowthDiagramWater(hd,bh09VentLog,legLog,legendLocStr,xlimRange,ylimRange,printFig,yRight)
    % iceGrowthDiagramWater() is equivalent to iceGrowthDiagramWater(hd,0,1,'southoutside',[55 105],[-70 0],0,1)
    %
    %Output
    %fig: figure handle for the ice growth diagram
    %legendEntries: figure legend data, used when called by growthDiagramProfile
    %legendTexts: figure legend texts, used when called by growthDiagramProfile
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %bh09VentLog: logical 1/0 to draw the Bailey & Hallett 2009 maximum
    %   supersaturation approximation (default: 0)
    %legLog: logical 1/0 to show the legend (default: 1)
    %legendLocStr: legend location string (default: 'southoutside')
    %xlimRange: determines the range for the x-axis, input as 2-element
    %   array in increasing order (default: [55 105])
    %ylimRange: determines range for the y-axis (in deg C), input as
    %   2-element array in increasing order (default: [-70 0])
    %printFig: 1/0 to save/not save figure as PNG (default: 0)
    %yRight: 1/0 to enable/disable right y-axis ICAO atmosphere (default: 1)
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Edits made as part of HON499: Capstone II
    %Version date: 1/2023
    %Last major revision: 1/2023
    %
    %See also makeGrowthDiagramStruct
    %

%% Check variables
if nargin == 0 %Instantiate structure containing all growth diagram information
    disp('Creating default ice diagram!')
    crystalLog = 1;
    otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog);
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
if ~exist('bh09VentLog','var')
    bh09VentLog = 0;
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
    if bh09VentLog
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

%% Draw the growth forms
Tupper = 15; Tlower = -70;
TlineStandardC = Tupper:-0.1:Tlower;

% The growth forms are patches with boundaries defined by the hd structure
tabular0C = patch(hd.Tabular0.waterBounds, hd.Tabular0.TempBounds, hd.Tabular0.Color);
tabular0C.EdgeColor = 'none';
columnar = patch(hd.Columnar.waterBounds,hd.Columnar.TempBounds,hd.Columnar.Color);
columnar.EdgeColor = 'none';
tabular8C = patch(hd.Tabular8.waterBounds,hd.Tabular8.TempBounds,hd.Tabular8.Color);
tabular8C.EdgeColor = 'none';
tabPolycrystPt1 = patch(hd.TabPolycryst.waterBounds(1,:),hd.TabPolycryst.TempBounds(1,:),hd.TabPolycryst.Color);
tabPolycrystPt1.EdgeColor = 'none';
tabPolycrystPt2 = patch(hd.TabPolycryst.waterBounds(2,:),hd.TabPolycryst.TempBounds(2,:),hd.TabPolycryst.Color);
tabPolycrystPt2.EdgeColor = 'none';
colPolycrystPt1 = patch(hd.ColPolycryst.waterBounds(1,:),hd.ColPolycryst.TempBounds(1,:),hd.ColPolycryst.Color);
colPolycrystPt1.EdgeColor = 'none';
colPolycrystPt2 = patch(hd.ColPolycryst.waterBounds(2,:),hd.ColPolycryst.TempBounds(2,:),hd.ColPolycryst.Color);
colPolycrystPt2.EdgeColor = 'none';
branchedPt1 = patch(hd.Branched.waterBounds(1,:),hd.Branched.TempBounds(1,:),hd.Branched.Color);
branchedPt1.EdgeColor = 'none';
branchedPt2 = patch(hd.Branched.waterBounds(2,:),hd.Branched.TempBounds(2,:),hd.Branched.Color);
branchedPt2.EdgeColor = 'none';
branchedPt3 = patch(hd.Branched.waterBounds(3,:),hd.Branched.TempBounds(3,:),hd.Branched.Color);
branchedPt3.EdgeColor = 'none';
sideBranched = patch(hd.SideBranched.waterBounds,hd.SideBranched.TempBounds,hd.SideBranched.Color);
sideBranched.EdgeColor = 'none';

% The fuzzy boundaries are hand-tuned for aesthetics. If changes are made
% elsewhere in the code, these often need further manual adjustment.
% Define fuzzy boundary into tabular polycrystalline form from tabular and branched forms
intermedTabular = patch([83.4409,hd.Tabular8.waterBounds(end)-3,100 100],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.Color; hd.Tabular8.Color; hd.Tabular8.Color; hd.TabPolycryst.Color],4,[],3));
intermedTabular.EdgeColor = 'none';
intermedBranched = patch([100 100 200 200],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.Color; hd.Branched.Color; hd.Branched.Color; hd.TabPolycryst.Color],4,[],3));
intermedBranched.EdgeColor = 'none';

% Define fuzzy boundary between the branched and side branched forms
intermedBSB_floor = patch([hd.SideBranched.waterBounds(1),hd.SideBranched.waterBounds(1) hd.SideBranched.waterBounds(2) hd.SideBranched.waterBounds(2)], [hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(2) hd.SideBranched.TempBounds(2),hd.Branched.TempBounds(5)*0.99],reshape([hd.Branched.Color; hd.SideBranched.Color; hd.SideBranched.Color; hd.Branched.Color],4,[],3));
intermedBSB_floor.EdgeColor = 'none';
intermedBSB_wall = patch([hd.Branched.waterBounds(2,3)*0.995 hd.Branched.waterBounds(2,2)*0.995 hd.SideBranched.waterBounds(1) hd.SideBranched.waterBounds(4)], [hd.Branched.TempBounds(3)*1.03 hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(1) hd.SideBranched.TempBounds(3)*1.01],reshape([hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color; hd.SideBranched.Color],4,[],3));
intermedBSB_wall.EdgeColor = 'none';
intermedBSB_ceiling = patch([hd.SideBranched.waterBounds(4),hd.SideBranched.waterBounds(4) hd.Branched.waterBounds(6) hd.Branched.waterBounds(9)], [hd.SideBranched.TempBounds(4) hd.Branched.TempBounds(11)*1.03 hd.Branched.TempBounds(11)*1.03,hd.SideBranched.TempBounds(4)],reshape([hd.SideBranched.Color; hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color],4,[],3));
intermedBSB_ceiling.EdgeColor = 'none';
intermedBSB_triangleTop = patch([101.08, 102.093, 102.093], [-18.128, -18.128, -17.1], reshape([hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color],3,[],3));
intermedBSB_triangleTop.EdgeColor = 'none';
intermedBSB_triangleBottom = patch([101.365,102.249,102.249], [-11.834,-12.7,-11.834], reshape([hd.Branched.Color; hd.SideBranched.Color; hd.Branched.Color],3,[],3));
intermedBSB_triangleBottom.EdgeColor = 'none';

% Multiple growth form must be defined here for proper layering
multiplePt1 = patch(hd.Multiple.waterBounds(1,:),hd.Multiple.TempBounds(1,:),hd.Multiple.Color);
multiplePt1.EdgeColor = hd.Multiple.Color;
multiplePt2 = patch(hd.Multiple.waterBounds(2,:),hd.Multiple.TempBounds(2,:),hd.Multiple.Color);
multiplePt2.EdgeColor = 'none';

% Additional objects to allow for different user inputs
warmerThanFreezing = patch(hd.warm.waterBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.waterBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
if bh09VentLog %If Bailey & Hallett 2009 max ventilation approximation specified
    unnaturalVent = patch(hd.unnaturalVent.waterBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
    unnaturalVent.EdgeColor = 'none';
else %Cut off diagram at 105% RHw (default behavior)
    unnatural105 = patch(hd.unnatural105.waterBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
    unnatural105.EdgeColor = 'none';
end

% Define dashed edges between growth forms to indicate uncertainty in the
% exact bounding conditions. In-line comments where variables are unclear.
brdThc = 3; brdCol = [105,105,105]./255; brdSt = '--';
tabEdge = line([iceSupersatToRHw(0,-4.05),105],[-4.05,-4.05]);
tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
colEdge = line([iceSupersatToRHw(0,-8.05),105],[-8.05,-8.05]);
colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
tabBrnchEdge = line([100.1,100.1],[-8,-22]); %Physically at 100, negligibly displaced for visual clarity: 100.1 normally, 100.04 for Figure 7
tabBrnchEdge.LineWidth = brdThc; tabBrnchEdge.LineStyle = brdSt; tabBrnchEdge.Color = brdCol;
tabColPolyStrgEdge = line([89.8227,105],[-40.2,-40.2]); %"Straight" edge between tabular polycrystalline and columnar polycrystalline
tabColPolyStrgEdge.LineWidth = brdThc; tabColPolyStrgEdge.LineStyle = brdSt; tabColPolyStrgEdge.Color = brdCol;
tabColPolyAngEdge = line([68.6524,89.8227],[-45.875,-40.2]); %"Angled" edge between tabular polycrystalline and columnar polycrystalline
tabColPolyAngEdge.LineWidth = brdThc; tabColPolyAngEdge.LineStyle = brdSt; tabColPolyAngEdge.Color = brdCol;
multipleEdge1 = line([66.5,83.4409,95.8841],[-46.2,-22,-8]);
multipleEdge1.LineWidth = brdThc; multipleEdge1.LineStyle = brdSt; multipleEdge1.Color = brdCol;
multipleEdge15 = line([66.5,68.6274],[-46.2,-45.9]);
multipleEdge15.LineWidth = brdThc; multipleEdge15.LineStyle = brdSt; multipleEdge15.Color = brdCol;
multipleEdge2 = line(hd.Multiple.waterBounds(2,5:end)+0.025, hd.Multiple.TempBounds(2,5:end)+0.025);
multipleEdge2.LineWidth = brdThc; multipleEdge2.LineStyle = brdSt; multipleEdge2.Color = brdCol;

hold on

legendEntries = [tabular0C columnar branchedPt1 sideBranched tabPolycrystPt1 colPolycrystPt1 multiplePt1 subsaturated];
legendTexts = {hd.Tabular0.Form,hd.Columnar.Form,hd.Branched.Form,hd.SideBranched.Form,hd.TabPolycryst.Form,hd.ColPolycryst.Form,hd.Multiple.Form,'Subsaturated wrt ice, no crystal growth'};

%% Plot other lines
for rhwc = [90:-10:0, 100, 102.5, 105]
    actHandle = num2str(rhwc); %Dynamically define handles
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
    esiLine_Handles.(['p', actRhiHandle, 'Num']) = iceSupersatToRHw(rhic,TlineStandardC);
    esiLine_Handles.(['p', actRhiHandle, 'Plot']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num']),TlineStandardC);
    esiLine_Handles.(['p', actRhiHandle, 'Plot']).Color = [255/255 230/255 0 0.8];
    esiLine_Handles.(['p', actRhiHandle, 'Plot']).LineWidth = 3.2;
end

if bh09VentLog==1 % Bailey and Hallett 2009 maximum supersaturation with ventilation approximation
    [eswLineData] = eswLine(100,Tlower,Tupper);
    maxVentValuesInRH = iceSupersatToRHw(2.*eswLineData(151:end)*100,TlineStandardC(151:end));
    maxVentLine = plot(maxVentValuesInRH,TlineStandardC(151:end));
    maxVentLine.Color = [0 26 255]./255;
    maxVentLine.LineWidth = 3.2;
    
    legendEntries(end+1) = maxVentLine;
    legendTexts{end+1} = 'Approximate max natural supersat (with ventilation)';
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
if bh09VentLog
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