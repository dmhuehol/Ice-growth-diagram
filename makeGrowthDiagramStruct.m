function [hd] = makeGrowthDiagramStruct(crystalLog,otherLog)
%%makeGrowthDiagramStruct
    %Function to make a structure containing all information needed to plot
    %a growth diagram. Values derived from Bailey and Hallett 2009.
    %
    %General form: [hd] = makeGrowthDiagramStruct(crystalLog,otherLog)
    %
    %Output
    %hd: a structure containing name, plot colors, temperature bounds,
    %and ice supersaturation bounds for all habits
    %
    %Inputs
    %crystalLog: logical 1/0 whether or not to contain info for crystal habits, defaults to 1
    %otherLog: logical 1/0 whether or not to include info for other parameters 
    %   (e.g. subsaturated areas, unnatural supersaturations), defaults to 1 
    %
    %Might be nice to eventually have temperature/supersat as an input here and only
    %include habits that appear in that temperature range?
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 5/21/2019
    %Last major revision: 5/21/2019 
    %

%% Variable Checks
if ~exist('crystalLog','var')
    disp('Growth info included by default')
    crystalLog=1;
end
if ~exist('otherLog','var')
    disp('Info for other useful parameters included by default')
    otherLog=1;
end
if crystalLog~=1 && crystalLog~=0
    msg = 'crystalLog input must be 1 or 0';
    error(msg);
end
if otherLog~=1 && otherLog~=0
    msg = 'otherLog input must be 1 or 0';
    error(msg);
end

%% Setup
hd = struct('Plates',''); %Structure must have at least one field in order to assign elements using dot notation

% Constants
hd.Constants.Lsub = 2.834*10^6; %J/(kgK)
hd.Constants.Lvap = 2.501*10^6; %J/(kgK)
hd.Constants.Rv = 461.5; %J/(kgK)
hd.Constants.es0 = 611; %Pa

%% Make the structure
if crystalLog==1
    % "Various plates" habit
    T_vp = [-8 -22];
    T_vp = T_vp + 273.15;
    esw_vp = hd.Constants.es0*exp(hd.Constants.Lvap/hd.Constants.Rv*(1/273.15-1./T_vp)); %Saturated vapor pressure with respect to water
    esi_vp = hd.Constants.es0*exp(hd.Constants.Lsub/hd.Constants.Rv*(1/273.15-1./T_vp)); %Saturated vapor pressure with respect to ice
    % "Sector plates" habit
    T_sp = [-8 -12.2; -12.2 -17.6; -17.6 -22];
    T_sp = T_sp + 273.15;
    esw_sp = hd.Constants.es0*exp(hd.Constants.Lvap/hd.Constants.Rv*(1/273.15-1./T_sp)); %Saturated vapor pressure with respect to water
    esi_sp = hd.Constants.es0*exp(hd.Constants.Lsub/hd.Constants.Rv*(1/273.15-1./T_sp)); %Saturated vapor pressure with respect to ice
    
    hd.Plates.Habit = 'Edge growth (plate-like)'; %'Plates';
    hd.Plates.Color = [243 139 156]./255;
    hd.Plates.TempBounds = [0 0 -4 -4];
    hd.Plates.supersatBounds = [0 0.1 0.1 0];

    hd.ColumnLike.Habit = 'Face growth (column-like)'; %'Column-like';
    hd.ColumnLike.Color = [165 162 221]./255;
    hd.ColumnLike.TempBounds = [-4 -4 -8 -8];
    hd.ColumnLike.supersatBounds = [0 0.28 0.28 0];
    
    hd.VariousPlates.Habit = 'Edge growth (various plates)'; %'Various plates';
    hd.VariousPlates.Color = hd.Plates.Color;
    hd.VariousPlates.TempBounds = [-8 -8 -22 -22];
    hd.VariousPlates.supersatBounds = [0 (esw_vp(1)-esi_vp(1))/esi_vp(1) (esw_vp(2)-esi_vp(2))/esi_vp(2) 0];
    
    hd.SectorPlates.Habit = 'Corner growth (sector plates)'; %'Sector plates';
    hd.SectorPlates.Color =  [218 146 56]./255;
    hd.SectorPlates.TempBounds = [-8 -8 -12.2 -12.2; -12.2 -12.2 -17.6 -17.6; -17.6 -17.6 -22 -22];
    hd.SectorPlates.supersatBounds = [(esw_sp(1)-esi_sp(1))/esi_sp(1) 0.36 0.36 (esw_sp(4)-esi_sp(4))/esi_sp(4); (esw_sp(2)-esi_sp(2))/esi_sp(2) 0.15 0.21 (esw_sp(5)-esi_sp(5))/esi_sp(5); (esw_sp(3)-esi_sp(3))/esi_sp(3) 0.6 0.6 (esw_sp(6)-esi_sp(6))/esi_sp(6)];
    
    hd.Dendrites.Habit = 'Corner growth (branched, dendrites)'; %'Dendrites';
    hd.Dendrites.Color = [247 214 153]./255;
    hd.Dendrites.TempBounds = [-12.7 -12.7 -17.1 -17.1];
    hd.Dendrites.supersatBounds = [0.16 0.43 0.43 0.21];
    
    hd.PolycrystalsP.Habit = 'Polycrystals (platelike)';
    hd.PolycrystalsP.Color = [89 25 42]./255; %[63 1 22]./255;
    hd.PolycrystalsP.TempBounds = [-46.6 -40.2 -22 -22; -40.2 -40.2 -22 -22];
    hd.PolycrystalsP.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 0.6 0.6 0.33];
    
    hd.PolycrystalsC.Habit = 'Polycrystals (columnar)';
    hd.PolycrystalsC.Color = [0 54 70]./255;
    hd.PolycrystalsC.TempBounds = [-46.6 -40.2 -70 -70; -70 -70 -40.2 -40.2];
    hd.PolycrystalsC.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 0.6 0.6 0.33];
    
    hd.Mixed.Habit = 'Mixed (polycrystals, plates, columns, equiaxed)';
    hd.Mixed.Color = [143 111 73]./255;
    hd.Mixed.TempBounds = [-8 -8 -70 -70; -46.6 -45.9 -70 -70];
    hd.Mixed.supersatBounds = [0 0.038 0.038 0; 0.038 0.0697 0.0697 0.038 ];
    
    hd.PolycrystalsIntermediate.Habit = 'Possible extension of the bullet rosette habit';
    hd.PolycrystalsIntermediate.Color = [hd.PolycrystalsP.Color; hd.PolycrystalsP.Color]; %Not shown on current diagram
    hd.PolycrystalsIntermediate.TempBounds = [-40.2 -40.2 -36.5 -36.5];
    hd.PolycrystalsIntermediate.supersatBounds = [0.359 0.491 0.445 0.316];
end

if otherLog==1
    hd.unnatural.Habit = 'Coordinates to block out unnatural supersaturations'; %Follows the 2*water saturation line
    hd.unnatural.Color = [1 1 1];
    hd.unnatural.TempBounds = [0 -7.5 -14 -18.5 -24.8 0];
    hd.unnatural.supersatBounds = [0 0.1549 0.3068 0.4231 0.6 0.6];
    
    hd.subsaturated.Habit = 'Coordinates to cover subsaturated area, for better radiosonde data plotting.';
    hd.subsaturated.Color = [204 204 204]./255;
    hd.subsaturated.TempBounds = [0 0 -70 -70];
    hd.subsaturated.supersatBounds = [-0.2 0 0 -0.2];
    
    hd.warm.Habit = 'Coordinates to cover an area that is warmer than freezing, for better radiosonde data plotting.';
    hd.warm.Color = [255,255,255]./255; %[204 204 204]./255;
    hd.warm.TempBounds = [15 15 0 0];
    hd.warm.supersatBounds = [0 0.6 0.6 0];
end

end