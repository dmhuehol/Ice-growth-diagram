# Ice growth diagram

**CAUTION:** This branch (`spring2021-presentation-figures`) is specifically for making figures for the presentation used in spring 2021 classes at NC State. Switch to the `master` branch for the most up-to-date code, or to `for-OSF-submission-with-paper-2020` for the version of the code accompanying "Revisiting Diagrams of Ice Growth Environments" by Hueholt, Yuter, and Miller.

## Table of Contents
* [Introduction](#introduction)  
* [Basic ice diagrams](#basic-ice-diagrams)  
    * [Relative humidity with respect to water](#ice-growth-diagram-relative-humidity-with-respect-to-water)  
    * [Relative humidity with respect to ice](#ice-growth-diagram-relative-humidity-with-respect-to-ice)
    * [Vapor density excess](#ice-growth-diagram-vapor-density-excess)
    * [Relative humidity with respect to water (textbook version)](#ice-growth-diagram-relative-humidity-with-respect-to-water-textbook-edition)
* [Converting between ice supersaturation and vapor density excess](#converting-between-ice-supersaturation-and-vapor-density-excess)
* [Repository description](#repository-description)
    * [Root](#root)
    * [Helper functions](#helper-functions-subdirectory)
    * [Growth diagram profiles](#growth-diagram-profiles-subdirectory)
    * [Demo](#demo-subdirectory)
* [Growth diagram profiles](#growth-diagram-profiles)
* [Sources and credit](#sources-and-credit)

## Introduction
Complete set of MATLAB code to plot the ice growth diagram both on its own and with data. Tested and confirmed operational on MATLAB 2020a+. The ice growth diagram can be cast into three moisture variables: relative humidity with respect to water (preferred), relative humidity with respect to ice, and vapor density excess over ice saturation. There are "textbook" and "applied" versions of each ice diagram; the textbook versions are designed to be the most aesthetically-pleasing, while the applied versions are higher-contrast and suitable for data overlays.

## Basic ice diagrams
The following examples show how to make the three applied diagrams and the textbook diagram cast in terms of relative humidity with respect to water.

### Ice growth diagram: relative humidity with respect to water
![Ice growth diagram with respect to water](Demo/igd_rhw_applied.png)
This is our preferred version of the diagram. Relative humidity with respect to water is easier to understand and better represents the phase space of ice processes in the atmosphere than other moisture variables.
#### Minimal code to replicate
1. `iceGrowthDiagramWater`
The code will automatically set inputs, including the necessary basic hd structure.
#### Full code to replicate
1. `[hd] = makeGrowthDiagramStruct(1,1)`
2. `iceGrowthDiagramWater(hd,0,1,'southoutside',[55 105],[-56.5 0],0)`

### Ice growth diagram: relative humidity with respect to ice
![Ice growth diagram with respect to water](Demo/igd_rhi_applied.png)
For comparison to previous work, especially Bailey and Hallett (2009).
#### Minimal code to replicate
1. `iceGrowthDiagram`
The code will automatically set inputs, including the necessary basic hd structure.
#### Full code to replicate
1. `[hd] = makeGrowthDiagramStruct(1,1)`
2. `iceGrowthDiagram(hd,1,0,1,'southoutside',[0 0.6],[-56.5 0],0)`

### Ice growth diagram: vapor density excess
![Ice growth diagram with respect to water](Demo/igd_vde_applied.png)
For comparison to previous work, especially Kobayashi (1961), Furukawa and Wettlaufer (2007), or Libbrecht (2017).
#### Minimal code to replicate
1. `iceGrowthDiagramVaporExc`
The code will automatically set inputs, including the necessary basic hd structure.
#### Full code to replicate
1. `[hd] = makeGrowthDiagramStruct(1,1)`
2. `iceGrowthDiagramVaporExc(hd,1,0,1,'southoutside',[0 0.351],[-56.5],0)`

### Ice growth diagram: relative humidity with respect to water (textbook edition)
![Ice growth diagram with respect to water](Demo/igd_textbook.png)
This code can also be used to generate analogous images in terms of relative humidity with respect to ice or vapor density excess.
#### Code to replicate
1. `iceGrowthDiagramTextbook`
2. The code will prompt the user for a phase. Input `'water'` to obtain the diagram shown here.
3. The user will be prompted `Y/N` whether or not to save a PNG image. Enter `Y` to save, `N` to continue without saving.

## Converting between ice supersaturation and vapor density excess
Two common units of supersaturation are ice supersaturation (percent or decimal) or vapor density excess beyond ice saturation (g/m^3). Converting between the two units is possible, but not intuitive. Use `iceSupersatToVaporExc` to convert between these units.
### Example 
Given an ice supersaturation of 3.8% at -8 deg Celsius, what is the vapor density excess at the same temperature?  
1. `[vde] = iceSupersatToVaporExc(0.038,-8)`  
This returns `vde = 0.0962`. Thus a vapor density excess of 0.096 g/m^3 corresponds to an ice supersaturation of 3.8% at -8 deg Celsius!  

To convert from ice supersaturation to relative humidity with respect to water use `iceSupersatToRH`. For the reverse process, see `rhwToRhi`. To calculate vapor density excess from relative humidity with respect to water directly, use `rhwToVaporExc`.

## Repository description
### root
`makeGrowthDiagramStruct`: Creates a structure with the information needed to plot a growth diagram. Values are derived from Bailey and Hallett 2004 and Bailey and Hallett 2009.  
`iceGrowthDiagramWater`: Plots the ice growth diagram in terms of relative humidity with respect to water. Input options allow for control of diagram aesthetics, e.g. isohumes, ventilation, legend, etc.  
`iceGrowthDiagram`: Plots the ice growth diagram in terms of relative humidity with respect to ice. Input options allow for control of diagram aesthetics, e.g. isohumes, ventilation, legend, etc.  
`iceGrowthDiagramVaporExc`: Plots the ice growth diagram in terms of vapor density excess over ice saturation. Input options allow for control of diagram aesthetics, e.g. isohumes, ventilation, legend, etc.

### Helper functions subdirectory
`rhwToRhi`: Converts relative humidity with respect to water to relative humidity with respect to ice.  
`iceSupersatToRH`: Converts an ice supersaturation in percent to a relative humidity with respect to water, also in percent.   
`iceSupersatToVaporExc`: Converts an ice supersaturation in decimal to a vapor density excess in g/m^3.  
`rhwToVaporExc`: Converts a relative humidity with respect to water to vapor density excess in g/m^3.  
`eswLine`: Outputs arrays useful to draw isohumes with respect to water on the diagram.  
`updraftSupersat`: Uses the Twomey equation to calculate supersaturation in an updraft but only at a certain range of thermodynamic conditions well above freezing. Implemented as a curiosity.  
`ylimitsForIceDiagram`: Generates labels and tick marks for the ICAO atmospheric height approximation axis on the ice diagram.

### Growth diagram profiles subdirectory
`growthDiagramProfile`: Plots ice growth profiles for input radiosonde data. See the [IGRA v2](https://github.com/dmhuehol/IGRA-v2/) repository for information on radiosonde data.  
`stationLookupIGRAv2`: Looks up station names for titles of ice growth profiles.  
`IGRA v2 Station List.mat`: List of radiosonde launch site station names.  
`utqiagvik_sample.mat`: Sample data to make ice growth profiles.

### Demo subdirectory
`*.mat` files: Radiosonde data files used for in-progress paper "Revisiting diagrams of ice growth environments."  
`makeFigures`: Script used to make images for in-progress paper "Revisiting diagrams of ice growth environments."  
Image files in this directory are used in the Github readme.

## Growth diagram profiles
The function `growthDiagramProfile` can be used to plot data from radiosondes on the ice growth diagram. This shows what areas of the crystal growth space are accessible along a profile. A sample data structure from the Utqiagvik launch site is included in the "Growth diagram profiles" subdirectory. An example image is below.  
![Ice growth diagram profile from Jan 2018 in Barrow AK](Demo/utqiagvik_sample_readme.png)  
**Code to replicate**  
1. Open the sample Utqiagvik data in MATLAB  
2. Make sure `stationLookupIGRAv2` and `IGRA v2 Station List.m` are in the working directory. These are necessary to produce the title of the growth diagram profile.
3. `growthDiagramProfile(utqiagvik_sample,1:39,1,'water',0,0)`  
4. The command window will prompt for a date. Type `Jan 2018`.  
5. The command window will prompt for a location. Type `Utqiagvik, AK`.

Code to import a general IGRA v2 soundings data file can be found in the [IGRA v2](https://github.com/dmhuehol/IGRA-v2) repository.  

## Sources and Credit
**Bailey, M.P., & Hallett, J. (2004)**: Growth Rates and Habits of Ice Crystals between -20°C and -70°C. *Journal of the Atmospheric Sciences, 61*(5), 514-544. [doi.org/10.1175/1520-0469(2004)061%3C0514:GRAHOI%3E2.0.CO;2](https://doi.org/10.1175/1520-0469(2004)061%3C0514:GRAHOI%3E2.0.CO;2)  
**Bailey, M.P., & Hallett, J. (2009)**: A comprehensive habit diagram for atmospheric ice crystals: Confirmation from the laboratory, AIRS II, and other field studies. *Journal of the Atmospheric Sciences, 66*(9), 2888-2899. [doi:10.1175/2009JAS2883.1](https://doi.org/10.1175/2009JAS2883.1)  
**Furukawa, Y., and J. S. Wettlaufer, 2007**: Snow and ice crystals. *Physics Today, 60* (12), 70–71,485doi:10.1063/1.2825081, URL https://physicstoday.scitation.org/doi/10.1063/1.2825081.  
**Kobayashi, T., 1961**: The growth of snow crystals at low supersaturations. *Philosophical Magazine, 5326* (71), 1363–1370, doi:10.1080/14786436108241231, URL http://www.tandfonline.com/doi/533abs/10.1080/14786436108241231.  
**Libbrecht, K. G., 2017**:  Physical Dynamics of Ice Crystal Growth. *Annu. Rev. Mater. Res., 57147* (1), 271–295, doi:10.1146/annurev-matsci-070616-124135, URL https://doi.org/10.1146/572annurev-matsci-070616-124135, publisher: Annual Reviews.

All code and documentation written by Daniel Hueholt, under the advisement of Dr. Sandra Yuter at North Carolina State University.    
[<img src="http://www.environmentanalytics.com/wp-content/uploads/2016/05/cropped-Environment_Analytics_Logo_Draft.png">](http://www.environmentanalytics.com)  
This work was supported by the National Science Foundation (AGS-1347491 and AGS-1905736), the National Aeronautics and Space Administration (80NSSC19K0354), and the North Carolina State University Honors Program (Hueholt).  

Radiosonde data is from the [Integrated Global Radiosonde Archive, version 2](https://www.ncdc.noaa.gov/data-access/weather-balloon/integrated-global-radiosonde-archive).
