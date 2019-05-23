# Ice growth diagram (summer 2019)
## Introduction
Complete set of MATLAB code to make the revised ice growth diagram. Tested and confirmed operational on MATLAB 2017b+.

## Workflow for habit diagram
1. Make sure all code is in the working directory.
2. Run makeGrowthDiagramStruct to produce hd structure
3. Run iceGrowthDiagram using the hd structure as input
4. Success!

## Converting between ice supersaturation and vapor density excess
Previous ice growth diagrams have reported supersaturations in either ice supersaturation (percent or decimal) or vapor density excess (g/m^3). Converting between the two units is possible, but not immediately intuitive. Currently, the revised diagram exclusively uses the ice supersaturation percent unit.  
The functions iceSupersatToRH and rhow make conversions from ice supersaturation to vapor density difference possible.
### Example 
Given an ice supersaturation of 3.8% at -8 deg Celsius, what is the vapor density excess at the same temperature?  
1. [RH] = iceSupersatToRH(3.8,-8)  
  This returns RH=95.8%
2. [rhoDiff] = rhow(95.8,-8)  
  This returns rhoDiff=0.095 
  
Thus a vapor density excess of 0.095 g/m^3 corresponds to an ice supersaturation of 3.8% at -8 deg Celsius!

## Examples
### "Complete" ice growth diagram
------
![Revised ice growth diagram with all habits, isohumes, legend, and other features](Demo/igd_complete.png)
**Replicate with**  
1. [hd] = makeGrowthDiagramStruct(1,1)
2. iceGrowthDiagram(hd,1,1,1,0,1)  

### No legend
------
![Revised ice growth diagram with everything except the legend](Demo/igd_isohumes_nolegend.png)
**Replicate with**  
1. [hd] = makeGrowthDiagramStruct(1,1)
2. iceGrowthDiagram(hd,1,1,1,0,0)

### No isohumes
------
![Revised ice growth diagram with no isohumes](Demo/igd_noisohumes.png)
**Replicate with**  
1. [hd] = makeGrowthDiagramStruct(1,1)
2. iceGrowthDiagram(hd,1,0,1,0,1)

## Function descriptions
### Main functions
**makeGrowthDiagramStruct:** Creates a structure the information needed to plot a growth diagram. Values are derived from Bailey and Hallett 2009.  
**iceGrowthDiagram:** Plots the revised ice growth diagram.

### Required helper functions
**eswLine:** Outputs arrays useful to draw isohumes with respect to water on the diagram.  
**updraftSupersat:** Estimates maximum possible supersaturation in updraft. CAUTION: this function is still in progress.  

### Other functions
**iceSupersatToRH**: Converts an ice supersaturation in percent to a relative humidity with respect to water, also in percent.
**rhow**: Calculates vapor density excess from a relative humidity (with respect to water) in percent and temperature.

## Sources and Credit
------
Bailey, M.P., & Hallett, J. (2009). A comprehensive habit diagram for atmospheric ice crystals: Confirmation from the laboratory, AIRS II, and other field studies. *Journal of the Atmospheric Sciences, 66*(9), 2888-2899. [doi:10.1175/2009JAS2883.1](https://doi.org/10.1175/2009JAS2883.1)  

All code and documentation written by Daniel Hueholt, under the advisement of Dr. Sandra Yuter at North Carolina State University.  
[<img src="http://www.environmentanalytics.com/wp-content/uploads/2016/05/cropped-Environment_Analytics_Logo_Draft.png">](http://www.environmentanalytics.com)
