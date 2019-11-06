function [hd] = makeGrowthDiagramStruct(crystalLog,otherLog)
%%makeGrowthDiagramStruct
    %Function to make a structure containing all information needed to plot
    %an ice growth diagram. Values derived from Bailey and Hallett 2009.
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
    %   RHice bounds, and RHwater bounds for all habits
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
    %Version date: 11/5/2019
    %Last major revision: 11/5/2019
    %
    %See also iceSupersatToRH
    %

%% Variable checks
if nargin ~= 2
    msg = 'Requires two inputs! Check function call and try again.';
    error(msg)
end

if ~isnumeric(crystalLog) || ~isnumeric(otherLog)
    msg = 'Inputs must be 0 or 1! Check input and try again.';
    error(msg)
end

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
hd = struct('Plates',''); %Structure needs at least one field to use dot notation

% Thermodynamic constants
hd.Constants.Lsub = 2.834*10^6; %J/(kgK) (latent heat of sublimation)
hd.Constants.Lvap = 2.501*10^6; %J/(kgK) (latent heat of vaporization)
hd.Constants.Rv = 461.5; %J/(kgK) (ideal gas constant)
hd.Constants.es0 = 611; %Pa (vapor pressure constant)

%% Make structure
if crystalLog==1
    
    % "Various plates" habit
    T_vp = [-8 -22];
    esw_vp = 6.1094.*exp((17.625.*T_vp)./(243.04+T_vp));
    esi_vp = 6.1121.*exp((22.587.*T_vp)./(273.86+T_vp));

    % "Sector plates" habit
    T_sp = [-8 -12.2; -12.2 -17.6; -17.6 -22];
    esw_sp = 6.1094.*exp((17.625.*T_sp)./(243.04+T_sp));
    esi_sp = 6.1121.*exp((22.587.*T_sp)./(273.86+T_sp));
    
    hd.Plates.Habit = 'Edge growth (plate-like)'; %Plates
    hd.Plates.Color = [243 139 156]./255;
    hd.Plates.TempBounds = [0 0 -4 -4];
    hd.Plates.supersatBounds = [0 0.1 0.1 0];
    hd.Plates.waterBounds = iceSupersatToRH(hd.Plates.supersatBounds.*100,hd.Plates.TempBounds);

    hd.ColumnLike.Habit = 'Face growth (column-like)'; %Column-like
    hd.ColumnLike.Color = [165 162 221]./255;
    hd.ColumnLike.TempBounds = [-4 -4 -8 -8];
    hd.ColumnLike.supersatBounds = [0 0.28 0.28 0];
    hd.ColumnLike.waterBounds = iceSupersatToRH(hd.ColumnLike.supersatBounds.*100,hd.ColumnLike.TempBounds);
    
    hd.VariousPlates.Habit = 'Edge growth (various plates)'; %Various plates
    hd.VariousPlates.Color = hd.Plates.Color;
    hd.VariousPlates.TempBounds = [-8 -8 -22 -22];
    hd.VariousPlates.supersatBounds = [0 (esw_vp(1)-esi_vp(1))/esi_vp(1) (esw_vp(2)-esi_vp(2))/esi_vp(2) 0];
    hd.VariousPlates.waterBounds = iceSupersatToRH(hd.VariousPlates.supersatBounds.*100,hd.VariousPlates.TempBounds);
    
    hd.SectorPlates.Habit = 'Corner growth (sector plates)'; %Sector plates
    hd.SectorPlates.Color =  [218 146 56]./255;
    hd.SectorPlates.TempBounds = [-8 -8 -12.2 -12.2; -12.2 -12.2 -17.6 -17.6; -17.6 -17.6 -22 -22];
    hd.SectorPlates.supersatBounds = [(esw_sp(1)-esi_sp(1))/esi_sp(1) 0.36 0.36 (esw_sp(4)-esi_sp(4))/esi_sp(4); (esw_sp(2)-esi_sp(2))/esi_sp(2) 0.15 0.21 (esw_sp(5)-esi_sp(5))/esi_sp(5); (esw_sp(3)-esi_sp(3))/esi_sp(3) 0.6 0.6 (esw_sp(6)-esi_sp(6))/esi_sp(6)];
    hd.SectorPlates.waterBounds = iceSupersatToRH(hd.SectorPlates.supersatBounds.*100,hd.SectorPlates.TempBounds);
    
    hd.Dendrites.Habit = 'Corner growth (branched, dendrites)'; %Dendrites
    hd.Dendrites.Color = [247 214 153]./255;
    hd.Dendrites.TempBounds = [-12.7 -12.7 -17.1 -17.1];
    hd.Dendrites.supersatBounds = [0.16 0.43 0.43 0.21];
    hd.Dendrites.waterBounds = iceSupersatToRH(hd.Dendrites.supersatBounds.*100,hd.Dendrites.TempBounds);
    
    hd.PolycrystalsP.Habit = 'Polycrystals (platelike)';
    hd.PolycrystalsP.Color = [89 25 42]./255;
    hd.PolycrystalsP.TempBounds = [-46.6 -40.2 -22 -22; -40.2 -40.2 -22 -22];
    hd.PolycrystalsP.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 0.6 0.6 0.33];
    hd.PolycrystalsP.waterBounds = iceSupersatToRH(hd.PolycrystalsP.supersatBounds.*100,hd.PolycrystalsP.TempBounds);
    
    hd.PolycrystalsC.Habit = 'Polycrystals (columnar)';
    hd.PolycrystalsC.Color = [0 54 70]./255;
    hd.PolycrystalsC.TempBounds = [-46.6 -40.2 -70 -70; -70 -70 -40.2 -40.2];
    hd.PolycrystalsC.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 0.6 0.6 0.33];
    hd.PolycrystalsC.waterBounds = iceSupersatToRH(hd.PolycrystalsC.supersatBounds.*100,hd.PolycrystalsC.TempBounds);
    
    hd.Mixed.Habit = 'Mixed (polycrystals, plates, columns, equiaxed)';
    hd.Mixed.Color = [143 111 73]./255;
    hd.Mixed.TempBounds = [-8 -8 -70 -70; -46.6 -45.9 -70 -70];
    hd.Mixed.supersatBounds = [0 0.038 0.038 0; 0.038 0.0697 0.0697 0.038];
    hd.Mixed.waterBounds = iceSupersatToRH(hd.Mixed.supersatBounds.*100,hd.Mixed.TempBounds);
    
end

if otherLog==1
    
    hd.unnatural.Habit = 'Coordinates to block out unnatural supersaturations'; %Follows the 2*water saturation line
    hd.unnatural.Color = [1 1 1];
    Tupper = 15; Tlower = -70;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    hd.unnatural.TempBounds = [0 TlineStandardC(2:11:420) 0];
    hd.unnatural.supersatBounds = [0 eswLineData(2:11:420).*2 0.6];
    hd.unnatural.waterBounds = iceSupersatToRH(hd.unnatural.supersatBounds.*100,hd.unnatural.TempBounds);
    
    hd.subsaturated.Habit = 'Coordinates to cover subsaturated area (for radiosonde data plotting).';
    hd.subsaturated.Color = [204 204 204]./255;
    hd.subsaturated.TempBounds = [0 0 -70 -70];
    hd.subsaturated.supersatBounds = [-0.6 0 0 -0.6];
    hd.subsaturated.waterBounds = iceSupersatToRH(hd.subsaturated.supersatBounds.*100,hd.subsaturated.TempBounds);
    
    hd.warm.Habit = 'Coordinates to cover the area warmer than freezing (for radiosonde data plotting).';
    hd.warm.Color = [255,255,255]./255; %Invisible by default; suggest [204 204 204]./255 if want to plot
    hd.warm.TempBounds = [25 25 0 0];
    hd.warm.supersatBounds = [0 0.6 0.6 0];
    hd.warm.waterBounds = iceSupersatToRH(hd.warm.supersatBounds.*100,hd.warm.TempBounds);
    
end

if crystalLog == 0
    hd = rmfield(hd,'Plates'); %Remove plate field if building structure without crystal growth info
end

end