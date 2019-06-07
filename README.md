# Platform Trial Simulator 

[![Coverage Status](https://img.shields.io/codecov/c/github/kwathen/PlatformTrialSimulator/master.svg)](https://codecov.io/github/kwathen/PlatformTrialSimulator?branch=master)
[![Travis-CI Build Status](https://travis-ci.org/kwathen/PlatformTrialSimulator.svg?branch=master)](https://travis-ci.org/kwathen/PlatformTrialSimulator)
 
## License 
This package is governed by the JRD Platform Trial Simulation License, which is the GNU General Public License V3 with additional terms. The precise license terms are located in [LICENSE](https://github.com/kwathen/PlatformTrialSimulatorP/blob/master/inst/LICENSE) and [GPL](https://github.com/kwathen/PlatformTrialSimulatorP/blob/master/inst/GPL).


## Introduction
This project is designed to help clinical trial designers simulate a platform trial.   This project is intended for simulation purposes only.  For the purposes of this project and R code base a platform trial is a clinical trial designed to accommodate multiple treatments or interventions added to the trial either at the beginning of the trial or any time thereafter.   Each intervention is added through an Intervention Specific Appendix (ISA).  Each ISA typically randomizes between placebo or control and one or more intervention doses (or combinations).  If trials for multiple interventions in the same disease area are considered, then a platform trial provides a unified framework for designing and running a single, multiple ISA, platform trial.  Potential benefits of a platform trial are shorter more efficient trials due to a single framework for multiple interventions and borrowing of placebo or control patients across ISAs thus reducing the overall number of patients treated with placebo/control.  

In order to simulate a platform trial using this package you must specify two structures: 1) Trial Design - this structure specifies details such as the number of ISAs, number of patients for each ISA/treatment, analysis method(s) and trial monitoring scheme, 2) Simulation Design - this structure specifies how to simulate all aspects of the trial such as patient outcomes, patient accrual rates and when ISAs enter the platform.  Each of the structures will be details in the sections below. 

To help increase flexibility and allow for new additions to be added by the users, S3 class and generic methods are implemented.  Many aspects can be extended such as new types of analysis, simulation of outcomes and randomization schemes.  For users not familiar with S3 or generic functions, please refer to the example document [Example S3 Generic Methods](https://github.com/kwathen/PlatformTrialSimulator/blob/master/ExampleS3Class.R).

This package is under development and is working and has been used to simulate several trials.  As case studies are created they will be added to the Examples directory of the package to help users create the necessary structures.  The tar.gz files in this repository are included as testing versions for beta testers as new updates are added. 

Please follow this project to be notified of updates.   

# Trial Design Structure
A platform trial requires 2-step randomization, first the the ISA and then between the treatments within and ISA, including control/placebo.  The first step is considered the trial randomizer and the 2nd is considered the ISA randomizer and each ISA may randomize different within an ISAs.  

The trial design object is a structure with a class name equal to the desired trial randomizer.   For example,

cTrialDesign <- structure( list(  ), class='EqualRandomizer')

would create the trial design object where patients are equally randomized between ISAs.  The list( ) in the structure would contain information about the platform, such as the number of ISAs, number of patients on each ISA, ect.   Within the list is also a collection of ISA elements to define the specifics of each ISA.  More details of this object are presented in the documentation and examples.  In general, the ISAs may differ as much as needed, however, if ISAs differ too much the advantages of a platform are minimized.  
# Simulation Design Structure 

The simulation design object contains two pieces, the first is the trial design, described in the previous section, and the simulation object.  The simulation object contains a list of scenarios, such as the null and alternative, to simulate.    

# To Do List

- [ ] In the R Shiny App to compare recruitment (R/RecruitmentComparitor.R)  the function ComputeMonthlyAccrual improves the AccrualMethods class by allowing the ramp up to be on a per site basis.  Move this functionality to the general class so it can be used in simulation.
