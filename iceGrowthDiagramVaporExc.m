function [fig,legendEntries,legendTexts] = iceGrowthDiagramVaporExc( ...
    hd, isohumeFlag, bh09VentLog, legLog, legendLocStr, xlimRange, ...
    ylimRange, printFig, yRight)
%%iceGrowthDiagramVaporExc
    %QUICK START: You can just run iceGrowthDiagramVaporExc() to obtain the
    %diagram with all default settings!
    %
    %Function to plot an ice growth diagram with respect to vapor density
    %excess over ice saturation. Returns the figure handle so further
    %modifications are possible.
    %
    %General form: [fig,legendEntries,legendTexts] = iceGrowthDiagramVaporExc(hd,isohumeFlag,ventLog,legLog,legendLocStr,xlimRang,ylimRange,printFig,yRight)
    % iceGrowthDiagramVaporExc() is equivalent to iceGrowthDiagramVaporExc(hd,1,0,1,'southoutside',[0 0.351],[-70 0],0,1)
    %
    %Output
    %fig: figure handle for the ice growth diagram
    %legendEntries: figure legend data, used when called by growthDiagramProfile
    %legendTexts: figure legend texts, used when called by growthDiagramProfile
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %isohumeFlag: flag for drawing lines of constant RH with respect to water.
    %    1 draws RH lines at 10% intervals from 0 to 100, and at 2.5% and
    %       5% supersaturations with respect to water
    %    2 draws only the water saturation line (RH=100%)
    %    0 and all other values don't plot any isohumes
    %   (default: 1)
    %bh09VentLog: logical 1/0 to draw the Bailey & Hallett 2009 maximum
    %   supersaturation approximation (default: 0)
    %legLog: logical 1/0 to show the legend (default: 1)
    %legendLocStr: legend location string (default: 'southoutside')
    %xlimRange: determines range for x-axis, input as 2-element array in
    %   increasing order (default: [0 0.351]) 
    %ylimRange: determines range for y-axis (in deg C), input as 2-element
    %    array in increasing order (default: [-56.5 0]).
    %printFig: 1/0 to save/not save figure as PNG (default: 0)
    %yRight: 1/0 to enable/disable right y-axis ICAO atmosphere (default: 1)
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    % Written as part of HON499: Capstone II
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
    msg = 'Must enter a habit diagram structure as first input!';
    error(msg)
end
if ~exist('hd','var')
    crystalLog = 1; otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog);
end
if ~exist('isohumeFlag','var')
    isohumeFlag = 1;
    disp('Isohumes enabled by default')
end
if ~exist('bh09VentLog','var')
    bh09VentLog = 0;
    disp('Ventilation line disabled by default')
end
if ~exist('legLog','var')
    legLog = 1;
    disp('Legend enabled by default')
end
if ~exist('legendLocStr','var')
    legendLocStr = 'southoutside';
    disp('Legend location defaults to below the diagram');
end
if ~exist('xlimRange','var')
    if bh09VentLog
        xlimRange = [0 0.5];
    else
        xlimRange = [0 0.351];
    end
    disp('Default ice supersaturation range for x-axis is 0 to 60%')
end
if ~exist('ylimRange','var')
    ylimRange = [-70 0];
    disp(['Default temperature range for y-axis is -70 to 0' char(176) 'C'])
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
[eswLineData] = eswLine(100, Tlower, Tupper);
[eswLineData] = iceSupersatToVaporExc(eswLineData, TlineStandardC);

% The growth forms are patches with boundaries defined by the hd structure
tabular0C = patch(hd.Tabular0.vaporExcBounds, hd.Tabular0.TempBounds, hd.Tabular0.Color);
tabular0C.EdgeColor = 'none';
columnar = patch(hd.Columnar.vaporExcBounds,hd.Columnar.TempBounds,hd.Columnar.Color);
columnar.EdgeColor = 'none';
tabPolycrystPt1 = patch(hd.TabPolycryst.vaporExcBounds(1,:),hd.TabPolycryst.TempBounds(1,:),hd.TabPolycryst.Color);
tabPolycrystPt1.EdgeColor = 'none';
tabPolycrystPt2 = patch(hd.TabPolycryst.vaporExcBounds(2,:),hd.TabPolycryst.TempBounds(2,:),hd.TabPolycryst.Color);
tabPolycrystPt2.EdgeColor = 'none';
colPolycrystPt1 = patch(hd.ColPolycryst.vaporExcBounds(1,:),hd.ColPolycryst.TempBounds(1,:),hd.ColPolycryst.Color);
colPolycrystPt1.EdgeColor = 'none';
colPolycrystPt2 = patch(hd.ColPolycryst.vaporExcBounds(2,:),hd.ColPolycryst.TempBounds(2,:),hd.ColPolycryst.Color);
colPolycrystPt2.EdgeColor = 'none';
branchedPt1 = patch(hd.Branched.vaporExcBounds(1,:),hd.Branched.TempBounds(1,:),hd.Branched.Color);
branchedPt1.EdgeColor = 'none';
branchedPt2 = patch(hd.Branched.vaporExcBounds(2,:),hd.Branched.TempBounds(2,:),hd.Branched.Color);
branchedPt2.EdgeColor = 'none';
branchedPt3 = patch(hd.Branched.vaporExcBounds(3,:),hd.Branched.TempBounds(3,:),hd.Branched.Color);
branchedPt3.EdgeColor = 'none';
sideBranched = patch(hd.SideBranched.vaporExcBounds,hd.SideBranched.TempBounds,hd.SideBranched.Color);
sideBranched.EdgeColor = 'none';
tabular8C = patch(hd.Tabular8.vaporExcBounds,hd.Tabular8.TempBounds,hd.Tabular8.Color);
tabular8C.EdgeColor = 'none';

% The fuzzy boundaries are hand-tuned for aesthetics. If changes are made
% elsewhere in the code, these often need further manual adjustment.
% Define fuzzy boundary into tabular polycrystalline form from tabular and branched forms
intermedTabular = patch([hd.Tabular8.vaporExcBounds(end),hd.Tabular8.vaporExcBounds(end)-3,eswLineData(351),eswLineData(371)],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.Color; hd.Tabular8.Color; hd.Tabular8.Color; hd.TabPolycryst.Color],4,[],3));
intermedTabular.EdgeColor = 'none';
intermedBrnchd = patch([eswLineData(351) 0.9113 0.9113 eswLineData(371)],[-20 -20 -22.1 -22.1],reshape([hd.Branched.Color; hd.Branched.Color; hd.TabPolycryst.Color; hd.TabPolycryst.Color],4,[],3));
intermedBrnchd.EdgeColor = 'none';

% Define fuzzy boundary between the branched and side branched forms
intermedBSB_floor = patch([0.2742,0.2713,0.729,0.7536], [hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(2) hd.SideBranched.TempBounds(2),hd.Branched.TempBounds(5)*0.99],reshape([hd.Branched.Color; hd.SideBranched.Color; hd.SideBranched.Color; hd.Branched.Color],4,[],3));
intermedBSB_floor.EdgeColor = 'none';
intermedBSB_wall = patch([0.2202,0.256,0.2713,0.241], [hd.Branched.TempBounds(3)*1.03 hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(1) hd.SideBranched.TempBounds(3)*1.01],reshape([hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color; hd.SideBranched.Color],4,[],3));
intermedBSB_wall.EdgeColor = 'none';
intermedBSB_ceiling = patch([0.2413,0.2329,0.6372,0.6026], [hd.SideBranched.TempBounds(4) hd.Branched.TempBounds(11)*1.03 hd.Branched.TempBounds(11)*1.03,hd.SideBranched.TempBounds(4)],reshape([hd.SideBranched.Color; hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color],4,[],3));
intermedBSB_ceiling.EdgeColor = 'none';
intermedBSB_triangleTop = patch([0.2202,0.2329,0.2413], [-18.128, -18.128, -17.1], reshape([hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color],3,[],3));
intermedBSB_triangleTop.EdgeColor = 'none';
intermedBSB_triangleBottom = patch([0.2560,0.2713,0.2742], [-11.834,-12.7,-11.834], reshape([hd.Branched.Color; hd.SideBranched.Color; hd.Branched.Color],3,[],3));
intermedBSB_triangleBottom.EdgeColor = 'none';

% Multiple growth form must be defined here for proper layering
multiplePt1 = patch(hd.Multiple.vaporExcBounds(1,:),hd.Multiple.TempBounds(1,:),hd.Multiple.Color);
multiplePt1.EdgeColor = 'none';
multiplePt2 = patch(hd.Multiple.vaporExcBounds(2,:),hd.Multiple.TempBounds(2,:),hd.Multiple.Color);
multiplePt2.EdgeColor = 'none';

% Additional objects to allow for different user inputs
warmerThanFreezing = patch(hd.warm.vaporExcBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.vaporExcBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
if bh09VentLog %If Bailey & Hallett 2009 max ventilation approximation specified
    unnaturalVent = patch(hd.unnaturalVent.vaporExcBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
    unnaturalVent.EdgeColor = 'none';
else %Cut off diagram at 105% RHw (default behavior)
    unnatural105 = patch(hd.unnatural105.vaporExcBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
    unnatural105.EdgeColor = 'none';
end

% Define dashed edges between growth forms to indicate uncertainty in the
% exact bounding conditions. In-line comments where variables are unclear.
brdThc = 3; brdCol = [105,105,105]./255; brdSt = '--';
tabEdgeVde = rhwToVaporExc([iceSupersatToRH(0,-4.05),105],[-4.05,-4.05]);
tabEdge = line(tabEdgeVde,[-4.05,-4.05]);
tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
colEdgeVde = rhwToVaporExc([iceSupersatToRH(0,-8.05),105],[-8.05,-8.05]);
colEdge = line(colEdgeVde,[-8.05,-8.05]);
colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
tabBrnchEdgeVde = rhwToVaporExc(ones(1,141)*100.05, TlineStandardC(231:371));
tabBrnchEdge = line(tabBrnchEdgeVde,TlineStandardC(231:371));
tabBrnchEdge.LineWidth = brdThc; tabBrnchEdge.LineStyle = brdSt; tabBrnchEdge.Color = brdCol;
tabColPolyStrgEdgeVde = rhwToVaporExc([89.8227,105],[-40.2,-40.2]); %"Straight" edge (in RHice-space) between tabular polycrystalline and columnar polycrystalline
tabColPolyStrgEdge = line(tabColPolyStrgEdgeVde,[-40.2,-40.2]);
tabColPolyStrgEdge.LineWidth = brdThc; tabColPolyStrgEdge.LineStyle = brdSt; tabColPolyStrgEdge.Color = brdCol;
tabColPolyAngEdgeVde = rhwToVaporExc([68.6524,89.8227],[-45.875,-40.2]); %"Angled" edge (in RHice-space) between tabular polycrystalline and columnar polycrystalline
tabColPolyAngEdge = line(tabColPolyAngEdgeVde,[-45.875,-40.2]);
tabColPolyAngEdge.LineWidth = brdThc; tabColPolyAngEdge.LineStyle = brdSt; tabColPolyAngEdge.Color = brdCol;
multipleEdge1Vde = rhwToVaporExc([66.5,83.4409,95.8841],[-46.2,-22,-8]);
multipleEdge1 = line(multipleEdge1Vde,[-46.2,-22,-8]);
multipleEdge1.LineWidth = brdThc; multipleEdge1.LineStyle = brdSt; multipleEdge1.Color = brdCol;
multipleEdge15Vde = rhwToVaporExc([66.5,68.6274],[-46.2,-45.9]);
multipleEdge15 = line(multipleEdge15Vde,[-46.2,-45.9]);
multipleEdge15.LineWidth = brdThc; multipleEdge15.LineStyle = brdSt; multipleEdge15.Color = brdCol;
multipleEdge2Vde = rhwToVaporExc(hd.Multiple.waterBounds(2,10:end)+0.025, hd.Multiple.TempBounds(2,10:end)+0.025);
multipleEdge2 = line(multipleEdge2Vde, hd.Multiple.TempBounds(2,10:end)+0.025);
multipleEdge2.LineWidth = brdThc; multipleEdge2.LineStyle = brdSt; multipleEdge2.Color = brdCol;

hold on

legendEntries = [tabular0C columnar branchedPt1 sideBranched tabPolycrystPt1 colPolycrystPt1 multiplePt1 subsaturated];
legendTexts = {hd.Tabular0.Form,hd.Columnar.Form,hd.Branched.Form,hd.SideBranched.Form,hd.TabPolycryst.Form,hd.ColPolycryst.Form,hd.Multiple.Form,'Subsaturated wrt ice, no crystal growth'};

%% Plot other lines
if isohumeFlag==1 %Draw isohumes wrt water at 10% intervals up to 100%, plus 102.5% and 105%
    for rhwc = [90:-10:0, 100, 102.5, 105]
        actHandle = num2str(rhwc); %Handles defined dynamically
        actHandleNoPunct = actHandle(actHandle~='.');
        eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
        eswLine_Handles.(['p', actHandleNoPunct, 'Vde']) = iceSupersatToVaporExc(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde']),TlineStandardC);
        if rhwc>100
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
        elseif rhwc == 100
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-';
        else
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
        end
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [255/255 230/255 0 0.8];
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 3.2;
    end
    
    legendEntries(end+1) = eswLine_Handles.p100Plot;
    legendEntries(end+1) = eswLine_Handles.p90Plot;
    legendEntries(end+1) = eswLine_Handles.p105Plot;
    legendTexts{end+1} = 'RH_w = 100%';
    legendTexts{end+1} = 'RH_w (10% intervals)';
    legendTexts{end+1} = 'RH_w (102.5%, 105%)';
 
elseif isohumeFlag==2 %Draw 100% RHw isohume only
    Tupper = 15; Tlower = -70;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
    eswSupersatLineStandard.Color = [255 230 0]./255;
    eswSupersatLineStandard.LineWidth = 3.2;
    
    legendEntries(end+1) = eswSupersatLineStandard;
    legendTexts{end+1} = 'Water saturation line (T_{ice} = T_{air})';
else %do nothing, don't plot isohumes
    disp('Isohumes disabled')
end

if bh09VentLog==1 % Bailey and Hallett 2009 maximum supersaturation with ventilation approximation
    maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
    maxVentLine.Color = [0 26 255]./255;
    maxVentLine.LineWidth = 3.2;
    
    legendEntries(end+1) = maxVentLine;
    legendTexts{end+1} = 'Approximate max natural supersat (with ventilation)';
end

%% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 20;

yyaxis right
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
xLab = xlabel('Vapor density excess (gm^{-3})');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
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
    saveFilename = 'igd_vde';
    disp(['Saving figure as: ' saveFilename '.png'])
    saveas(gcf,saveFilename,'png');
end

end