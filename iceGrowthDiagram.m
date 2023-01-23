function [fig,legendEntries,legendTexts] = iceGrowthDiagram( ...
    hd, isohumeFlag, bh09VentLog, legLog, legendLocStr, xlimRange, ...
    ylimRange, printFig, yRight)
%%iceGrowthDiagram
    %QUICK START: You can just run iceGrowthDiagram() to obtain the
    %diagram with all default settings!
    %
    %Function to plot an ice growth diagram in terms of relative humidity
    %with respect to ice. Returns the figure handle so further
    %modifications are possible.
    %
    %General form: [fig,legendEntries,legendTexts] = iceGrowthDiagram(hd,isohumeFlag,ventLog,legLog,legendLocStr,xlimRang,ylimRange,printFig,yRight)
    % iceGrowthDiagram() is equivalent to iceGrowthDiagram(hd,1,0,1,'southoutside',[0 0.6],[-70 0],0,1)
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
    %   increasing order (default: [0 0.6])
    %ylimRange: determines range for y-axis (in deg C), input as 2-element
    %    array in increasing order (default: [-56.5 0]).
    %printFig: 1/0 to save/not save as PNG in working directory (default: 0)
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
if ~exist('hd','var') %Instantiate structure containing all growth diagram information
    crystalLog = 1; otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog);
end
if ~exist('isohumeFlag','var')
    isohumeFlag = 1;
    disp('Isohumes enabled by default')
end
if ~exist('bh09VentLog','var')
    bh09VentLog = 0;
    disp('Bailey and Hallett ventilation approximation disabled by default')
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
    xlimRange = [0 0.6];
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
[eswLineData] = eswLine(100,Tlower,Tupper);

% The growth forms are patches with boundaries defined by the hd structure
tabular0C = patch(hd.Tabular0.supersatBounds, hd.Tabular0.TempBounds,hd.Tabular0.Color);
tabular0C.EdgeColor = 'none';
columnar = patch(hd.Columnar.supersatBounds,hd.Columnar.TempBounds,hd.Columnar.Color);
columnar.EdgeColor = 'none';
tabular8C = patch(hd.Tabular8.supersatBounds,hd.Tabular8.TempBounds,hd.Tabular8.Color);
tabular8C.EdgeColor = 'none';
tabPolycrystPt1 = patch(hd.TabPolycryst.supersatBounds(1,:),hd.TabPolycryst.TempBounds(1,:),hd.TabPolycryst.Color);
tabPolycrystPt1.EdgeColor = 'none';
tabPolycrystPt2 = patch(hd.TabPolycryst.supersatBounds(2,:),hd.TabPolycryst.TempBounds(2,:),hd.TabPolycryst.Color);
tabPolycrystPt2.EdgeColor = 'none';
colPolycrystPt1 = patch(hd.ColPolycryst.supersatBounds(1,:),hd.ColPolycryst.TempBounds(1,:),hd.ColPolycryst.Color);
colPolycrystPt1.EdgeColor = 'none';
colPolycrystPt2 = patch(hd.ColPolycryst.supersatBounds(2,:),hd.ColPolycryst.TempBounds(2,:),hd.ColPolycryst.Color);
colPolycrystPt2.EdgeColor = 'none';
branchedPt1 = patch(hd.Branched.supersatBounds(1,:),hd.Branched.TempBounds(1,:),hd.Branched.Color);
branchedPt1.EdgeColor = 'none';
branchedPt2 = patch(hd.Branched.supersatBounds(2,:),hd.Branched.TempBounds(2,:),hd.Branched.Color);
branchedPt2.EdgeColor = 'none';
branchedPt3 = patch(hd.Branched.supersatBounds(3,:),hd.Branched.TempBounds(3,:),hd.Branched.Color);
branchedPt3.EdgeColor = 'none';
sideBranched = patch(hd.SideBranched.supersatBounds,hd.SideBranched.TempBounds,hd.SideBranched.Color);
sideBranched.EdgeColor = 'none';

% The fuzzy boundaries are hand-tuned for aesthetics. If changes are made
% elsewhere in the code, these often need further manual adjustment.
% Define fuzzy boundary into tabular polycrystalline form from tabular and branched forms
intermedTabular = patch([hd.Tabular8.supersatBounds(end),hd.Tabular8.supersatBounds(end),eswLineData(351) eswLineData(371)],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.Color; hd.Tabular8.Color; hd.Tabular8.Color; hd.TabPolycryst.Color],4,[],3));
intermedTabular.EdgeColor = 'none';
intermedBranched = patch([eswLineData(351) 0.6 0.6 eswLineData(371)],[-20 -20 -22.1 -22.1],reshape([hd.Branched.Color; hd.Branched.Color; hd.TabPolycryst.Color; hd.TabPolycryst.Color],4,[],3));
intermedBranched.EdgeColor = 'none';

% Define fuzzy boundary between the branched and side branched forms
intermedBSB_floor = patch([0.15,0.16,0.43,0.4212], [hd.Branched.TempBounds(5)*0.97,-13.5,-13.5,hd.Branched.TempBounds(5)*0.99],reshape([hd.Branched.Color; hd.SideBranched.Color; hd.SideBranched.Color; hd.Branched.Color],4,[],3));
intermedBSB_floor.EdgeColor = 'none';
intermedBSB_wall = patch([0.2054,0.135,0.16,0.2121], [hd.Branched.TempBounds(3)*1.03 hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(1) hd.SideBranched.TempBounds(3)*1.01],reshape([hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color; hd.SideBranched.Color],4,[],3));
intermedBSB_wall.EdgeColor = 'none';
intermedBSB_ceiling = patch([0.21,0.2224,0.6084,0.5244], [hd.SideBranched.TempBounds(4) hd.Branched.TempBounds(11)*1.03 hd.Branched.TempBounds(11)*1.03,hd.SideBranched.TempBounds(4)],reshape([hd.SideBranched.Color; hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color],4,[],3));
intermedBSB_ceiling.EdgeColor = 'none';
intermedBSB_triangleTop = patch([0.2054,0.2224,0.21], [-18.128, -18.128, -17.1], reshape([hd.Branched.Color; hd.Branched.Color; hd.SideBranched.Color],3,[],3));
intermedBSB_triangleTop.EdgeColor = 'none';
intermedBSB_triangleBottom = patch([0.135,0.16,0.15], [-11.834,-12.7,-11.834], reshape([hd.Branched.Color; hd.SideBranched.Color; hd.Branched.Color],3,[],3));
intermedBSB_triangleBottom.EdgeColor = 'none';

% Multiple growth form must be defined here for proper layering
multiplePt1 = patch(hd.Multiple.supersatBounds(1,:),hd.Multiple.TempBounds(1,:),hd.Multiple.Color);
multiplePt1.EdgeColor = 'none';
multiplePt2 = patch(hd.Multiple.supersatBounds(2,:),hd.Multiple.TempBounds(2,:),hd.Multiple.Color);
multiplePt2.EdgeColor = 'none';

% Additional objects to allow for different user inputs
warmerThanFreezing = patch(hd.warm.supersatBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.supersatBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
if bh09VentLog %If Bailey & Hallett 2009 max ventilation approximation specified
    unnaturalVent = patch(hd.unnaturalVent.supersatBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
    unnaturalVent.EdgeColor = 'none';
else %Cut off diagram at 105% RHw (default behavior)
    unnatural105 = patch(hd.unnatural105.supersatBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
    unnatural105.EdgeColor = 'none';
end

% Define dashed edges between growth forms to indicate uncertainty in the
% exact bounding conditions. In-line comments where variables are unclear.
brdThc = 3; brdCol = [105,105,105]./255; brdSt = '--';
tabEdgeRhi = [0, (rhwToRhi(105,-4.05)/100 - 1)]; %Convert percent RHw to supersat RHi
tabEdge = line(tabEdgeRhi,[-4.05,-4.05]);
tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
colEdgeRhi = [0, rhwToRhi(105,-8.05)/100 - 1];
colEdge = line(colEdgeRhi,[-8.05,-8.05]);
colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
tabBrnchEdgeRhi = rhwToRhi(ones(1,141)*100.25, TlineStandardC(231:371))/100 - 1;
tabBrnchEdge = line(tabBrnchEdgeRhi,TlineStandardC(231:371));
tabBrnchEdge.LineWidth = brdThc; tabBrnchEdge.LineStyle = brdSt; tabBrnchEdge.Color = brdCol;
tabColPolyStrgEdgeRhi = rhwToRhi([89.8227,105],[-40.2,-40.2])/100 - 1; %Straight edge between tabular polycrystalline and columnar polycrystalline
tabColPolyStrgEdge = line(tabColPolyStrgEdgeRhi,[-40.2,-40.2]);
tabColPolyStrgEdge.LineWidth = brdThc; tabColPolyStrgEdge.LineStyle = brdSt; tabColPolyStrgEdge.Color = brdCol;
tabColPolyAngEdgeRhi = rhwToRhi([68.6524,89.8227],[-45.875,-40.2])/100 - 1; %Angled edge between tabular polycrystalline and columnar polycrystalline
tabColPolyAngEdge = line(tabColPolyAngEdgeRhi,[-45.875,-40.2]);
tabColPolyAngEdge.LineWidth = brdThc; tabColPolyAngEdge.LineStyle = brdSt; tabColPolyAngEdge.Color = brdCol;
multipleEdge1Rhi = [0.038,0.038,0.038];
multipleEdge1 = line(multipleEdge1Rhi,[-46.2,-22,-8]);
multipleEdge1.LineWidth = brdThc; multipleEdge1.LineStyle = brdSt; multipleEdge1.Color = brdCol;
multipleEdge15Rhi = rhwToRhi([66.5,68.6274],[-46.2,-45.9])/100 - 1;
multipleEdge15 = line(multipleEdge15Rhi,[-46.2,-45.9]);
multipleEdge15.LineWidth = brdThc; multipleEdge15.LineStyle = brdSt; multipleEdge15.Color = brdCol;
multipleEdge2Rhi = rhwToRhi(hd.Multiple.waterBounds(2,10:end)+0.025, hd.Multiple.TempBounds(2,10:end)+0.025)/100 - 1;
multipleEdge2 = line(multipleEdge2Rhi, hd.Multiple.TempBounds(2,10:end)+0.025);
multipleEdge2.LineWidth = brdThc; multipleEdge2.LineStyle = brdSt; multipleEdge2.Color = brdCol;

hold on

legendEntries = [tabular0C columnar branchedPt1 sideBranched tabPolycrystPt1 colPolycrystPt1 multiplePt1]; %Sans subsaturated to make images
legendTexts = {hd.Tabular0.Form,hd.Columnar.Form,hd.Branched.Form,hd.SideBranched.Form,hd.TabPolycryst.Form,hd.ColPolycryst.Form,hd.Multiple.Form};

%% Plot other lines
if isohumeFlag==1 %Draw isohumes wrt water at 10% intervals up to 100%, plus 102.5% and 105%    
    for rhwc = [90:-10:0, 100, 102.5, 105]
        actHandle = num2str(rhwc); %Handles defined dynamically
        actHandleNoPunct = actHandle(actHandle~='.');
        eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
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
else
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

yyaxis right %ICAO reference
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
xLab = xlabel('Relative humidity with respect to ice (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
xTickLabels = {'100' '105' '110' '115' '120' '125' '130' '135' '140' '145' '150' '155' '160'};
xticklabels(xTickLabels);
axe.Layer = 'top'; %Force tick marks to be displayed over patches
axe.YDir = 'reverse';

if legLog==1
    leg = legend(legendEntries,legendTexts);
    leg.Location = legendLocStr;
    leg.NumColumns = 3;
    leg.FontSize = 16;
else
    %no legend
end

set(gcf, 'PaperUnits','points','PaperPosition', [1 1 1440 849]);
set(gcf,'renderer','painters')
if printFig == 1
    saveFilename = 'igd_rhi';
    disp(['Saving figure as: ' saveFilename '.png'])
    print('-r400',saveFilename,'-dpng')
end

end