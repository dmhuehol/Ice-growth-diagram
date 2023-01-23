function [hd] = makeGrowthDiagramStruct(crystalLog,otherLog)
%%makeGrowthDiagramStruct
    %Function to make a structure containing all information needed to plot
    %an ice growth diagram. These values are used in the paper:
    % Hueholt, D.M., Yuter, S.E., and M.A. Miller, 2022: Revisiting
    % Diagrams of Ice Growth Environments, Bulletin of the American
    % Meteorological Society, doi.org/10.1175/BAMS-D-21-0271.1.
    %
    %Values are derived from text and figures in Bailey and Hallett 2009 and
    %Bailey and Hallett 2004. Bailey and Hallett 2009 cuts off the top of
    %the diagram at a 0.6 ice supersaturation, but lab work in Bailey and
    %Hallett 2004 extends to higher values. The supersaturations above 0.6
    %come from Bailey and Hallett 2004.
    %
    %Saturation vapor pressure equations use the Improved
    %August-Roche-Magnus equation from
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 25 and 27 from above citation.
    %
    %General form: [hd] = makeGrowthDiagramStruct(crystalLog,otherLog)
    %
    %Output
    %hd: a structure containing name, plot colors, temperature bounds,
    %   RHice bounds, RHw bounds, and vapor density excess bounds for all
    %   regions of the diagram
    %
    %Inputs
    %crystalLog: logical 1/0 whether or not to contain info for crystal
    %   habits, defaults to 1
    %otherLog: logical 1/0 whether or not to include info for other parameters 
    %   (e.g. subsaturated areas, unnatural supersaturations), defaults to 1 
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Portions written as part of HON499: Capstone II
    %Version date: 1/2023
    %Last major revision: 1/2023
    %
    %See also iceSupersatToRH, iceSupersatToVaporExc
    %

%% Variable checks
if nargin ~= 2
    msg = 'Requires two inputs! Check function call and try again.';
    error(msg)
end

classNum = {'numeric'};
attribute = {'>=',0,'<=',1};
validateattributes(crystalLog,classNum,attribute);
validateattributes(otherLog,classNum,attribute);

if crystalLog==1 && otherLog==1
    disp('Structure includes crystal growth and information for other parameters.')
end
if crystalLog==1 && otherLog==0
    disp('Structure includes crystal growth information only.')
end
if crystalLog==0 && otherLog==1
    disp('Structure includes non-crystal growth information only.')
end
if crystalLog==0 && otherLog==0
    disp('Empty structure created.')
    hd = struct([]);
    return
end

%% Setup
hd = struct('Constants',''); %Structure needs at least one field to use dot notation

% Thermodynamic constants
hd.Constants.Lsub = 2.834*10^6; %J/(kgK) (latent heat of sublimation)
hd.Constants.Lvap = 2.501*10^6; %J/(kgK) (latent heat of vaporization)
hd.Constants.Rv = 461.5; %J/(kgK) (ideal gas constant)
hd.Constants.es0 = 611; %Pa (vapor pressure constant)

%% Make structure
if crystalLog==1
    % Branched form boundaries (used for calculations elsewhere)
    tempBranched = [-8 -12.2; -12.2 -17.6; -17.6 -22];
    eswBranched = 6.1094.*exp((17.625.*tempBranched)./(243.04+tempBranched));
    esiBranched = 6.1121.*exp((22.587.*tempBranched)./(273.86+tempBranched));
    
    hd.Tabular0.Form = 'Tabular'; %Tabular form between 0C and -4C
    hd.Tabular0.Color = [243 139 156]./255;
    hd.Tabular0.TextbookColor = [252 222 226]./255;
    hd.Tabular0.TempBounds = [0 0 -4 -4];
    hd.Tabular0.supersatBounds = [0 0.1 0.1 0];
    hd.Tabular0.waterBounds = iceSupersatToRH(hd.Tabular0.supersatBounds.*100,hd.Tabular0.TempBounds);
    hd.Tabular0.vaporExcBounds = iceSupersatToVaporExc(hd.Tabular0.supersatBounds,hd.Tabular0.TempBounds);

    hd.Columnar.Form = 'Columnar'; %Columnar form
    hd.Columnar.Color = [165 162 221]./255;
    hd.Columnar.TextbookColor = [204 202 235]./255;
    hd.Columnar.TempBounds = [-4 -4 -8 -8];
    hd.Columnar.supersatBounds = [0 0.28 0.28 0];
    hd.Columnar.waterBounds = iceSupersatToRH(hd.Columnar.supersatBounds.*100,hd.Columnar.TempBounds);
    hd.Columnar.vaporExcBounds = iceSupersatToVaporExc(hd.Columnar.supersatBounds,hd.Columnar.TempBounds);
    
    hd.Tabular8.Form = 'Tabular'; %Tabular form between -8C and -20C
    hd.Tabular8.Color = hd.Tabular0.Color;
    hd.Tabular8.TextbookColor = hd.Tabular0.TextbookColor;
    Tupper = -8; Tlower = -20;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    hd.Tabular8.TempBounds = [-8 TlineStandardC -20];
    hd.Tabular8.supersatBounds = [0.038 eswLineData 0.038];
    hd.Tabular8.waterBounds = iceSupersatToRH(hd.Tabular8.supersatBounds.*100,hd.Tabular8.TempBounds);
    hd.Tabular8.vaporExcBounds = iceSupersatToVaporExc(hd.Tabular8.supersatBounds,hd.Tabular8.TempBounds);
    
    hd.Branched.Form = 'Branched'; %Branched
    hd.Branched.Color =  [218 146 56]./255;
    hd.Branched.TextbookColor = [245 224 198]./255;
    hd.Branched.TempBounds = [-8 -8 -12.2 -12.2; -12.2 -12.2 -17.6 -17.6; -17.6 -17.6 -22 -22];
    hd.Branched.supersatBounds = [(eswBranched(1)-esiBranched(1))/esiBranched(1) 0.36 0.36 (eswBranched(4)-esiBranched(4))/esiBranched(4); (eswBranched(2)-esiBranched(2))/esiBranched(2) 0.15 0.21 (eswBranched(5)-esiBranched(5))/esiBranched(5); (eswBranched(3)-esiBranched(3))/esiBranched(3) 0.6 0.6 (eswBranched(6)-esiBranched(6))/esiBranched(6)];
    hd.Branched.waterBounds = iceSupersatToRH(hd.Branched.supersatBounds.*100,hd.Branched.TempBounds);
    hd.Branched.vaporExcBounds = iceSupersatToVaporExc(hd.Branched.supersatBounds,hd.Branched.TempBounds);
    
    hd.SideBranched.Form = 'Side branched'; %Side branched
    hd.SideBranched.Color = [247 214 153]./255;
    hd.SideBranched.TextbookColor = [253 243 225]./255;
    hd.SideBranched.TempBounds = [-12.7 -12.7 -17.1 -17.1];
    hd.SideBranched.supersatBounds = [0.16 0.43 0.43 0.21];
    hd.SideBranched.waterBounds = iceSupersatToRH(hd.SideBranched.supersatBounds.*100,hd.SideBranched.TempBounds);
    hd.SideBranched.vaporExcBounds = iceSupersatToVaporExc(hd.SideBranched.supersatBounds,hd.SideBranched.TempBounds);
    
    hd.TabPolycryst.Form = 'Tabular polycrystalline';
    hd.TabPolycryst.Color = [89 25 42]./255;
    hd.TabPolycryst.TextbookColor = [207 189 195]./255;
    hd.TabPolycryst.TempBounds = [-46.6 -40.2 -22 -22; -40.2 -40.2 -22 -22];
    hd.TabPolycryst.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 1 0.6 0.33];
    hd.TabPolycryst.waterBounds = iceSupersatToRH(hd.TabPolycryst.supersatBounds.*100,hd.TabPolycryst.TempBounds);
    hd.TabPolycryst.vaporExcBounds = iceSupersatToVaporExc(hd.TabPolycryst.supersatBounds,hd.TabPolycryst.TempBounds);
    
    hd.ColPolycryst.Form = 'Columnar polycrystalline';
    hd.ColPolycryst.Color = [0 54 70]./255;
    hd.ColPolycryst.TextbookColor = [183 198 203]./255;
    hd.ColPolycryst.TempBounds = [-46.6 -40.2 -70 -70 -70; -70 -70 -50 -40.2 -40.2];
    hd.ColPolycryst.supersatBounds = [0.038 0.33 0.33 0.33 0.038; 0.33 1 1 1 0.33];
    hd.ColPolycryst.waterBounds = iceSupersatToRH(hd.ColPolycryst.supersatBounds.*100,hd.ColPolycryst.TempBounds);
    hd.ColPolycryst.vaporExcBounds = iceSupersatToVaporExc(hd.ColPolycryst.supersatBounds,hd.ColPolycryst.TempBounds);
    
    hd.Multiple.Form = 'Multiple';
    hd.Multiple.Color = [143 111 73]./255;
    hd.Multiple.TextbookColor = [223 214 203]./255;
    hd.Multiple.TempBounds = [linspace(-8,-46.6,10) -46.6 -22 -8; linspace(-46.6,-70,9) -70 -60 -55 -45.9];
    hd.Multiple.supersatBounds = [zeros(1,10) 0.038 0.038 0.038; zeros(1,9) 0.0697 0.0697 0.0697 0.0697];
    hd.Multiple.waterBounds = iceSupersatToRH(hd.Multiple.supersatBounds.*100,hd.Multiple.TempBounds);
    hd.Multiple.vaporExcBounds = iceSupersatToVaporExc(hd.Multiple.supersatBounds,hd.Multiple.TempBounds);
end

if otherLog==1
    Tupper_other = 15; Tlower_other = -90; %Block out regions even if extended beyond default
    TlineStandardC = Tupper_other:-0.1:Tlower_other;
    [eswLineData_other] = eswLine(100,Tlower_other,Tupper_other);

    hd.unnatural105.Form = 'Coordinates to block out unphysical supersaturations greater than 105% RHw';
    hd.unnatural105.Color = [1 1 1];
    [ew105_line] = eswLine(105,Tlower_other,Tupper_other);
    hd.unnatural105.TempBounds = [0 TlineStandardC(2:11:end) 0];
    hd.unnatural105.supersatBounds = [0 ew105_line(2:11:end) 1];
    hd.unnatural105.waterBounds = iceSupersatToRH(hd.unnatural105.supersatBounds.*100,hd.unnatural105.TempBounds);
    hd.unnatural105.vaporExcBounds = iceSupersatToVaporExc(hd.unnatural105.supersatBounds,hd.unnatural105.TempBounds);
    
    hd.subsaturated.Form = 'Coordinates to cover subsaturated area (for radiosonde data plotting).';
    hd.subsaturated.Color = [222 222 222]./255;
    esiLineData = zeros(1,length(TlineStandardC(151:end)));
    hd.subsaturated.TempBounds = [0 TlineStandardC(151:end) -70 0];%[0 TlineStandardC(151:end) -70];
    hd.subsaturated.supersatBounds =  [-0.5 esiLineData -0.5 -0.5];%[-0.2 esiLineData -0.2];
    hd.subsaturated.waterBounds = iceSupersatToRH(hd.subsaturated.supersatBounds*100,hd.subsaturated.TempBounds);
    hd.subsaturated.vaporExcBounds = iceSupersatToVaporExc(hd.subsaturated.supersatBounds,hd.subsaturated.TempBounds);
    
    hd.warm.Form = 'Coordinates to cover the area warmer than freezing (for radiosonde data plotting).';
    hd.warm.Color = [255,255,255]./255; %Invisible by default; suggest [204 204 204]./255 if want to plot
    hd.warm.TempBounds = [25 25 0 0];
    hd.warm.supersatBounds = [0 0.6 0.6 0];
    hd.warm.waterBounds = iceSupersatToRH(hd.warm.supersatBounds.*100,hd.warm.TempBounds);
    hd.warm.vaporExcBounds = iceSupersatToVaporExc(hd.warm.supersatBounds,hd.warm.TempBounds);

    hd.unnaturalVent.Form = 'Coordinates to block out unnatural supersaturations corresponding to Bailey and Hallett 2009 ventilation approximation'; %Follows the 2*water saturation line
    hd.unnaturalVent.Color = [1 1 1];
    hd.unnaturalVent.TempBounds = [0 TlineStandardC(2:11:end) 0];
    hd.unnaturalVent.supersatBounds = [0 eswLineData_other(2:11:end).*2 1];
    hd.unnaturalVent.waterBounds = iceSupersatToRH(hd.unnaturalVent.supersatBounds.*100,hd.unnaturalVent.TempBounds);
    hd.unnaturalVent.vaporExcBounds = iceSupersatToVaporExc(hd.unnaturalVent.supersatBounds,hd.unnaturalVent.TempBounds);
    
end

end