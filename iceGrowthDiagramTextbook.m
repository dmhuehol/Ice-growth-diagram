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
    %Version date: 10/31/2020
    %Last major revision: 10/31/2020
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

Tupper = 15; Tlower = -70;
TlineStandardC = Tupper:-0.1:Tlower;
[eswLineData] = eswLine(100,Tlower,Tupper);
[eswLineDataVde] = iceSupersatToVaporExc(eswLineData,TlineStandardC);

switch castInTermsOf
    case "water"
        %% Ice growth diagram in terms of relative humidity with respect to water
        % Modifiable variables
        xlimRange = [55 105];
        ylimRange = [-70 0];
        
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
        
        intermediatePlatesP = patch([83.4409,hd.VariousPlates.waterBounds(end)-3,100 100],[-22.1 -20 -20 -22.1],reshape([hd.PolycrystalsP.TextbookColor; hd.VariousPlates.TextbookColor; hd.VariousPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediatePlatesP.EdgeColor = 'none';
        intermediateSectorP = patch([100 100 131 131],[-22.1 -20 -20 -22.1],reshape([hd.PolycrystalsP.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediateSectorP.EdgeColor = 'none';
        
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

        brdThc = 0.9; brdCol = [105,105,105]./255; brdSt = '--';
        tabEdge = line([iceSupersatToRH(0,-4.05),105],[-4.05,-4.05]);
        tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
        colEdge = line([iceSupersatToRH(0,-8.05),105],[-8.05,-8.05]);
        colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
        varEdge = line([100.05,100.05],[-8,-22]);
        varEdge.LineWidth = brdThc; varEdge.LineStyle = brdSt; varEdge.Color = brdCol;
        polyBorderStrg = line([89.8227,105],[-40.2,-40.2]);
        polyBorderStrg.LineWidth = brdThc; polyBorderStrg.LineStyle = brdSt; polyBorderStrg.Color = brdCol;
        polyBorderAng = line([68.6524,86.5],[-45.875,-41.15]);
        polyBorderAng.LineWidth = brdThc; polyBorderAng.LineStyle = brdSt; polyBorderAng.Color = brdCol;
        polyBorderAng2 = line([89.8227,88.5],[-40.2,-40.6]); % Break around 130% RHice isohume label
        polyBorderAng2.LineWidth = brdThc; polyBorderAng2.LineStyle = brdSt; polyBorderAng2.Color = brdCol;
        mixedEdge1 = line([66.5,83.4409,95.8841],[-46.2,-22,-8]);
        mixedEdge1.LineWidth = brdThc; mixedEdge1.LineStyle = brdSt; mixedEdge1.Color = brdCol;
        mixedEdge15 = line([66.5,68.6274],[-46.2,-45.9]);
        mixedEdge15.LineWidth = brdThc; mixedEdge15.LineStyle = brdSt; mixedEdge15.Color = brdCol;
        mixedEdge2 = line(hd.Mixed.waterBounds(2,5:end)+0.025, hd.Mixed.TempBounds(2,5:end)+0.025);
        mixedEdge2.LineWidth = brdThc; mixedEdge2.LineStyle = brdSt; mixedEdge2.Color = brdCol;

        hold on
        
        %Draw isohumes
        for rhwc = [90:-10:0, 100, 102.5, 105]
            actHandle = num2str(rhwc);
            actHandleNoPunct = actHandle(actHandle~='.');
            if rhwc == 105
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot([rhwc rhwc],[-70,0]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 0.9;
            elseif rhwc == 102.5
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot([rhwc rhwc],[-14.1,0]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot([rhwc rhwc],[-70,-16.4]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 0.9;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            elseif rhwc == 100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot([rhwc rhwc],[-70,0]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 2.5;
            elseif rhwc == 80
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot([rhwc rhwc],[-22,0]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot([rhwc rhwc],[-49,-23.2]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']) = plot([rhwc rhwc],[-70,-50.3]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 0.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 0.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineWidth = 0.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).Color = [144 143 143]./255;
            else
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot([rhwc rhwc],[-70,0]);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 0.5;
            end
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
        end

        inLineX = [55,96.4635]; inLineY = [-2,-53.2]; %Place left edge of labels along this line
        rhiCount = 1;
        for rhic = 60:-10:-100 %input is an ice supersaturation, -100% ice supersaturation = 0% ice saturation
            if rhic > 0
                actRhiHandle = num2str(rhic);
            else
                actRhiHandle = ['sub',num2str(abs(rhic))];
            end
            esiLine_Handles.(['p', actRhiHandle, 'Num']) = iceSupersatToRH(rhic,TlineStandardC);
            if rhic == 0 %Break 100% ice saturation curve around label manually
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(1:346),TlineStandardC(1:346));
                esiLine_Handles.(['p', actRhiHandle, 'Plot2']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(428:end),TlineStandardC(428:end));
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).LineWidth = 2.5; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).LineWidth = 2.5;
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).Color = [144 143 143]./255; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).Color = [144 143 143]./255;
            elseif rhic == 30 %Break 130% ice saturation curve around "Columnar polycrystalline" and "130% (ice)" labels manually
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(1:530),TlineStandardC(1:530));
                esiLine_Handles.(['p', actRhiHandle, 'Plot2']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(566:600),TlineStandardC(566:600));
                esiLine_Handles.(['p', actRhiHandle, 'Plot3']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(600:642),TlineStandardC(600:642));
                esiLine_Handles.(['p', actRhiHandle, 'Plot4']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(656:end),TlineStandardC(656:end));
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).LineWidth = 1.5; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).LineWidth = 1.5; esiLine_Handles.(['p', actRhiHandle, 'Plot3']).LineWidth = 1.5; esiLine_Handles.(['p', actRhiHandle, 'Plot4']).LineWidth = 1.5;
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).LineStyle = ':'; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).LineStyle = ':'; esiLine_Handles.(['p', actRhiHandle, 'Plot3']).LineStyle = ':'; esiLine_Handles.(['p', actRhiHandle, 'Plot4']).LineStyle = ':';
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).Color = [144 143 143]./255; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).Color = [144 143 143]./255; esiLine_Handles.(['p', actRhiHandle, 'Plot3']).Color = [144 143 143]./255; esiLine_Handles.(['p', actRhiHandle, 'Plot4']).Color = [144 143 143]./255;
            elseif rhic == 20 %Break 120% ice saturation curve around "Corner (branched)" label manually
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(1:290),TlineStandardC(1:290));
                esiLine_Handles.(['p', actRhiHandle, 'Plot2']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(315:end),TlineStandardC(315:end));
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).LineWidth = 1.5; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).LineWidth = 1.5;
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).LineStyle = ':'; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).LineStyle = ':'; 
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).Color = [144 143 143]./255; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).Color = [144 143 143]./255;
           else
                esiLine_Handles.(['p', actRhiHandle, 'Plot']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num']),TlineStandardC);
                esiLine_Handles.(['p', actRhiHandle, 'Plot']).LineWidth = 1.5;
                esiLine_Handles.(['p', actRhiHandle, 'Plot']).LineStyle = ':';
            end
            esiLine_Handles.(['p', actRhiHandle, 'Plot']).Color = [144 143 143]./255;
            if rhic >= -40 %60% RHi (-40% ice supersaturation) is minimum label on textbook diagram
                [xInt,yInt] = polyxpoly(inLineX,inLineY,esiLine_Handles.(['p', actRhiHandle, 'Num']),TlineStandardC);
                labX(rhiCount) = xInt;
                labY(rhiCount) = yInt;
                rhiCount = rhiCount + 1;
            end
        end
        
        % On-figure labels for isohumes and ice-isohumes
        %labelsInLine = plot(inLineX,inLineY); labelsInLine.Color = 'r'; labelsInLine.LineWidth = 1.5; %uncomment to show the line the labels fall along
        labX = flip(labX);
        labY = flip(labY);

        lIce60p = text(labX(1),labY(1),'60% (ice)','BackgroundColor',hd.subsaturated.Color);
        lIce60p.FontName = 'Lato'; lIce60p.FontSize = 16;
        lIce60p.Rotation = -35;
        lIce70p = text(labX(2),labY(2),'70% (ice)','BackgroundColor',hd.subsaturated.Color);
        lIce70p.FontName = 'Lato'; lIce70p.FontSize = 16;
        lIce70p.Rotation = -32;
        lIce80p = text(labX(3),labY(3),'80% (ice)','BackgroundColor',hd.subsaturated.Color);
        lIce80p.FontName = 'Lato'; lIce80p.FontSize = 16;
        lIce80p.Rotation = -32;
        lIce90p = text(labX(4),labY(4),'90% (ice)','BackgroundColor',hd.subsaturated.Color);
        lIce90p.FontName = 'Lato'; lIce90p.FontSize = 16;
        lIce90p.Rotation = -32;
        lIce0 = text(labX(5),labY(5),'100% (ice saturation)'); %Curve must be broken around label manually (intersects multiple colors)
        lIce0.FontName = 'Lato'; lIce0.FontSize = 18;
        lIce0.Rotation = -29;
        lIce10 = text(labX(6),labY(6),'110% (ice)','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        lIce10.FontName = 'Lato'; lIce10.FontSize = 16;
        lIce10.Rotation = -28;
        lIce20 = text(labX(7),labY(7),'120% (ice)','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        lIce20.FontName = 'Lato'; lIce20.FontSize = 16;
        lIce20.Rotation = -26;
        lIce30 = text(labX(8),labY(8),'130% (ice)'); %Curve must be broken around label manually (intersects multiple colors)
        lIce30.FontName = 'Lato'; lIce30.FontSize = 16;
        lIce30.Rotation = -26;
        lIce40 = text(labX(9),labY(9),'140% (ice)','BackgroundColor',hd.PolycrystalsC.TextbookColor);
        lIce40.FontName = 'Lato'; lIce40.FontSize = 16;
        lIce40.Rotation = -26;
        lIce50 = text(labX(10),labY(10),'150% (ice)','BackgroundColor',hd.PolycrystalsC.TextbookColor);
        lIce50.FontName = 'Lato'; lIce50.FontSize = 16;
        lIce50.Rotation = -26;
        lIce60 = text(labX(11),labY(11),'160% (ice)','BackgroundColor',hd.PolycrystalsC.TextbookColor);
        lIce60.FontName = 'Lato'; lIce60.FontSize = 16;
        lIce60.Rotation = -27;
        %lVentW = text(107,-6,'Approx. max natural supersat (with ventilation)');
        %lVentW.FontName = 'Lato'; lVentW.FontSize = 13; lVentW.Color = 'k';
        %lVentW.Rotation = 41;
        
        % On-figure labels for growth modes
        lIceSubsaturated = text(72,-10,'Subsaturated with respect to ice, no ice growth','BackgroundColor',hd.subsaturated.Color);
        lIceSubsaturated.FontName = 'Lato'; lIceSubsaturated.FontSize = 16;
        lFaceW = text(95.8,-6,'Columnar','BackgroundColor',hd.ColumnLike.TextbookColor);
        lFaceW.FontName = 'Lato'; lFaceW.FontSize = 16;
        lEdgeW = text(93.8,-17.65,'Tabular','BackgroundColor',hd.Plates.TextbookColor);
        lEdgeW.FontName = 'Lato'; lEdgeW.FontSize = 16;
        lCornerSectorTypeW = text(100.16,-11.5,'Branched');
        lCornerSectorTypeW.FontName = 'Lato'; lCornerSectorTypeW.FontSize = 16;
%         lCornerSectorSubtypeW = text(100.16,-10.2,'(sector)');
%         lCornerSectorSubtypeW.FontName = 'Lato'; lCornerSectorSubtypeW.FontSize = 14;
        lCornerBranchedTypeW = text(102,-15.9,'Side');
        lCornerBranchedTypeW.FontName = 'Lato'; lCornerBranchedTypeW.FontSize = 16;
        lCornerBranchedSubtypeW = text(102,-14.7,'branched');
        lCornerBranchedSubtypeW.FontName = 'Lato'; lCornerBranchedSubtypeW.FontSize = 16;
        lMixedW = text(64,-48.6,'Multiple');
        lMixedW.FontName = 'Lato'; lMixedW.FontSize = 16;
        lMixedW.Rotation = -35;
        lPolycrystalsPlatelikeW = text(89,-28,'Tabular polycrystalline','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        lPolycrystalsPlatelikeW.FontName = 'Lato'; lPolycrystalsPlatelikeW.FontSize = 16;
        lPolycrystalsColumnarW = text(77,-50,'Columnar polycrystalline'); %Curve must be broken around label manually (bad angle of approach)
        lPolycrystalsColumnarW.FontName = 'Lato'; lPolycrystalsColumnarW.FontSize = 16;
        
        % Diagram settings
        axe = gca;
        axe.FontName = 'Lato';
        axe.FontSize = 18;
        
        yyaxis right
        [zLabels, tempsInRange, rightLimits, icaoAxLabel] = ylimitsForIceDiagram(ylimRange);
        axe.YTick = tempsInRange;
        yticklabels(zLabels);
        ylim(rightLimits)
        axe.Layer = 'top';
        yLab = ylabel(icaoAxLabel);
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
        ylimRange = [-70 0];
        
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
        
        intermediatePlatesP = patch([hd.VariousPlates.supersatBounds(end),hd.VariousPlates.supersatBounds(end),eswLineData(351) eswLineData(371)],[-22.1 -20 -20 -22.1],reshape([hd.PolycrystalsP.TextbookColor; hd.VariousPlates.TextbookColor; hd.VariousPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediatePlatesP.EdgeColor = 'none';
        intermediateSectorP = patch([eswLineData(351) 0.6 0.6 eswLineData(371)],[-20 -20 -22.1 -22.1],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.PolycrystalsP.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediateSectorP.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.Dendrites.supersatBounds(1),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(2) hd.Dendrites.supersatBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.supersatBounds(4),hd.Dendrites.supersatBounds(4) hd.SectorPlates.supersatBounds(6) hd.SectorPlates.supersatBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_remainingTriangle = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_remainingTriangle.EdgeColor = 'none';
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

        brdThc = 0.9; brdCol = [105,105,105]./255; brdSt = '--';
        tabEdgeRhi = [0, (rhwToRhi(105,-4.05)/100 - 1)]; %convert percent RHw to supersat RHi
        tabEdge = line(tabEdgeRhi,[-4.05,-4.05]);
        tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
        colEdgeRhi = [0, rhwToRhi(105,-8.05)/100 - 1];
        colEdge = line(colEdgeRhi,[-8.05,-8.05]);
        colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
        varEdgeRhi = rhwToRhi(ones(1,141)*100.05, TlineStandardC(231:371))/100 - 1;
        varEdge = line(varEdgeRhi,TlineStandardC(231:371));
        varEdge.LineWidth = brdThc; varEdge.LineStyle = brdSt; varEdge.Color = brdCol;
        polyBorderStrgRhi = rhwToRhi([89.8227,105],[-40.2,-40.2])/100 - 1;
        polyBorderStrg = line(polyBorderStrgRhi,[-40.2,-40.2]);
        polyBorderStrg.LineWidth = brdThc; polyBorderStrg.LineStyle = brdSt; polyBorderStrg.Color = brdCol;
        polyBorderAngVde = rhwToRhi([68.6524,89.8227],[-45.875,-40.2])/100 - 1;
        polyBorderAng = line(polyBorderAngVde,[-45.875,-40.2]);
        polyBorderAng.LineWidth = brdThc; polyBorderAng.LineStyle = brdSt; polyBorderAng.Color = brdCol;
        mixedEdge1Rhi = [0.038,0.038,0.038];
        mixedEdge1 = line(mixedEdge1Rhi,[-46.2,-22,-8]);
        mixedEdge1.LineWidth = brdThc; mixedEdge1.LineStyle = brdSt; mixedEdge1.Color = brdCol;
        mixedEdge15Vde = rhwToRhi([66.5,68.6274],[-46.2,-45.9])/100 - 1;
        mixedEdge15 = line(mixedEdge15Vde,[-46.2,-45.9]);
        mixedEdge15.LineWidth = brdThc; mixedEdge15.LineStyle = brdSt; mixedEdge15.Color = brdCol;
        mixedEdge2Vde = rhwToRhi(hd.Mixed.waterBounds(2,10:end)+0.025, hd.Mixed.TempBounds(2,10:end)+0.025)/100 - 1;
        mixedEdge2 = line(mixedEdge2Vde, hd.Mixed.TempBounds(2,10:end)+0.025);
        mixedEdge2.LineWidth = brdThc; mixedEdge2.LineStyle = brdSt; mixedEdge2.Color = brdCol;

        hold on
        
        % Plot isohumes and ventilation lines
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        for rhwc = [90:-10:0, 100, 102.5, 105]
            actHandle = num2str(rhwc);
            actHandleNoPunct = actHandle(actHandle~='.');
            eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
            if rhwc == 105
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(1:497),TlineStandardC(1:497));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(576:end),TlineStandardC(576:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 0.9;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            elseif rhwc == 102.5
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(1:278),TlineStandardC(1:278));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(300:end),TlineStandardC(300:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 0.9;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            elseif rhwc == 100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 2.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
            elseif rhwc == 90
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(1:559),TlineStandardC(1:559));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(593:end),TlineStandardC(593:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 1.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 1.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;               
            elseif rhwc == 60
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(1:695),TlineStandardC(1:695));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(713:end),TlineStandardC(713:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 1.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 1.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;               
            else
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 1.5;
            end
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
        end
        
        %maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1;
        
        % On-figure labels for growth modes
        lFace = text(0.01,-6,'Columnar','BackgroundColor',hd.ColumnLike.TextbookColor);
        lFace.FontName = 'Lato'; lFace.FontSize = 16;
        lEdge = text(0.08,-15.8,'Tabular');
        lEdge.FontName = 'Lato'; lEdge.FontSize = 16;
        lCornerBranched = text(0.17,-13,'Side');
        lCornerBranched.FontName = 'Lato'; lCornerBranched.FontSize = 16;
        lCornerBranched.Rotation = 24;
        lCornerBranchedLine2 = text(0.187,-13.5,'branched');
        lCornerBranchedLine2.FontName = 'Lato'; lCornerBranchedLine2.FontSize = 16;
        lCornerBranchedLine2.Rotation = 24;
        lCornerSector = text(0.205,-17.8,'Branched');
        lCornerSector.FontName = 'Lato'; lCornerSector.FontSize = 16;
        lCornerSector.Rotation = 26;
%         lCornerSectorLine2 = text(0.235,-18.03,'(sector)');
%         lCornerSectorLine2.FontName = 'Lato'; lCornerSectorLine2.FontSize = 14;
%         lCornerSectorLine2.Rotation = 30;
        lPolycrystalsPlatelike = text(0.26,-32,'Tabular polycrystalline');
        lPolycrystalsPlatelike.FontName = 'Lato'; lPolycrystalsPlatelike.FontSize = 16;
        lPolycrystalsColumnar = text(0.32,-49.5,'Columnar polycrystalline');
        lPolycrystalsColumnar.FontName = 'Lato'; lPolycrystalsColumnar.FontSize = 16;
        lMixed = text(0.02,-19.5,'Multiple','BackgroundColor',hd.Mixed.TextbookColor);
        lMixed.FontName = 'Lato'; lMixed.FontSize = 16;
        lMixed.Rotation = 90;
        
        % On-figure labels for isohumes
        lWater60 = text(0.005,-54.4,'60% (water)', 'BackgroundColor', hd.Mixed.TextbookColor);
        lWater60.FontName = 'Lato'; lWater60.FontSize = 16;
        lWater60.Rotation = 34;
        lWater70 = text(0.097,-46.5,'70% (water)','BackgroundColor',hd.PolycrystalsC.TextbookColor);
        lWater70.FontName = 'Lato'; lWater70.FontSize = 16;
        lWater70.Rotation = 30;
        lWater80 = text(0.222,-43.7,'80% (water)','BackgroundColor',hd.PolycrystalsC.TextbookColor);
        lWater80.FontName = 'Lato'; lWater80.FontSize = 16;
        lWater80.Rotation = 27;
        lWater90 = text(0.3412,-40.9,'90% (water)');
        lWater90.FontName = 'Lato'; lWater90.FontSize = 16;
        lWater90.Rotation = 25;
        lWater100 = text(0.406,-34.7,'100% (water)','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        lWater100.FontName = 'Lato'; lWater100.FontSize = 16;
        lWater100.Rotation = 22;
        lWater102p5 = text(0.425,-33.5,'102.5% (water)','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        lWater102p5.FontName = 'Lato'; lWater102p5.FontSize = 16;
        lWater102p5.Rotation = 22;
        lWater105 = text(0.445,-32.4,'105% (water,');
        lWater105.FontName = 'Lato'; lWater105.FontSize = 16;
        lWater105.Rotation = 21;
        lWater105Note = text(0.493,-35.9,'approx. max ambient supersat)');
        lWater105Note.FontName = 'Lato'; lWater105Note.FontSize = 16;
        lWater105Note.Rotation = 20.7;
        %lVent = text(0.36,-15.9,'Approx. max natural supersat (with ventilation)');
        %lVent.FontName = 'Lato'; lVent.FontSize = 12;
        %lVent.Rotation = 16;
        
        % Diagram settings
        axe = gca;
        axe.FontName = 'Lato';
        axe.FontSize = 18;
        
        yyaxis right
        [zLabels, tempsInRange, rightLimits, icaoAxLabel] = ylimitsForIceDiagram(ylimRange);
        axe.YTick = tempsInRange;
        yticklabels(zLabels);
        ylim(rightLimits)
        axe.Layer = 'top';
        yLab = ylabel(icaoAxLabel);
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
        % Modifiable variables
        xlimRange = [0 0.351];
        ylimRange = [-70 0];
        
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
        
        intermediatePlatesP = patch([hd.VariousPlates.vaporExcBounds(end),hd.VariousPlates.vaporExcBounds(end)-3,eswLineDataVde(351),eswLineDataVde(371)],[-22.1 -20 -20 -22.1],reshape([hd.PolycrystalsP.TextbookColor; hd.VariousPlates.TextbookColor; hd.VariousPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediatePlatesP.EdgeColor = 'none';
        intermediateSectorP = patch([eswLineDataVde(351) 0.9113 0.9113 eswLineDataVde(371)],[-20 -20 -22.1 -22.1],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.PolycrystalsP.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediateSectorP.EdgeColor = 'none';
        
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

        brdThc = 0.9; brdCol = [105,105,105]./255; brdSt = '--';
        tabEdgeVde = rhwToVaporExc([iceSupersatToRH(0,-4.05),105],[-4.05,-4.05]);
        tabEdge = line(tabEdgeVde,[-4.05,-4.05]);
        tabEdge.LineWidth = brdThc; tabEdge.LineStyle = brdSt; tabEdge.Color = brdCol;
        colEdgeVde = rhwToVaporExc([iceSupersatToRH(0,-8.05),105],[-8.05,-8.05]);
        colEdge = line(colEdgeVde,[-8.05,-8.05]);
        colEdge.LineWidth = brdThc; colEdge.LineStyle = brdSt; colEdge.Color = brdCol;
        varEdgeVde = rhwToVaporExc(ones(1,141)*100.05, TlineStandardC(231:371));
        varEdge = line(varEdgeVde,TlineStandardC(231:371));
        varEdge.LineWidth = brdThc; varEdge.LineStyle = brdSt; varEdge.Color = brdCol;
        polyBorderStrgVde = rhwToVaporExc([89.8227,105],[-40.2,-40.2]);
        polyBorderStrg = line(polyBorderStrgVde,[-40.2,-40.2]);
        polyBorderStrg.LineWidth = brdThc; polyBorderStrg.LineStyle = brdSt; polyBorderStrg.Color = brdCol;
        polyBorderAngVde = rhwToVaporExc([68.6524,89.8227],[-45.875,-40.2]);
        polyBorderAng = line(polyBorderAngVde,[-45.875,-40.2]);
        polyBorderAng.LineWidth = brdThc; polyBorderAng.LineStyle = brdSt; polyBorderAng.Color = brdCol;
        mixedEdge1Vde = rhwToVaporExc([66.5,83.4409,95.8841],[-46.2,-22,-8]);
        mixedEdge1 = line(mixedEdge1Vde,[-46.2,-22,-8]);
        mixedEdge1.LineWidth = brdThc; mixedEdge1.LineStyle = brdSt; mixedEdge1.Color = brdCol;
        mixedEdge15Vde = rhwToVaporExc([66.5,68.6274],[-46.2,-45.9]);
        mixedEdge15 = line(mixedEdge15Vde,[-46.2,-45.9]);
        mixedEdge15.LineWidth = brdThc; mixedEdge15.LineStyle = brdSt; mixedEdge15.Color = brdCol;
        mixedEdge2Vde = rhwToVaporExc(hd.Mixed.waterBounds(2,10:end)+0.025, hd.Mixed.TempBounds(2,10:end)+0.025);
        mixedEdge2 = line(mixedEdge2Vde, hd.Mixed.TempBounds(2,10:end)+0.025);
        mixedEdge2.LineWidth = brdThc; mixedEdge2.LineStyle = brdSt; mixedEdge2.Color = brdCol;


        hold on
        
        % Plot other lines
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        for rhwc = [90:-10:0, 100, 102.5, 105]
            actHandle = num2str(rhwc);
            actHandleNoPunct = actHandle(actHandle~='.');
            eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
            eswLine_Handles.(['p', actHandleNoPunct, 'Vde']) = iceSupersatToVaporExc(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
            if rhwc == 105
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:287),TlineStandardC(1:287));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(372:617),TlineStandardC(372:617));                
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(628:end),TlineStandardC(628:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineWidth = 0.9;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).Color = [144 143 143]./255;
            elseif rhwc == 102.5
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:324),TlineStandardC(1:324));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(360:616),TlineStandardC(360:616));                
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(630:end),TlineStandardC(630:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-.'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 0.9; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineWidth = 0.9;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).Color = [144 143 143]./255;
            elseif rhwc == 100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:323),TlineStandardC(1:323));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(360:615),TlineStandardC(360:615));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(630:end),TlineStandardC(630:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineStyle = '-';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 2.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 2.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineWidth = 2.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).Color = [144 143 143]./255;
            elseif rhwc == 90
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:615),TlineStandardC(1:615));                
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(644:end),TlineStandardC(644:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 1.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 1.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            elseif rhwc == 80
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:615),TlineStandardC(1:615));                
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(646:end),TlineStandardC(646:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 1.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 1.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            elseif rhwc == 70
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:533),TlineStandardC(1:533));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(595:615),TlineStandardC(595:615));                
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(648:end),TlineStandardC(648:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = ':'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 1.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 1.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).LineWidth = 1.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot3']).Color = [144 143 143]./255;
            else
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 1.5;
            end
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
        end
        
        %Approximate maximum supersaturation with ventilation line
        %maxVentLine = plot(2.*eswLineDataVde(151:end),TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1.2;
        
        % On-figure isohume labels
        l70Vde = text(0.00524,-44.8,'70% ');
        l70Vde.FontName = 'Lato'; l70Vde.FontSize = 16;
        l70Vde.Rotation = -87.8;
        l70WaterVde = text(0.006,-41.7,'(water)');
        l70WaterVde.FontName = 'Lato'; l70WaterVde.FontSize = 16;
        l70WaterVde.Rotation = -96;
        l80Vde = text(0.022,-39.3,'80% (water)','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        l80Vde.FontName = 'Lato'; l80Vde.FontSize = 16;
        l80Vde.Rotation = -77;
        l90Vde = text(0.055,-35,'90% (water)','BackgroundColor',hd.PolycrystalsP.TextbookColor);
        l90Vde.FontName = 'Lato'; l90Vde.FontSize = 16;
        l90Vde.Rotation = -43;
        l100Vde = text(0.1866,-21,'100% (water)');
        l100Vde.FontName = 'Lato'; l100Vde.FontSize = 16;
        l100Vde.Rotation = -23;
        l2p5Vde = text(0.2133,-20.8,'102.5% (water)');
        l2p5Vde.FontName = 'Lato'; l2p5Vde.FontSize = 16;
        l2p5Vde.Rotation = -18;
        l5Vde = text(0.2245,-22,'105% (water, approx. ');
        l5Vde.FontName = 'Lato'; l5Vde.FontSize = 16;
        l5Vde.Rotation = -13.8;
        l5VdeNote = text(0.27,-18.4,'max ambient supersat)');
        l5VdeNote.FontName = 'Lato'; l5VdeNote.FontSize = 16;
        l5VdeNote.Rotation = -15.5;
        %lVentVde = text(0.28,-2.9,'Approx. max natural supersat (with ventilation)');
        %lVentVde.FontName = 'Lato'; lVentVde.FontSize = 12;
        %lVentVde.Rotation = 7;
        
        % On-figure growth mode labels
        lEdgeWarmVde = text(0.01,-2,'Tabular');
        lEdgeWarmVde.FontName = 'Lato'; lEdgeWarmVde.FontSize = 16;
        lFaceVde = text(0.07,-6,'Columnar');
        lFaceVde.FontName = 'Lato'; lFaceVde.FontSize = 16;
        lEdgeColdVde = text(0.12,-14,'Tabular');
        lEdgeColdVde.FontName = 'Lato'; lEdgeColdVde.FontSize = 16;
        lCornerSectorVde = text(0.235,-12,'Branched');
        lCornerSectorVde.FontName = 'Lato'; lCornerSectorVde.FontSize = 16;
%         lCornerSectorVdeSubtype = text(0.2518,-9.95,'(sector)');
%         lCornerSectorVdeSubtype.FontName = 'Lato'; lCornerSectorVdeSubtype.FontSize = 14;
        lCornerBranchedVde = text(0.265,-15.5,'Side');
        lCornerBranchedVde.FontName = 'Lato'; lCornerBranchedVde.FontSize = 16;
        lCornerBranchedVde2 = text(0.272,-14.4,'branched');
        lCornerBranchedVde2.FontName = 'Lato'; lCornerBranchedVde2.FontSize = 16;
        lPolycrystalsPlatelikeVde = text(0.085,-26,'Tabular polycrystalline');
        lPolycrystalsPlatelikeVde.FontName = 'Lato'; lPolycrystalsPlatelikeVde.FontSize = 16;
        lPolycrystalsColumnarVde = text(0.0034,-48.05,{'Columnar', 'polycrystalline'});
        lPolycrystalsColumnarVde.FontName = 'Lato'; lPolycrystalsColumnarVde.FontSize = 16;
        lMixedVde = text(0.003,-12,{'Multiple'}, 'BackgroundColor',hd.Mixed.TextbookColor);
        lMixedVde.FontName = 'Lato'; lMixedVde.FontSize = 16;
        
        % Diagram settings
        axe = gca;
        axe.FontName = 'Lato';
        axe.FontSize = 18;
        
        yyaxis right
        [zLabels, tempsInRange, rightLimits, icaoAxLabel] = ylimitsForIceDiagram(ylimRange);
        axe.YTick = tempsInRange;
        yticklabels(zLabels);
        ylim(rightLimits)
        axe.Layer = 'top';
        yLab = ylabel(icaoAxLabel);
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
        axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
        axe.YDir = 'reverse';
    otherwise
        close all
        inputFailureMsg = 'Invalid input! Please check input and try again.';
        error(inputFailureMsg)
end

%% Prompt user whether to save figure as PNG
% saveFigPrompt = 'Save figure as PNG? [Y/N] ';
% saveYesNo = input(saveFigPrompt,'s');
% 
% set(gcf, 'PaperUnits','points','PaperPosition', [1 1 1440 849]);
% set(gcf,'renderer','Painters')
% 
% if strcmp(saveYesNo,'Y') || strcmp(saveYesNo,'y')
%     saveFilename = ['igd_' char(castInTermsOf)];
%     disp(['Saving figure as: ' saveFilename '.png'])
%     saveas(gcf,saveFilename,'png');
% end

end
