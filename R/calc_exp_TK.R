
#############################################################
calc_exp_TK <-
function(rprobs , A , itemwt , p , ip , 
                        nitems , resp.ind){
  #... TK: multiple category option -> na.rm = TRUE    
  xbari <- sapply(ip, function(i) colSums(A[i,,p] * rprobs[i,,] , na.rm = TRUE))
  #... TK: multiple category option -> na.rm = TRUE
  xxfi <- sapply(ip, function(i) colSums(A[i,,p]^2 * rprobs[i,,] , na.rm = TRUE))
#*** ARb 2013-04-30: Write these loops more efficient in C.
# Note that outside of the loop the operations are
#        xbar[p] <- sum(res$xbar)
#        xxf[p] <- sum(res$xxf)
#        xbar2[p] <- sum( res$xbar2 )
# Therefore, one can simply use the sum score of xbar, xxf
# and xbar2 inside the C function.
  xbar <- rowSums(xbari * itemwt[,ip]) 
  xxf <- rowSums(xxfi * itemwt[,ip])
  xbar2 <- rowSums(xbari^2 * itemwt[,ip])
  
  return(list("xbar" = xbar, "xxf" = xxf, "xbar2" = xbar2))
}
# This function is not used anymore.
###########################################################

###########################################################
# faster version of calc_exp_TP3
calc_exp_TK3 <- function( rprobs , A , np , est.xsi.index , itemwt ,
	indexIP.no , indexIP.list2 ){
	CC <- dim(rprobs)[2]
	TP <- dim(rprobs)[3]
	NXSI <- dim(A)[3]
	NI <- dim(A)[1]
	# restructure rprobs and AL
	rprobsL <- matrix( rprobs , NI*CC , TP )
	AL <- matrix( A , NI*CC , NXSI )	
	AL[ is.na(AL) ] <- 0
	rprobsL[ is.na(rprobsL) ] <- 0
	# call Rcpp code
#	res <- tam.calcexp( np , rprobsL , AL ,	indexIP.no , indexIP.list2 , 
#			est.xsi.index , CC , itemwt)
	res <- .Call( "TAM_CALCEXP" , np , rprobsL , AL ,	indexIP.no , 
			indexIP.list2 , est.xsi.index , CC , itemwt , PACKAGE="TAM" )
	return(res)
		}
		
##------		
