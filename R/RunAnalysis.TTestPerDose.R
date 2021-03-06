##### COPYRIGHT #############################################################################################################
#
# Copyright (C) 2018 JANSSEN RESEARCH & DEVELOPMENT, LLC
# This package is governed by the JRD OCTOPUS License, which is the
# GNU General Public License V3 with additional terms. The precise license terms are located in the files
# LICENSE and GPL.
#
#############################################################################################################################.

#' @seealso { \href{https://github.com/kwathen/OCTOPUS/blob/master/R/RunAnalysis.TTestPerDose.R}{View Code on GitHub} }
#' @export
RunAnalysis.TTestPerDose <- function( cAnalysis, lDataAna,  nISAAnalysisIndx, bIsFinalISAAnalysis, cRandomizer  )
{
    #print( "RunAnalysis.TTestPerDose ")

    lCI      <- GetCILimits(  cAnalysis, nISAAnalysisIndx, bIsFinalISAAnalysis )
    dLowerCI <- lCI$dLowerCI
    dUpperCI <- lCI$dUpperCI

    dCILevel <- dUpperCI - dLowerCI

    # Assuming 1 is the control treatment
    vUniqT      <- sort(unique( lDataAna$vTrt ))
    vTrt        <- vUniqT[ vUniqT != 1 ]

    nQtyDoses <- length( vTrt )
    lAllRet   <-  structure( list(), class=class( cAnalysis))
    lRet2     <- list()  #List of details info to return
    for( iTrt in vTrt  )
    {
        nQty0 <- length( lDataAna$vOut[lDataAna$vTrt==1] )
        nQty1 <- length( lDataAna$vOut[lDataAna$vTrt==iTrt] )

        #print( paste( "n placebo: ", nQty0, ", n trt ", iTrt, ", ", nQty1))
        if( nQty0 >5 && nQty1 > 5 )
        {

            if( dLowerCI  == 1 - dUpperCI )  #Symetreical CI so only need to do the test once to get the desired CI
            {

                lTTest  <- t.test(lDataAna$vOut[lDataAna$vTrt==1 | lDataAna$vTrt==iTrt ] ~ as.factor(lDataAna$vTrt[ lDataAna$vTrt==1 | lDataAna$vTrt==iTrt ]), alternative = c("two.sided"),mu = 0, exact = NULL, correct = TRUE,  conf.int = TRUE, conf.level = dCILevel)
                dEst   <- lTTest["estimate"]$estimate[[1]] - lTTest["estimate"]$estimate[[2]] #pbo- trt
                dLower  <- lTTest["conf.int"]$conf.int[[1]]
                dUpper  <- lTTest["conf.int"]$conf.int[[2]]
            }
            else
            {  #Get the CI for the Lower Limit
                dCILevel <- 1 - 2*dLowerCI

                lTTest  <- t.test(lDataAna$vOut[lDataAna$vTrt==1 | lDataAna$vTrt==iTrt ] ~ as.factor(lDataAna$vTrt[ lDataAna$vTrt==1 | lDataAna$vTrt==iTrt ]), alternative = c("two.sided"),mu = 0, exact = NULL, correct = TRUE,  conf.int = TRUE, conf.level = dCILevel)
                dEst   <- lTTest["estimate"]$estimate[[1]] - lTTest["estimate"]$estimate[[2]] #pbo- trt
                dLower  <- lTTest["conf.int"]$conf.int[[1]]

                #Get the Upper Limit
                dCILevel <- 1 - 2*(1 - dUpperCI)

                lTTest  <- t.test(lDataAna$vOut[lDataAna$vTrt==1 | lDataAna$vTrt==iTrt ] ~ as.factor(lDataAna$vTrt[ lDataAna$vTrt==1 | lDataAna$vTrt==iTrt ]), alternative = c("two.sided"),mu = 0, exact = NULL, correct = TRUE,  conf.int = TRUE, conf.level = dCILevel)
                dUpper  <- lTTest["conf.int"]$conf.int[[2]]


            }

            lRet <- MakeDecisionBasedOnCI( dLower, dUpper, cAnalysis )
        }
        else
        {
            dEst <- NA
            dLower <- NA
            dUpper <- NA
            lRet <- list( nGo =0, nNoGo = 0, nPause = 1)
        }

        lRet2[[paste( "lRet", iTrt,sep="")]] <- list( nGo = lRet$nGo, nNoGo = lRet$nNoGo, nPause = lRet$nPause, dEst = dEst, dCILower = dLower, dCIUpper = dUpper )

        lAllRet[[ paste( "lRet", iTrt,sep="")]] <- lRet



    }
    lRetObj <- MakeDecisionDoses( lAllRet )


    if(!is.null(cAnalysis$nVerboseOutput) && cAnalysis$nVerboseOutput== 1)
    {
        lRetObj[["lRet2"]] <- lRet2
    }

    lRetObj$cRandomizer <- cRandomizer
    #print( paste( "CI ", dLower, " ", dUpper, " TV ", lAnalysis$dTV, " ", nSuccess, " ", nFutility, " ", nPause ))

    #return( list( nSuccess = nSuccess, nFutility = nFutility, nPause = nPause,
    #              dPlac12 = lTTest$estimate[[1]], dTrt12 = lTTest$estimate[[2]],
    #              dCILow = dCILow, dCIUp = dCIUp))
    return( lRetObj )

}
