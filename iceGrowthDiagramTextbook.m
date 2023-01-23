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
    %Version date: 12/2022
    %Last major revision: 12/2022
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
%eswLine refers to "difference between relative humidity with respect to
%water and ice saturation" used for plotting isohumes or orienting other
%objects on the diagrams
[eswLineData] = eswLine(100,Tlower,Tupper);
[eswLineDataVde] = iceSupersatToVaporExc(eswLineData,TlineStandardC); %Vapor density excess equivalent

switch castInTermsOf
    case "water"
        %% Ice growth diagram in terms of relative humidity with respect to water
        % Modifiable variables
        xlimRange = [55 105];
        ylimRange = [-70 0];
        
        % Draw the growth forms
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        tabular0C = patch(hd.Tabular0.waterBounds, hd.Tabular0.TempBounds, hd.Tabular0.TextbookColor);
        tabular0C.EdgeColor = 'none';
        columnar = patch(hd.Columnar.waterBounds,hd.Columnar.TempBounds,hd.Columnar.TextbookColor);
        columnar.EdgeColor = 'none';
        tabular8C = patch(hd.Tabular8.waterBounds,hd.Tabular8.TempBounds,hd.Tabular8.TextbookColor);
        tabular8C.EdgeColor = 'none';
        tabPolycrystPt1 = patch(hd.TabPolycryst.waterBounds(1,:),hd.TabPolycryst.TempBounds(1,:),hd.TabPolycryst.TextbookColor);
        tabPolycrystPt1.EdgeColor = 'none';
        tabPolycrystPt2 = patch(hd.TabPolycryst.waterBounds(2,:),hd.TabPolycryst.TempBounds(2,:),hd.TabPolycryst.TextbookColor);
        tabPolycrystPt2.EdgeColor = 'none';
        colPolycrystPt1 = patch(hd.ColPolycryst.waterBounds(1,:),hd.ColPolycryst.TempBounds(1,:),hd.ColPolycryst.TextbookColor);
        colPolycrystPt1.EdgeColor = 'none';
        colPolycrystPt2 = patch(hd.ColPolycryst.waterBounds(2,:),hd.ColPolycryst.TempBounds(2,:),hd.ColPolycryst.TextbookColor);
        colPolycrystPt2.EdgeColor = 'none';
        branchedPt1 = patch(hd.Branched.waterBounds(1,:),hd.Branched.TempBounds(1,:),hd.Branched.TextbookColor);
        branchedPt1.EdgeColor = 'none';
        branchedPt2 = patch(hd.Branched.waterBounds(2,:),hd.Branched.TempBounds(2,:),hd.Branched.TextbookColor);
        branchedPt2.EdgeColor = 'none';
        branchedPt3 = patch(hd.Branched.waterBounds(3,:),hd.Branched.TempBounds(3,:),hd.Branched.TextbookColor);
        branchedPt3.EdgeColor = 'none';
        sideBranched = patch(hd.SideBranched.waterBounds,hd.SideBranched.TempBounds,hd.SideBranched.TextbookColor);
        sideBranched.EdgeColor = 'none';
        
        intermedTabular = patch([83.4409,hd.Tabular8.waterBounds(end)-3,100 100],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.TextbookColor; hd.Tabular8.TextbookColor; hd.Tabular8.TextbookColor; hd.TabPolycryst.TextbookColor],4,[],3));
        intermedTabular.EdgeColor = 'none';
        intermedBranched = patch([100 100 131 131],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.TextbookColor; hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.TabPolycryst.TextbookColor],4,[],3));
        intermedBranched.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.SideBranched.waterBounds(1),hd.SideBranched.waterBounds(1) hd.SideBranched.waterBounds(2) hd.SideBranched.waterBounds(2)], [hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(2) hd.SideBranched.TempBounds(2),hd.Branched.TempBounds(5)*0.99],reshape([hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.SideBranched.TextbookColor; hd.Branched.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.Branched.waterBounds(2,3)*0.995 hd.Branched.waterBounds(2,2)*0.995 hd.SideBranched.waterBounds(1) hd.SideBranched.waterBounds(4)], [hd.Branched.TempBounds(3)*1.03 hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(1) hd.SideBranched.TempBounds(3)*1.01],reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.SideBranched.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.SideBranched.waterBounds(4),hd.SideBranched.waterBounds(4) hd.Branched.waterBounds(6) hd.Branched.waterBounds(9)], [hd.SideBranched.TempBounds(4) hd.Branched.TempBounds(11)*1.03 hd.Branched.TempBounds(11)*1.03,hd.SideBranched.TempBounds(4)],reshape([hd.SideBranched.TextbookColor; hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([101.08, 102.093, 102.093], [-18.128, -18.128, -17.1], reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([101.365,102.249,102.249], [-11.834,-12.7,-11.834], reshape([hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.Branched.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';
        
        multiplePt1 = patch(hd.Multiple.waterBounds(1,:),hd.Multiple.TempBounds(1,:),hd.Multiple.TextbookColor);
        multiplePt1.EdgeColor = 'none';
        multiplePt2 = patch(hd.Multiple.waterBounds(2,:),hd.Multiple.TempBounds(2,:),hd.Multiple.TextbookColor);
        multiplePt2.EdgeColor = 'none';

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
        multipleEdge1 = line([66.5,83.4409,95.8841],[-46.2,-22,-8]);
        multipleEdge1.LineWidth = brdThc; multipleEdge1.LineStyle = brdSt; multipleEdge1.Color = brdCol;
        multipleEdge15 = line([66.5,68.6274],[-46.2,-45.9]);
        multipleEdge15.LineWidth = brdThc; multipleEdge15.LineStyle = brdSt; multipleEdge15.Color = brdCol;
        multipleEdge2 = line(hd.Multiple.waterBounds(2,5:end)+0.025, hd.Multiple.TempBounds(2,5:end)+0.025);
        multipleEdge2.LineWidth = brdThc; multipleEdge2.LineStyle = brdSt; multipleEdge2.Color = brdCol;

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
        lIce10 = text(labX(6),labY(6),'110% (ice)','BackgroundColor',hd.TabPolycryst.TextbookColor);
        lIce10.FontName = 'Lato'; lIce10.FontSize = 16;
        lIce10.Rotation = -28;
        lIce20 = text(labX(7),labY(7),'120% (ice)','BackgroundColor',hd.TabPolycryst.TextbookColor);
        lIce20.FontName = 'Lato'; lIce20.FontSize = 16;
        lIce20.Rotation = -26;
        lIce30 = text(labX(8),labY(8),'130% (ice)'); %Curve must be broken around label manually (intersects multiple colors)
        lIce30.FontName = 'Lato'; lIce30.FontSize = 16;
        lIce30.Rotation = -26;
        lIce40 = text(labX(9),labY(9),'140% (ice)','BackgroundColor',hd.ColPolycryst.TextbookColor);
        lIce40.FontName = 'Lato'; lIce40.FontSize = 16;
        lIce40.Rotation = -26;
        lIce50 = text(labX(10),labY(10),'150% (ice)','BackgroundColor',hd.ColPolycryst.TextbookColor);
        lIce50.FontName = 'Lato'; lIce50.FontSize = 16;
        lIce50.Rotation = -26;
        lIce60 = text(labX(11),labY(11),'160% (ice)','BackgroundColor',hd.ColPolycryst.TextbookColor);
        lIce60.FontName = 'Lato'; lIce60.FontSize = 16;
        lIce60.Rotation = -27;
        lVentW = text(107,-6,'Approx. max natural supersat (with ventilation)');
        lVentW.FontName = 'Lato'; lVentW.FontSize = 13; lVentW.Color = 'k';
        lVentW.Rotation = 41;

        %maxVentValuesInRH = iceSupersatToRH(2.*eswLineData(151:end)*100,TlineStandardC(151:end));
        %maxVentLine = plot(maxVentValuesInRH,TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1;
        
        % On-figure labels for growth modes
        lIceSubsaturated = text(72,-10,'Subsaturated with respect to ice, no ice growth','BackgroundColor',hd.subsaturated.Color);
        lIceSubsaturated.FontName = 'Lato'; lIceSubsaturated.FontSize = 16;
        lFaceW = text(95.8,-6,'Columnar','BackgroundColor',hd.Columnar.TextbookColor);
        lFaceW.FontName = 'Lato'; lFaceW.FontSize = 16;
        lEdgeW = text(93.8,-17.65,'Tabular','BackgroundColor',hd.Tabular0.TextbookColor);
        lEdgeW.FontName = 'Lato'; lEdgeW.FontSize = 16;
        lCornerSectorTypeW = text(100.16,-11.5,'Branched');
        lCornerSectorTypeW.FontName = 'Lato'; lCornerSectorTypeW.FontSize = 16;
%         lCornerSectorSubtypeW = text(100.16,-10.2,'(sector)');
%         lCornerSectorSubtypeW.FontName = 'Lato'; lCornerSectorSubtypeW.FontSize = 14;
        lCornerBranchedTypeW = text(102,-15.9,'Side');
        lCornerBranchedTypeW.FontName = 'Lato'; lCornerBranchedTypeW.FontSize = 16;
        lCornerBranchedSubtypeW = text(102,-14.7,'branched');
        lCornerBranchedSubtypeW.FontName = 'Lato'; lCornerBranchedSubtypeW.FontSize = 16;
        lMultipleRhw = text(64,-48.6,'Multiple');
        lMultipleRhw.FontName = 'Lato'; lMultipleRhw.FontSize = 16;
        lMultipleRhw.Rotation = -35;
        lTabPolycrystRhw = text(89,-28,'Tabular polycrystalline','BackgroundColor',hd.TabPolycryst.TextbookColor);
        lTabPolycrystRhw.FontName = 'Lato'; lTabPolycrystRhw.FontSize = 16;
        lColPolycrystRhw = text(77,-50,'Columnar polycrystalline'); %Curve must be broken around label manually (bad angle of approach)
        lColPolycrystRhw.FontName = 'Lato'; lColPolycrystRhw.FontSize = 16;
        
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
        tabular0C = patch(hd.Tabular0.supersatBounds, hd.Tabular0.TempBounds,hd.Tabular0.TextbookColor);
        tabular0C.EdgeColor = 'none';
        columnar = patch(hd.Columnar.supersatBounds,hd.Columnar.TempBounds,hd.Columnar.TextbookColor);
        columnar.EdgeColor = 'none';
        tabular8C = patch(hd.Tabular8.supersatBounds,hd.Tabular8.TempBounds,hd.Tabular8.TextbookColor);
        tabular8C.EdgeColor = 'none';
        tabPolycrystPt1 = patch(hd.TabPolycryst.supersatBounds(1,:),hd.TabPolycryst.TempBounds(1,:),hd.TabPolycryst.TextbookColor);
        tabPolycrystPt1.EdgeColor = 'none';
        tabPolycrystPt2 = patch(hd.TabPolycryst.supersatBounds(2,:),hd.TabPolycryst.TempBounds(2,:),hd.TabPolycryst.TextbookColor);
        tabPolycrystPt2.EdgeColor = 'none';
        colPolycrystPt1 = patch(hd.ColPolycryst.supersatBounds(1,:),hd.ColPolycryst.TempBounds(1,:),hd.ColPolycryst.TextbookColor);
        colPolycrystPt1.EdgeColor = 'none';
        colPolycrystPt2 = patch(hd.ColPolycryst.supersatBounds(2,:),hd.ColPolycryst.TempBounds(2,:),hd.ColPolycryst.TextbookColor);
        colPolycrystPt2.EdgeColor = 'none';
        branchedPt1 = patch(hd.Branched.supersatBounds(1,:),hd.Branched.TempBounds(1,:),hd.Branched.TextbookColor);
        branchedPt1.EdgeColor = 'none';
        branchedPt2 = patch(hd.Branched.supersatBounds(2,:),hd.Branched.TempBounds(2,:),hd.Branched.TextbookColor);
        branchedPt2.EdgeColor = 'none';
        branchedPt3 = patch(hd.Branched.supersatBounds(3,:),hd.Branched.TempBounds(3,:),hd.Branched.TextbookColor);
        branchedPt3.EdgeColor = 'none';
        sideBranched = patch(hd.SideBranched.supersatBounds,hd.SideBranched.TempBounds,hd.SideBranched.TextbookColor);
        sideBranched.EdgeColor = 'none';
        
        intermedTabular = patch([hd.Tabular8.supersatBounds(end),hd.Tabular8.supersatBounds(end),eswLineData(351) eswLineData(371)],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.TextbookColor; hd.Tabular8.TextbookColor; hd.Tabular8.TextbookColor; hd.TabPolycryst.TextbookColor],4,[],3));
        intermedTabular.EdgeColor = 'none';
        intermedBranched = patch([eswLineData(351) 0.6 0.6 eswLineData(371)],[-20 -20 -22.1 -22.1],reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.TabPolycryst.TextbookColor; hd.TabPolycryst.TextbookColor],4,[],3));
        intermedBranched.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([0.15,0.16,0.43,0.4212], [hd.Branched.TempBounds(5)*0.97,-13.5,-13.5,hd.Branched.TempBounds(5)*0.99],reshape([hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.SideBranched.TextbookColor; hd.Branched.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([0.2054,0.135,0.16,0.2121], [hd.Branched.TempBounds(3)*1.03 hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(1) hd.SideBranched.TempBounds(3)*1.01],reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.SideBranched.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([0.21,0.2224,0.6084,0.5244], [hd.SideBranched.TempBounds(4) hd.Branched.TempBounds(11)*1.03 hd.Branched.TempBounds(11)*1.03,hd.SideBranched.TempBounds(4)],reshape([hd.SideBranched.TextbookColor; hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([0.2054,0.2224,0.21], [-18.128, -18.128, -17.1], reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([0.135,0.16,0.15], [-11.834,-12.7,-11.834], reshape([hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.Branched.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';

        multiplePt1 = patch(hd.Multiple.supersatBounds(1,:),hd.Multiple.TempBounds(1,:),hd.Multiple.TextbookColor);
        multiplePt1.EdgeColor = 'none';
        multiplePt2 = patch(hd.Multiple.supersatBounds(2,:),hd.Multiple.TempBounds(2,:),hd.Multiple.TextbookColor);
        multiplePt2.EdgeColor = 'none';
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
        multipleEdge1Rhi = [0.038,0.038,0.038];
        multipleEdge1 = line(multipleEdge1Rhi,[-46.2,-22,-8]);
        multipleEdge1.LineWidth = brdThc; multipleEdge1.LineStyle = brdSt; multipleEdge1.Color = brdCol;
        multipleEdge15Vde = rhwToRhi([66.5,68.6274],[-46.2,-45.9])/100 - 1;
        multipleEdge15 = line(multipleEdge15Vde,[-46.2,-45.9]);
        multipleEdge15.LineWidth = brdThc; multipleEdge15.LineStyle = brdSt; multipleEdge15.Color = brdCol;
        multipleEdge2Vde = rhwToRhi(hd.Multiple.waterBounds(2,10:end)+0.025, hd.Multiple.TempBounds(2,10:end)+0.025)/100 - 1;
        multipleEdge2 = line(multipleEdge2Vde, hd.Multiple.TempBounds(2,10:end)+0.025);
        multipleEdge2.LineWidth = brdThc; multipleEdge2.LineStyle = brdSt; multipleEdge2.Color = brdCol;

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
        lFace = text(0.01,-6,'Columnar','BackgroundColor',hd.Columnar.TextbookColor);
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
        lTabPolycryst = text(0.26,-32,'Tabular polycrystalline');
        lTabPolycryst.FontName = 'Lato'; lTabPolycryst.FontSize = 16;
        lColPolycryst = text(0.32,-49.5,'Columnar polycrystalline');
        lColPolycryst.FontName = 'Lato'; lColPolycryst.FontSize = 16;
        lMultiple = text(0.02,-19.5,'Multiple','BackgroundColor',hd.Multiple.TextbookColor);
        lMultiple.FontName = 'Lato'; lMultiple.FontSize = 16;
        lMultiple.Rotation = 90;
        
        % On-figure labels for isohumes
        lWater60 = text(0.005,-54.4,'60% (water)', 'BackgroundColor', hd.Multiple.TextbookColor);
        lWater60.FontName = 'Lato'; lWater60.FontSize = 16;
        lWater60.Rotation = 34;
        lWater70 = text(0.097,-46.5,'70% (water)','BackgroundColor',hd.ColPolycryst.TextbookColor);
        lWater70.FontName = 'Lato'; lWater70.FontSize = 16;
        lWater70.Rotation = 30;
        lWater80 = text(0.222,-43.7,'80% (water)','BackgroundColor',hd.ColPolycryst.TextbookColor);
        lWater80.FontName = 'Lato'; lWater80.FontSize = 16;
        lWater80.Rotation = 27;
        lWater90 = text(0.3412,-40.9,'90% (water)');
        lWater90.FontName = 'Lato'; lWater90.FontSize = 16;
        lWater90.Rotation = 25;
        lWater100 = text(0.406,-34.7,'100% (water)','BackgroundColor',hd.TabPolycryst.TextbookColor);
        lWater100.FontName = 'Lato'; lWater100.FontSize = 16;
        lWater100.Rotation = 22;
        lWater102p5 = text(0.425,-33.5,'102.5% (water)','BackgroundColor',hd.TabPolycryst.TextbookColor);
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
        tabular0C = patch(hd.Tabular0.vaporExcBounds, hd.Tabular0.TempBounds, hd.Tabular0.TextbookColor);
        tabular0C.EdgeColor = 'none';
        columnar = patch(hd.Columnar.vaporExcBounds,hd.Columnar.TempBounds,hd.Columnar.TextbookColor);
        columnar.EdgeColor = 'none';
        tabPolycrystPt1 = patch(hd.TabPolycryst.vaporExcBounds(1,:),hd.TabPolycryst.TempBounds(1,:),hd.TabPolycryst.TextbookColor);
        tabPolycrystPt1.EdgeColor = 'none';
        tabPolycrystPt2 = patch(hd.TabPolycryst.vaporExcBounds(2,:),hd.TabPolycryst.TempBounds(2,:),hd.TabPolycryst.TextbookColor);
        tabPolycrystPt2.EdgeColor = 'none';
        colPolycrystPt1 = patch(hd.ColPolycryst.vaporExcBounds(1,:),hd.ColPolycryst.TempBounds(1,:),hd.ColPolycryst.TextbookColor);
        colPolycrystPt1.EdgeColor = 'none';
        colPolycrystPt2 = patch(hd.ColPolycryst.vaporExcBounds(2,:),hd.ColPolycryst.TempBounds(2,:),hd.ColPolycryst.TextbookColor);
        colPolycrystPt2.EdgeColor = 'none';
        branchedPt1 = patch(hd.Branched.vaporExcBounds(1,:),hd.Branched.TempBounds(1,:),hd.Branched.TextbookColor);
        branchedPt1.EdgeColor = 'none';
        branchedPt2 = patch(hd.Branched.vaporExcBounds(2,:),hd.Branched.TempBounds(2,:),hd.Branched.TextbookColor);
        branchedPt2.EdgeColor = 'none';
        branchedPt3 = patch(hd.Branched.vaporExcBounds(3,:),hd.Branched.TempBounds(3,:),hd.Branched.TextbookColor);
        branchedPt3.EdgeColor = 'none';
        sideBranched = patch(hd.SideBranched.vaporExcBounds,hd.SideBranched.TempBounds,hd.SideBranched.TextbookColor);
        sideBranched.EdgeColor = 'none';
        tabular8C = patch(hd.Tabular8.vaporExcBounds,hd.Tabular8.TempBounds,hd.Tabular8.TextbookColor);
        tabular8C.EdgeColor = 'none';
        
        intermedTabular = patch([hd.Tabular8.vaporExcBounds(end),hd.Tabular8.vaporExcBounds(end)-3,eswLineDataVde(351),eswLineDataVde(371)],[-22.1 -20 -20 -22.1],reshape([hd.TabPolycryst.TextbookColor; hd.Tabular8.TextbookColor; hd.Tabular8.TextbookColor; hd.TabPolycryst.TextbookColor],4,[],3));
        intermedTabular.EdgeColor = 'none';
        intermedBranched = patch([eswLineDataVde(351) 0.9113 0.9113 eswLineDataVde(371)],[-20 -20 -22.1 -22.1],reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.TabPolycryst.TextbookColor; hd.TabPolycryst.TextbookColor],4,[],3));
        intermedBranched.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([0.2742,0.2713,0.729,0.7536], [hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(2) hd.SideBranched.TempBounds(2),hd.Branched.TempBounds(5)*0.99],reshape([hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.SideBranched.TextbookColor; hd.Branched.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([0.2202,0.256,0.2713,0.241], [hd.Branched.TempBounds(3)*1.03 hd.Branched.TempBounds(5)*0.97 hd.SideBranched.TempBounds(1) hd.SideBranched.TempBounds(3)*1.01],reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.SideBranched.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([0.2413,0.2329,0.6372,0.6026], [hd.SideBranched.TempBounds(4) hd.Branched.TempBounds(11)*1.03 hd.Branched.TempBounds(11)*1.03,hd.SideBranched.TempBounds(4)],reshape([hd.SideBranched.TextbookColor; hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([0.2202,0.2329,0.2413], [-18.128, -18.128, -17.1], reshape([hd.Branched.TextbookColor; hd.Branched.TextbookColor; hd.SideBranched.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([0.2560,0.2713,0.2742], [-11.834,-12.7,-11.834], reshape([hd.Branched.TextbookColor; hd.SideBranched.TextbookColor; hd.Branched.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';
        
        multiplePt1 = patch(hd.Multiple.vaporExcBounds(1,:),hd.Multiple.TempBounds(1,:),hd.Multiple.TextbookColor);
        multiplePt1.EdgeColor = 'none';
        
        multiplePt2 = patch(hd.Multiple.vaporExcBounds(2,:),hd.Multiple.TempBounds(2,:),hd.Multiple.TextbookColor);
        multiplePt2.EdgeColor = 'none';
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
        l80Vde = text(0.022,-39.3,'80% (water)','BackgroundColor',hd.TabPolycryst.TextbookColor);
        l80Vde.FontName = 'Lato'; l80Vde.FontSize = 16;
        l80Vde.Rotation = -77;
        l90Vde = text(0.055,-35,'90% (water)','BackgroundColor',hd.TabPolycryst.TextbookColor);
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
        lTabPolycrystVde = text(0.085,-26,'Tabular polycrystalline');
        lTabPolycrystVde.FontName = 'Lato'; lTabPolycrystVde.FontSize = 16;
        lColPolycrystVde = text(0.0034,-48.05,{'Columnar', 'polycrystalline'});
        lColPolycrystVde.FontName = 'Lato'; lColPolycrystVde.FontSize = 16;
        lMultipleVde = text(0.003,-12,{'Multiple'}, 'BackgroundColor',hd.Multiple.TextbookColor);
        lMultipleVde.FontName = 'Lato'; lMultipleVde.FontSize = 16;
        
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
