function [zLabels, tempsInRange, outputTempSpan, icaoAxLabel] = ylimitsForIceDiagram(inputTempSpan)
%%ylimitsForIceDiagram
    %Generates labels, tick marks, and other relevant information for the
    %y-axes on the ice diagram given an input temperature range.
    %
    %General form: [zLabels, tempsInRange, tempSpan] = ylimitsForIceDiagram(tempSpan)
    %Outputs
    %zLabels: cell array containing labels for ICAO standard atmosphere
    %heights within the input temperature span
    %tempsInRange: used to make the tickmarks that are relabeled to reflect
    %ICAO standard heights
    %outputTempSpan: input temperature span is in format [min max], output
    %is in format [-max -min]. This is required for the right-hand y-axis
    %to plot correctly on the ice diagram.
    %icaoAxLabel: axis label for right y-axis on diagram
    %
    %Input
    %inputTempSpan: temperature span in format [min max]. Most common input
    %value is [-56.5 0], which spans the mid-latitude troposphere.
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 3/28/2022
    %Last major revision: 3/28/2022
    %
    
icaoAxLabel = ['Height above 0' char(176) 'C level in m (ICAO standard troposphere)'];

classNum = {'numeric'};
attribute = {'>=',-70};
validateattributes(inputTempSpan,classNum,attribute); %Check to ensure numeric greater than -70C (diagram does not go farther than -70C)

possibleTemps = [0 2 4 6 8 10 12 14 16 18 20 22 30 40 50 56.5 60 70];
% -56.5 deg C is tropopause, 11000 m is height of tropopause
z = [2300 2625 2925 3225 3550 3850 4150 4475 4775 5075 5400 5700 6925 8450 10000 11000 NaN NaN];
possibleZ = z-2300; %Height above 0C line

inputTempSpan = -inputTempSpan;
tempsInRange = possibleTemps(possibleTemps >= inputTempSpan(2) & possibleTemps <= inputTempSpan(1)); %Find temps in input temp range
zInRange = possibleZ(possibleTemps >= inputTempSpan(2) & possibleTemps <= inputTempSpan(1)); %Heights matching temp indices
outputTempSpan = fliplr(inputTempSpan); %Flip these for right-hand y-axis plotting 

zLabels = {};
for c = length(zInRange):-1:1
    if ~isnan(zInRange(c))
        zLabels{c} = num2str(zInRange(c));
    else
        continue
    end
end

end