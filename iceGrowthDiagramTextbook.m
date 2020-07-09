%% iceGrowthDiagramTextbook
% This code produces textbook-quality ice growth diagrams in terms of
% relative humidity with respect to water, relative humidity with respect to
% ice, and vapor density excess.
%
% General form: call iceGrowthDiagramTextbook at command window. The user
% will be provided with an input prompt.
%
% iceGrowthDiagramTextbook is designed to be replicable, not flexible. The
% figure drawing is accomplished through a thicket of hardcoding in order
% to make the appropriate on-figure labels, colors, etc. The code is
% sectioned off by the moisture variables in a switch/case block. A very
% limited selection of parameters are modifiable and are described at the
% start of their respective sections. 
%
% For flexible code that produces the high-contrast applied ice growth
% diagram, see iceGrowthDiagram, iceGrowthDiagramWater, and
% iceGrowthDiagramVaporExc. To create ice growth profiles from soundings
% data, see growthDiagramProfile.
%
%Written by: Daniel Hueholt
%North Carolina State University
%Research Assistant at Environment Analytics
%Version date: 7/7/2020
%Last major revision: 7/7/2020
%
%Based on concept art originally made in Adobe Illustrator by Dr. Matthew
%Miller, Senior Research Scholar at Environment Analytics.
%

function [] = iceGrowthDiagramTextbook()
%% Input
disp('Welcome to the textbook ice growth diagram generator!')
possibleVarPrompt = ['Enter ''water'' to plot in terms of relative humidity with respect to water',...
                     '\nEnter ''ice'' to plot in terms of relative humidity with respect to ice',...
                     '\nEnter ''vde'' to plot in terms of vapor density excess\n'];
castInTermsOf = input(possibleVarPrompt);

if ~isstring(castInTermsOf)
    castInTermsOf = string(castInTermsOf);
end

%% Universal
[hd] = makeGrowthDiagramStruct(1,1);
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

switch castInTermsOf
    case "water"
        %% Ice growth diagram in terms of relative humidity with respect to water
        % Modifiable variables
        xlimRange = [55 105];
        ylimRange = [-56.5 0];
        
        % Draw the growth modes
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        
        plates = patch(hd.Plates.waterBounds, hd.Plates.TempBounds, hd.Plates.TextbookColor);
        plates.EdgeColor = 'none';
        columnlike = patch(hd.ColumnLike.waterBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.TextbookColor);
        columnlike.EdgeColor = 'none';
        variousplates = patch(hd.VariousPlates.waterBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.TextbookColor);
        variousplates.EdgeColor = 'none';
        polycrystalsP1 = patch(hd.PolycrystalsP.waterBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP1.EdgeColor = 'none';
        polycrystalsP2 = patch(hd.PolycrystalsP.waterBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP2.EdgeColor = 'none';
        polycrystalsC1 = patch(hd.PolycrystalsC.waterBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC1.EdgeColor = 'none';
        polycrystalsC2 = patch(hd.PolycrystalsC.waterBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC2.EdgeColor = 'none';
        sectorplates1 = patch(hd.SectorPlates.waterBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.TextbookColor);
        sectorplates1.EdgeColor = 'none';
        sectorplates2 = patch(hd.SectorPlates.waterBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.TextbookColor);
        sectorplates2.EdgeColor = 'none';
        sectorplates3 = patch(hd.SectorPlates.waterBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.TextbookColor);
        sectorplates3.EdgeColor = 'none';
        dendrites = patch(hd.Dendrites.waterBounds,hd.Dendrites.TempBounds,hd.Dendrites.TextbookColor);
        dendrites.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.Dendrites.waterBounds(1),hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(2) hd.Dendrites.waterBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.waterBounds(2,3) hd.SectorPlates.waterBounds(2,2) hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(4)], [hd.SectorPlates.TempBounds(3) hd.SectorPlates.TempBounds(2) hd.Dendrites.TempBounds(1) hd.Dendrites.TempBounds(3)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.waterBounds(4),hd.Dendrites.waterBounds(4) hd.SectorPlates.waterBounds(6) hd.SectorPlates.waterBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([hd.SectorPlates.waterBounds(2,3) hd.Dendrites.waterBounds(4) hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(3) hd.Dendrites.TempBounds(3) hd.SectorPlates.TempBounds(3)], reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([hd.SectorPlates.waterBounds(2,2), hd.Dendrites.waterBounds(1), hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(2), hd.Dendrites.TempBounds(1), hd.SectorPlates.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';
        
        mixed1 = patch(hd.Mixed.waterBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.TextbookColor);
        mixed1.EdgeColor = 'none';
        
        mixed2 = patch(hd.Mixed.waterBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.TextbookColor);
        mixed2.EdgeColor = 'none';
        warmerThanFreezing = patch(hd.warm.waterBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
        warmerThanFreezing.EdgeColor = 'none';
        subsaturated = patch(hd.subsaturated.waterBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
        subsaturated.EdgeColor = 'none';
        %unnaturalVent = patch(hd.unnaturalVent.waterBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
        %unnaturalVent.EdgeColor = 'none';
        unnatural105 = patch(hd.unnatural105.waterBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
        unnatural105.EdgeColor = 'none';
        hold on
        
        % Plot other lines
        esw50LineStandard = plot([50 50],[-70 0]);
        esw50LineStandard.Color = [144 143 143]./255;
        esw50LineStandard.LineWidth = 0.5;
        esw50LineStandard.LineStyle = '--';
        
        esw60LineStandard = plot([60 60],[-70 0]);
        esw60LineStandard.Color = [144 143 143]./255;
        esw60LineStandard.LineWidth = 0.5;
        esw60LineStandard.LineStyle = '--';
        
        esw70LineStandard = plot([70 70],[-70 0]);
        esw70LineStandard.Color = [144 143 143]./255;
        esw70LineStandard.LineWidth = 0.5;
        esw70LineStandard.LineStyle = '--';
        
        esw80LineStandard = plot([80 80],[-70 0]);
        esw80LineStandard.Color = [144 143 143]./255;
        esw80LineStandard.LineWidth = 0.5;
        esw80LineStandard.LineStyle = '--';
        
        esw90LineStandard = plot([90 90],[-70 0]);
        esw90LineStandard.Color = [144 143 143]./255;
        esw90LineStandard.LineWidth = 0.5;
        esw90LineStandard.LineStyle = '--';
        
        esw100SupersatLineStandard = plot([100 100],[-70 0]);
        esw100SupersatLineStandard.Color = [144 143 143]./255;
        esw100SupersatLineStandard.LineWidth = 1;
        
        esw102p5LineStandard = plot([102.5 102.5],[-70 0]);
        esw102p5LineStandard.Color = [144 143 143]./255;
        esw102p5LineStandard.LineWidth = 0.5;
        esw102p5LineStandard.LineStyle = '-.';
        
        startMat = ones(1,length(TlineStandardC));
        
        %text(83.38,-18.3,'100% (ice saturation)');
        water_esi0LineData = iceSupersatToRH(startMat.*0,TlineStandardC);
        esi0Line = plot(water_esi0LineData(1:289),TlineStandardC(1:289));
        esi0Line.Color = [144 143 143]./255;
        esi0Line.LineWidth = 1;
        hold on
        esi0Line2 = plot(water_esi0LineData(332:end),TlineStandardC(332:end));
        esi0Line2.Color = [144 143 143]./255;
        esi0Line2.LineWidth = 1;
        
        water_esi10LineData = iceSupersatToRH(startMat.*10,TlineStandardC);
        esi10Line = plot(water_esi10LineData(201:end),TlineStandardC(201:end));
        esi10Line.Color = [144 143 143]./255;
        esi10Line.LineWidth = 1.5;
        esi10Line.LineStyle = ':';
        
        water_esi20LineData = iceSupersatToRH(startMat.*20,TlineStandardC);
        esi20Line = plot(water_esi20LineData(248:end),TlineStandardC(248:end));
        esi20Line.Color = [144 143 143]./255;
        esi20Line.LineWidth = 1.5;
        esi20Line.LineStyle = ':';
        
        water_esi30LineData = iceSupersatToRH(startMat.*30,TlineStandardC);
        esi30Line = plot(water_esi30LineData(291:end),TlineStandardC(291:end));
        esi30Line.Color = [144 143 143]./255;
        esi30Line.LineWidth = 1.5;
        esi30Line.LineStyle = ':';
        
        water_esi40LineData = iceSupersatToRH(startMat.*40,TlineStandardC);
        esi40Line = plot(water_esi40LineData(335:end),TlineStandardC(335:end));
        esi40Line.Color = [144 143 143]./255;
        esi40Line.LineWidth = 1.5;
        esi40Line.LineStyle = ':';
        
        water_esi50LineData = iceSupersatToRH(startMat.*50,TlineStandardC);
        esi50Line = plot(water_esi50LineData(376:end),TlineStandardC(376:end));
        esi50Line.Color = [144 143 143]./255;
        esi50Line.LineWidth = 1.5;
        esi50Line.LineStyle = ':';
        
        water_esi60LineData = iceSupersatToRH(startMat.*60,TlineStandardC);
        esi60Line = plot(water_esi60LineData(416:end),TlineStandardC(416:end));
        esi60Line.Color = [144 143 143]./255;
        esi60Line.LineWidth = 1.5;
        esi60Line.LineStyle = ':';
        
        %[eswLineData] = eswLine(100,Tlower,Tupper);
        %water_ventLineData = iceSupersatToRH(2*eswLineData(151:end).*100,TlineStandardC(151:end));
        %water_ventLine = plot(water_ventLineData,TlineStandardC(151:end));
        %water_ventLine.Color = [0 26 255]./255;
        %water_ventLine.LineWidth = 1.2;
        
        % On-figure labels for isohumes and ice-isohumes
        lIce0 = text(83.38,-18.3,'100% (ice saturation)');
        lIce0.FontName = 'Lato'; lIce0.FontSize = 11;
        lIce0.Rotation = -32;
        lIce10 = text(86.7,-24,'110% (ice)');
        lIce10.FontName = 'Lato'; lIce10.FontSize = 11;
        lIce10.Rotation = -31;
        lIce20 = text(88.88,-30.4,'120% (ice)');
        lIce20.FontName = 'Lato'; lIce20.FontSize = 11;
        lIce20.Rotation = -31;
        lIce30 = text(90.95,-36.4,'130% (ice)');
        lIce30.FontName = 'Lato'; lIce30.FontSize = 11;
        lIce30.Rotation = -31;
        lIce40 = text(92.92,-42.1,'140% (ice)');
        lIce40.FontName = 'Lato'; lIce40.FontSize = 11;
        lIce40.Rotation = -31;
        lIce50 = text(94.81,-47.6,'150% (ice)');
        lIce50.FontName = 'Lato'; lIce50.FontSize = 11;
        lIce50.Rotation = -31;
        lIce60 = text(96.7,-52.9,'160% (ice)');
        lIce60.FontName = 'Lato'; lIce60.FontSize = 11;
        lIce60.Rotation = -32;
        %lVentW = text(107,-6,'Approx. max natural supersat (with ventilation)');
        %lVentW.FontName = 'Lato'; lVentW.FontSize = 12; lVentW.Color = 'k';
        %lVentW.Rotation = 41;
        
        % On-figure labels for growth modes
        lIceSubsaturated = text(65,-14,'Subsaturated with respect to ice, no ice growth');
        lIceSubsaturated.FontName = 'Lato'; lIceSubsaturated.FontSize = 11;
        lFaceW = text(95.5,-6,'Face growth (column-like)');
        lFaceW.FontName = 'Lato'; lFaceW.FontSize = 13;
        lEdgeW = text(91.25,-14.5,'Edge growth (plate-like)');
        lEdgeW.FontName = 'Lato'; lEdgeW.FontSize = 13;
        lCornerSectorW = text(100.65,-19.9,{'Corner growth', '(sector plates)'});
        lCornerSectorW.FontName = 'Lato'; lCornerSectorW.FontSize = 13;
        lCornerBranchedW = text(102,-15,{'Corner', 'growth', '(branched,', 'dendrites)'});
        lCornerBranchedW.FontName = 'Lato'; lCornerBranchedW.FontSize = 13;
        lMixedW = text(68.9,-40,'Mixed (polycrystals, plates, columns, equiaxed)');
        lMixedW.FontName = 'Lato'; lMixedW.FontSize = 13;
        lMixedW.Rotation = -38;
        lPolycrystalsPlatelikeW = text(80.6,-34,'Polycrystals (platelike)');
        lPolycrystalsPlatelikeW.FontName = 'Lato'; lPolycrystalsPlatelikeW.FontSize = 13;
        lPolycrystalsColumnarW = text(77,-50,'Polycrystals (columnar)');
        lPolycrystalsColumnarW.FontName = 'Lato'; lPolycrystalsColumnarW.FontSize = 13;
        
        % Diagram settings
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
        yLab.FontName = 'Lato Bold'; yLab.Color = 'k';
        
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
        axe.XTick = [50 55 60 65 70 75 80 85 90 95 100 105 110 120 130 140 150 160 170];
        axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
        axe.YDir = 'reverse';
    case "ice"
        %% Ice growth diagram in terms of relative humidity with respect to ice
        % Check variables
        xlimRange = [-0 0.6];
        ylimRange = [-56.5 0];
        
        % Draw the growth types
        plates = patch(hd.Plates.supersatBounds, hd.Plates.TempBounds,hd.Plates.TextbookColor);
        plates.EdgeColor = 'none';
        columnlike = patch(hd.ColumnLike.supersatBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.TextbookColor);
        columnlike.EdgeColor = 'none';
        variousplates = patch(hd.VariousPlates.supersatBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.TextbookColor);
        variousplates.EdgeColor = 'none';
        polycrystalsP1 = patch(hd.PolycrystalsP.supersatBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP1.EdgeColor = 'none';
        polycrystalsP2 = patch(hd.PolycrystalsP.supersatBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP2.EdgeColor = 'none';
        polycrystalsC1 = patch(hd.PolycrystalsC.supersatBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC1.EdgeColor = 'none';
        polycrystalsC2 = patch(hd.PolycrystalsC.supersatBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC2.EdgeColor = 'none';
        sectorplates1 = patch(hd.SectorPlates.supersatBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.TextbookColor);
        sectorplates1.EdgeColor = 'none';
        sectorplates2 = patch(hd.SectorPlates.supersatBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.TextbookColor);
        sectorplates2.EdgeColor = 'none';
        sectorplates3 = patch(hd.SectorPlates.supersatBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.TextbookColor);
        sectorplates3.EdgeColor = 'none';
        dendrites = patch(hd.Dendrites.supersatBounds,hd.Dendrites.TempBounds,hd.Dendrites.TextbookColor);
        dendrites.EdgeColor = 'none';
        intermediateSPD_floor = patch([hd.Dendrites.supersatBounds(1),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(2) hd.Dendrites.supersatBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.supersatBounds(4),hd.Dendrites.supersatBounds(4) hd.SectorPlates.supersatBounds(6) hd.SectorPlates.supersatBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_cursedTriangle = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_cursedTriangle.EdgeColor = 'none';
        mixed1 = patch(hd.Mixed.supersatBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.TextbookColor);
        mixed1.EdgeColor = 'none';
        mixed2 = patch(hd.Mixed.supersatBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.TextbookColor);
        mixed2.EdgeColor = 'none';
        warmerThanFreezing = patch(hd.warm.supersatBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
        warmerThanFreezing.EdgeColor = 'none';
        subsaturated = patch(hd.subsaturated.supersatBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
        subsaturated.EdgeColor = 'none';
        %unnaturalVent = patch(hd.unnaturalVent.supersatBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
        %unnaturalVent.EdgeColor = 'none';
        unnatural105 = patch(hd.unnatural105.supersatBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
        unnatural105.EdgeColor = 'none';
        hold on
        
        % Plot isohumes and ventilation lines
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        [eswLineData] = eswLine(100,Tlower,Tupper);
        eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
        eswSupersatLineStandard.Color = [144 143 143]./255;
        eswSupersatLineStandard.LineWidth = 0.5;
        
        eswLine90Data = eswLine(90,Tlower,Tupper);
        eswSupersatLineStandard90 = plot(eswLine90Data,TlineStandardC);
        eswSupersatLineStandard90.LineStyle = '--';
        eswSupersatLineStandard90.Color = [144 143 143]./255;
        eswSupersatLineStandard90.LineWidth = 0.5;
        
        eswLine80Data = eswLine(80,Tlower,Tupper);
        eswSupersatLineStandard80 = plot(eswLine80Data,TlineStandardC);
        eswSupersatLineStandard80.LineStyle = '--';
        eswSupersatLineStandard80.Color = [144 143 143]./255;
        eswSupersatLineStandard80.LineWidth = 0.5;
        
        eswLine70Data = eswLine(70,Tlower,Tupper);
        eswSupersatLineStandard70 = plot(eswLine70Data,TlineStandardC);
        eswSupersatLineStandard70.LineStyle = '--';
        eswSupersatLineStandard70.Color = [144 143 143]./255;
        eswSupersatLineStandard70.LineWidth = 0.5;
        
        eswLine60Data = eswLine(60,Tlower,Tupper);
        eswSupersatLineStandard60 = plot(eswLine60Data,TlineStandardC);
        eswSupersatLineStandard60.LineStyle = '--';
        eswSupersatLineStandard60.Color = [144 143 143]./255;
        eswSupersatLineStandard60.LineWidth = 0.5;
        
        eswLine50Data = eswLine(50,Tlower,Tupper);
        eswSupersatLineStandard50 = plot(eswLine50Data,TlineStandardC);
        eswSupersatLineStandard50.LineStyle = '--';
        eswSupersatLineStandard50.Color = [144 143 143]./255;
        eswSupersatLineStandard50.LineWidth = 0.5;
        
        eswLine40Data = eswLine(40,Tlower,Tupper);
        eswSupersatLineStandard40 = plot(eswLine40Data,TlineStandardC);
        eswSupersatLineStandard40.LineStyle = '--';
        eswSupersatLineStandard40.Color = [144 143 143]./255;
        eswSupersatLineStandard40.LineWidth = 0.5;
        
        eswLine30Data = eswLine(30,Tlower,Tupper);
        eswSupersatLineStandard30 = plot(eswLine30Data,TlineStandardC);
        eswSupersatLineStandard30.LineStyle = '--';
        eswSupersatLineStandard30.Color = [144 143 143]./255;
        eswSupersatLineStandard30.LineWidth = 0.5;
        
        eswLine20Data = eswLine(20,Tlower,Tupper);
        eswSupersatLineStandard20 = plot(eswLine20Data,TlineStandardC);
        eswSupersatLineStandard20.LineStyle = '--';
        eswSupersatLineStandard20.Color = [144 143 143]./255;
        eswSupersatLineStandard20.LineWidth = 0.5;
        
        eswLine10Data = eswLine(10,Tlower,Tupper);
        eswSupersatLineStandard10 = plot(eswLine10Data,TlineStandardC);
        eswSupersatLineStandard10.LineStyle = '--';
        eswSupersatLineStandard10.Color = [144 143 143]./255;
        eswSupersatLineStandard10.LineWidth = 0.5;
        
        eswLine0Data = eswLine(0,Tlower,Tupper);
        eswSupersatLineStandard0 = plot(eswLine0Data,TlineStandardC);
        eswSupersatLineStandard0.LineStyle = '--';
        eswSupersatLineStandard0.Color = [144 143 143]./255;
        eswSupersatLineStandard0.LineWidth = 0.5;
        
        eswLinep25Data = eswLine(102.5,Tlower,Tupper);
        eswSupersatLineStandardp25 = plot(eswLinep25Data(177:end),TlineStandardC(177:end));
        eswSupersatLineStandardp25.LineStyle = '-.';
        eswSupersatLineStandardp25.Color = [144 143 143]./255;
        eswSupersatLineStandardp25.LineWidth = 0.5;
        
        eswLinep5Data = eswLine(105,Tlower,Tupper);
        eswSupersatLineStandardp5 = plot(eswLinep5Data(203:end),TlineStandardC(203:end));
        eswSupersatLineStandardp5.LineStyle = '-.';
        eswSupersatLineStandardp5.Color = [144 143 143]./255;
        eswSupersatLineStandardp5.LineWidth = 0.5;
        
        %maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1;
        
        % On-figure labels for growth modes
        lFace = text(0.01,-6,'Face growth (column-like)');
        lFace.FontName = 'Lato'; lFace.FontSize = 13;
        lEdge = text(0.06,-15.8,'Edge growth (plate-like)');
        lEdge.FontName = 'Lato'; lEdge.FontSize = 13;
        lCornerBranched = text(0.185,-14.8,'Corner growth (branched, dendrites)');
        lCornerBranched.FontName = 'Lato'; lCornerBranched.FontSize = 13;
        lCornerSector = text(0.28,-19.7,'Corner growth (sector plates)');
        lCornerSector.FontName = 'Lato'; lCornerSector.FontSize = 13;
        lPolycrystalsPlatelike = text(0.27,-32,'Polycrystals (platelike)');
        lPolycrystalsPlatelike.FontName = 'Lato'; lPolycrystalsPlatelike.FontSize = 13;
        lPolycrystalsColumnar = text(0.32,-49.5,'Polycrystals (columnar)');
        lPolycrystalsColumnar.FontName = 'Lato'; lPolycrystalsColumnar.FontSize = 13;
        lMixed = text(0.02,-19.5,'Mixed (polycrystals, plates, columns, equiaxed)');
        lMixed.FontName = 'Lato'; lMixed.FontSize = 13;
        lMixed.Rotation = 90;
        
        % On-figure labels for isohumes
        lWater60 = text(0.008,-54.89,'60%');
        lWater60.FontName = 'Lato'; lWater60.FontSize = 11; lWater60.Color = [144 143 143]./255;
        lWater60.Rotation = 34;
        lWater70 = text(0.1161,-48.5,'70%');
        lWater70.FontName = 'Lato'; lWater70.FontSize = 11; lWater70.Color = [144 143 143]./255;
        lWater70.Rotation = 33;
        lWater80 = text(0.236,-44.9,'80%');
        lWater80.FontName = 'Lato'; lWater80.FontSize = 11; lWater80.Color = [144 143 143]./255;
        lWater80.Rotation = 31;
        lWater90 = text(0.3412,-40.9,'90%');
        lWater90.FontName = 'Lato'; lWater90.FontSize = 11; lWater90.Color = [144 143 143]./255;
        lWater90.Rotation = 29;
        lWater100 = text(0.4428,-37.4,'100% (T_{ice} = T_{air})');
        lWater100.FontName = 'Lato'; lWater100.FontSize = 11; lWater100.Color = [144 143 143]./255;
        lWater100.Rotation = 26;
        lWater102p5 = text(0.4596,-36,'102.5%');
        lWater102p5.FontName = 'Lato'; lWater102p5.FontSize = 11; lWater102p5.Color = [144 143 143]./255;
        lWater102p5.Rotation = 26;
        lWater105 = text(0.4742,-34.5,'105% (approx. max ambient supersat)');
        lWater105.FontName = 'Lato'; lWater105.FontSize = 11; lWater105.Color = [144 143 143]./255;
        lWater105.Rotation = 25;
        %lVent = text(0.36,-15.9,'Approx. max natural supersat (with ventilation)');
        %lVent.FontName = 'Lato'; lVent.FontSize = 12;
        %lVent.Rotation = 16;
        
        % Diagram settings
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
        xLab = xlabel('Relative humidity with respect to ice (%)');
        xLab.FontName = 'Lato Bold';
        axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
        axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
        xTickLabels = {'100' '105' '110' '115' '120' '125' '130' '135' '140' '145' '150' '155' '160'};
        xticklabels(xTickLabels);
        axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
        axe.YDir = 'reverse';
    case "vde"
        %% Ice growth diagram in terms of vapor density excess
        %function [fig,legendEntries,legendTexts] = iceGrowthDiagramVaporExc(hd,isohumeFlag,ventLog,updraftLog,legLog,legendLocStr,xlimRange,ylimRange)
        
        legLog = 1;
        legendLocStr = 'southoutside';
        
        % Modifiable variables
        xlimRange = [0 0.351];
        ylimRange = [-56.5 0];
        
        % Draw the growth types
        plates = patch(hd.Plates.vaporExcBounds, hd.Plates.TempBounds, hd.Plates.TextbookColor);
        plates.EdgeColor = 'none';
        columnlike = patch(hd.ColumnLike.vaporExcBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.TextbookColor);
        columnlike.EdgeColor = 'none';
        polycrystalsP1 = patch(hd.PolycrystalsP.vaporExcBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP1.EdgeColor = 'none';
        polycrystalsP2 = patch(hd.PolycrystalsP.vaporExcBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP2.EdgeColor = 'none';
        polycrystalsC1 = patch(hd.PolycrystalsC.vaporExcBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC1.EdgeColor = 'none';
        polycrystalsC2 = patch(hd.PolycrystalsC.vaporExcBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC2.EdgeColor = 'none';
        sectorplates1 = patch(hd.SectorPlates.vaporExcBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.TextbookColor);
        sectorplates1.EdgeColor = 'none';
        sectorplates2 = patch(hd.SectorPlates.vaporExcBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.TextbookColor);
        sectorplates2.EdgeColor = 'none';
        sectorplates3 = patch(hd.SectorPlates.vaporExcBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.TextbookColor);
        sectorplates3.EdgeColor = 'none';
        dendrites = patch(hd.Dendrites.vaporExcBounds,hd.Dendrites.TempBounds,hd.Dendrites.TextbookColor);
        dendrites.EdgeColor = 'none';
        variousplates = patch(hd.VariousPlates.vaporExcBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.TextbookColor);
        variousplates.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.Dendrites.vaporExcBounds(1),hd.Dendrites.vaporExcBounds(1) hd.Dendrites.vaporExcBounds(2) hd.Dendrites.vaporExcBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.vaporExcBounds(2,3) hd.SectorPlates.vaporExcBounds(2,2) hd.Dendrites.vaporExcBounds(1) hd.Dendrites.vaporExcBounds(4)], [hd.SectorPlates.TempBounds(3) hd.SectorPlates.TempBounds(2) hd.Dendrites.TempBounds(1) hd.Dendrites.TempBounds(3)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.vaporExcBounds(4),hd.Dendrites.vaporExcBounds(4) hd.SectorPlates.vaporExcBounds(6) hd.SectorPlates.vaporExcBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([hd.SectorPlates.vaporExcBounds(2,3) hd.Dendrites.vaporExcBounds(4) hd.Dendrites.vaporExcBounds(1)], [hd.SectorPlates.TempBounds(3) hd.Dendrites.TempBounds(3) hd.SectorPlates.TempBounds(3)], reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([hd.SectorPlates.vaporExcBounds(2,2), hd.Dendrites.vaporExcBounds(1), hd.Dendrites.vaporExcBounds(1)], [hd.SectorPlates.TempBounds(2), hd.Dendrites.TempBounds(1), hd.SectorPlates.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';
        
        mixed1 = patch(hd.Mixed.vaporExcBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.TextbookColor);
        mixed1.EdgeColor = 'none';
        
        mixed2 = patch(hd.Mixed.vaporExcBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.TextbookColor);
        mixed2.EdgeColor = 'none';
        warmerThanFreezing = patch(hd.warm.vaporExcBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
        warmerThanFreezing.EdgeColor = 'none';
        subsaturated = patch(hd.subsaturated.vaporExcBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
        subsaturated.EdgeColor = 'none';
        %unnaturalVent = patch(hd.unnaturalVent.vaporExcBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
        %unnaturalVent.EdgeColor = 'none';
        unnatural105 = patch(hd.unnatural105.vaporExcBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
        unnatural105.EdgeColor = 'none';
        hold on
        
        % Plot other lines
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        [eswLineData] = eswLine(100,Tlower,Tupper);
        [eswLineData] = iceSupersatToVaporExc(eswLineData,TlineStandardC);
        eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
        eswSupersatLineStandard.Color = [144 143 143]./255;
        eswSupersatLineStandard.LineWidth = 0.5;
        
        eswLine90Data = eswLine(90,Tlower,Tupper);
        [eswLine90Data] = iceSupersatToVaporExc(eswLine90Data,TlineStandardC);
        eswSupersatLineStandard90 = plot(eswLine90Data,TlineStandardC);
        eswSupersatLineStandard90.LineStyle = '--';
        eswSupersatLineStandard90.Color = [144 143 143]./255;
        eswSupersatLineStandard90.LineWidth = 0.5;
        
        eswLine80Data = eswLine(80,Tlower,Tupper);
        [eswLine80Data] = iceSupersatToVaporExc(eswLine80Data,TlineStandardC);
        eswSupersatLineStandard80 = plot(eswLine80Data,TlineStandardC);
        eswSupersatLineStandard80.LineStyle = '--';
        eswSupersatLineStandard80.Color = [144 143 143]./255;
        eswSupersatLineStandard80.LineWidth = 0.5;
        
        eswLine70Data = eswLine(70,Tlower,Tupper);
        [eswLine70Data] = iceSupersatToVaporExc(eswLine70Data,TlineStandardC);
        eswSupersatLineStandard70 = plot(eswLine70Data,TlineStandardC);
        eswSupersatLineStandard70.LineStyle = '--';
        eswSupersatLineStandard70.Color = [144 143 143]./255;
        eswSupersatLineStandard70.LineWidth = 0.5;
        
        eswLine60Data = eswLine(60,Tlower,Tupper);
        [eswLine60Data] = iceSupersatToVaporExc(eswLine60Data,TlineStandardC);
        eswSupersatLineStandard60 = plot(eswLine60Data,TlineStandardC);
        eswSupersatLineStandard60.LineStyle = '--';
        eswSupersatLineStandard60.Color = [144 143 143]./255;
        eswSupersatLineStandard60.LineWidth = 0.5;
        
        eswLine50Data = eswLine(50,Tlower,Tupper);
        [eswLine50Data] = iceSupersatToVaporExc(eswLine50Data,TlineStandardC);
        eswSupersatLineStandard50 = plot(eswLine50Data,TlineStandardC);
        eswSupersatLineStandard50.LineStyle = '--';
        eswSupersatLineStandard50.Color = [144 143 143]./255;
        eswSupersatLineStandard50.LineWidth = 0.5;
        
        eswLine40Data = eswLine(40,Tlower,Tupper);
        [eswLine40Data] = iceSupersatToVaporExc(eswLine40Data,TlineStandardC);
        eswSupersatLineStandard40 = plot(eswLine40Data,TlineStandardC);
        eswSupersatLineStandard40.LineStyle = '--';
        eswSupersatLineStandard40.Color = [144 143 143]./255;
        eswSupersatLineStandard40.LineWidth = 0.5;
        
        eswLine30Data = eswLine(30,Tlower,Tupper);
        [eswLine30Data] = iceSupersatToVaporExc(eswLine30Data,TlineStandardC);
        eswSupersatLineStandard30 = plot(eswLine30Data,TlineStandardC);
        eswSupersatLineStandard30.LineStyle = '--';
        eswSupersatLineStandard30.Color = [144 143 143]./255;
        eswSupersatLineStandard30.LineWidth = 0.5;
        
        eswLine20Data = eswLine(20,Tlower,Tupper);
        [eswLine20Data] = iceSupersatToVaporExc(eswLine20Data,TlineStandardC);
        eswSupersatLineStandard20 = plot(eswLine20Data,TlineStandardC);
        eswSupersatLineStandard20.LineStyle = '--';
        eswSupersatLineStandard20.Color = [144 143 143]./255;
        eswSupersatLineStandard20.LineWidth = 0.5;
        
        eswLine10Data = eswLine(10,Tlower,Tupper);
        [eswLine10Data] = iceSupersatToVaporExc(eswLine10Data,TlineStandardC);
        eswSupersatLineStandard10 = plot(eswLine10Data,TlineStandardC);
        eswSupersatLineStandard10.LineStyle = '--';
        eswSupersatLineStandard10.Color = [144 143 143]./255;
        eswSupersatLineStandard10.LineWidth = 0.5;
        
        eswLine0Data = eswLine(0,Tlower,Tupper);
        [eswLine0Data] = iceSupersatToVaporExc(eswLine0Data,TlineStandardC);
        eswSupersatLineStandard0 = plot(eswLine0Data,TlineStandardC);
        eswSupersatLineStandard0.LineStyle = '--';
        eswSupersatLineStandard0.Color = [144 143 143]./255;
        eswSupersatLineStandard0.LineWidth = 0.5;
        
        eswLinep25Data = eswLine(102.5,Tlower,Tupper);
        [eswLinep25Data] = iceSupersatToVaporExc(eswLinep25Data,TlineStandardC);
        eswSupersatLineStandardp25 = plot(eswLinep25Data,TlineStandardC);
        eswSupersatLineStandardp25.LineStyle = '-.';
        eswSupersatLineStandardp25.Color = [144 143 143]./255;
        eswSupersatLineStandardp25.LineWidth = 0.5;
        
        eswLinep5Data = eswLine(105,Tlower,Tupper);
        [eswLinep5Data] = iceSupersatToVaporExc(eswLinep5Data,TlineStandardC);
        eswSupersatLineStandardp5 = plot(eswLinep5Data,TlineStandardC);
        eswSupersatLineStandardp5.LineStyle = '-.';
        eswSupersatLineStandardp5.Color = [144 143 143]./255;
        eswSupersatLineStandardp5.LineWidth = 0.5;
        
        %Approximate maximum supersaturation with ventilation line
        %maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1.2;
        
        % On-figure isohume labels
        l70Vde = text(0.005243,-48.8,'70%');
        l70Vde.FontName = 'Lato'; l70Vde.FontSize = 11; l70Vde.Color = [144 143 143]./255;
        l70Vde.Rotation = -85;
        l80Vde = text(0.02493,-36.7,'80%');
        l80Vde.FontName = 'Lato'; l80Vde.FontSize = 11; l80Vde.Color = [144 143 143]./255;
        l80Vde.Rotation = -80;
        l90Vde = text(0.06927,-30.6,'90%');
        l90Vde.FontName = 'Lato'; l90Vde.FontSize = 11; l90Vde.Color = [144 143 143]./255;
        l90Vde.Rotation = -50;
        l100Vde = text(0.1866,-21,'100%');
        l100Vde.FontName = 'Lato'; l100Vde.FontSize = 11; l100Vde.Color = [144 143 143]./255;
        l100Vde.Rotation = -27;
        l2p5Vde = text(0.2133,-20.8,'102.5%');
        l2p5Vde.FontName = 'Lato'; l2p5Vde.FontSize = 11; l2p5Vde.Color = [144 143 143]./255;
        l2p5Vde.Rotation = -22;
        l5Vde = text(0.2245,-22,'105% (approx. max ambient supersat)');
        l5Vde.FontName = 'Lato'; l5Vde.FontSize = 11; l5Vde.Color = [144 143 143]./255;
        l5Vde.Rotation = -18;
        %lVentVde = text(0.28,-2.9,'Approx. max natural supersat (with ventilation)');
        %lVentVde.FontName = 'Lato'; lVentVde.FontSize = 12;
        %lVentVde.Rotation = 7;
        
        % On-figure growth mode labels
        lEdgeWarmVde = text(0.01,-2,'Edge growth (plate-like)');
        lEdgeWarmVde.FontName = 'Lato'; lEdgeWarmVde.FontSize = 13;
        lFaceVde = text(0.07,-6,'Face growth (column-like)');
        lFaceVde.FontName = 'Lato'; lFaceVde.FontSize = 13;
        lEdgeColdVde = text(0.12,-14,'Edge growth (plate-like)');
        lEdgeColdVde.FontName = 'Lato'; lEdgeColdVde.FontSize = 13;
        lCornerSectorVde = text(0.227,-10,'Corner growth (sector plates)');
        lCornerSectorVde.FontName = 'Lato'; lCornerSectorVde.FontSize = 13;
        lCornerBranchedVde = text(0.255,-15.5,'Corner growth');
        lCornerBranchedVde.FontName = 'Lato'; lCornerBranchedVde.FontSize = 13;
        lCornerBranchedVde2 = text(0.265,-14.5,'(branched, dendrites)');
        lCornerBranchedVde2.FontName = 'Lato'; lCornerBranchedVde2.FontSize = 13;
        lPolycrystalsPlatelikeVde = text(0.085,-28,'Polycrystals (platelike)');
        lPolycrystalsPlatelikeVde.FontName = 'Lato'; lPolycrystalsPlatelikeVde.FontSize = 13;
        lPolycrystalsColumnarVde = text(0.008,-48.05,{'Polycrystals', '(columnar)'});
        lPolycrystalsColumnarVde.FontName = 'Lato'; lPolycrystalsColumnarVde.FontSize = 13;
        
        % Diagram settings
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
        xLab = xlabel('Vapor density excess (gm^{-3})');
        xLab.FontName = 'Lato Bold';
        axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
        %axe.XTick = iceSupersatToVaporExc([0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6],zeros(1,13));
        %xTickLabels = {'100' '105' '110' '115' '120' '125' '130' '135' '140' '145' '150' '155' '160'};
        %xticklabels(xTickLabels);
        axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
        axe.YDir = 'reverse';
    otherwise
        close all
        inputFailureMsg = 'Invalid input! Please try the function again.';
        error(inputFailureMsg)
end

end
