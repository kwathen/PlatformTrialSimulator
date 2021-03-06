% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/InitializeISARandomizer.R
\name{InitializeISARandomizer.DelayedStartRandomizer}
\alias{InitializeISARandomizer.DelayedStartRandomizer}
\title{InitializeISARandomizer.DelayedStartRandomizer}
\usage{
\method{InitializeISARandomizer}{DelayedStartRandomizer}(cISARandomizer, dISAStartTime)
}
\arguments{
\item{cISARandomizer}{cISARandomizer$mTreatmentStartTimes identifies how to simulate/assign the start time of each of the treatments (doses) in the ISA.
 Since cISARandomizer$mTreatmentStartTimes is not required by other randomizer so this function will stop if it is not defined.
 The nrow( cISARandomizer$mTreatmentStartTimes  ) = number of treatments in the ISA.
 cISARandomizer$mTreatmentStartTime should have 2 columns, 1 to define the lower limit of the start time and column 2 the potential max
 such that a time is simulated from a Uniform( cISARandomizer$mTreatmentStartTimes[i, 1], cISARandomizer$mTreatmentStartTimes[,2])
 for each treatment.
cISARandomizer$mTreatmentStartTimes  is to specify the time >= 0 that a treatment in the ISA is opened.  A value of 0 in column 1 and 2 indicates
the treatment is open once the ISA is added to the trial.}

\item{dISAStartTime}{The time the ISA is added to the platform.  All arms are opened at time >= dISAStartTime}
}
\description{
{This version will randomize the first patients to a select set of arms or doses in the ISA (eg a POC phase)
 The remaining arms or doses are opened based on the provided times to open.}
}
\seealso{
{ \href{https://github.com/kwathen/OCTOPUS/blob/master/R/InitializeISARandomizer.R}{View Code on GitHub} }
}
