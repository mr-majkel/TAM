

#######################################################################
# tamaan 3PL trait module
tamaan.3pl.trait <- function( res0 , anal.list , con , ... ){

		gammaslope <- NULL
		notA <- res0$notA
		if (is.null(notA) ){ notA <- FALSE }
		delta.inits <- res0$delta.inits					


		res <- tam.mml.3pl(resp= res0$resp , 
						E=res0$E , 
						skillspace= res0$skillspace , 
						theta.k= res0$theta.k , 
						gammaslope=gammaslope , 
						gammaslope.fixed = res0$gammaslope.fixed , 
						gammaslope.des = res0$gammaslope.des , 
						variance.fixed=res0$variance.fixed , 	
						guess=res0$guess , 
						est.guess=res0$est.guess , 		
						guess.prior = res0$guess.prior , 
						notA= notA , 
						# est.variance = FALSE , 
						delta.inits = delta.inits ,  
						control=con , 
						... )
									
					
		res$tamaan.method <- "tam.mml.3pl"
        return(res)
			}
#######################################################################

