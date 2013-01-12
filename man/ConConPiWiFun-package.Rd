\name{ConConPiWiFun-package}
\alias{ConConPiWiFun-package}
\alias{ConConPiWiFun}
\alias{Sum}
\alias{cplfunction}
\alias{Rcpp_cplfunction-class}
\alias{plot-methods}
\alias{plot,ANY-method}
\alias{plot,Rcpp_cplfunction-method}
\alias{show-methods}
\alias{show,ANY-method}
\alias{show,Rcpp_cplfunction-method}
\docType{package}
\title{
This package contains an implementation of continuous convex piecewise (linear) functions (quadratic coming soon)
}
\description{
Continuous convex piecewise linear (ccpl) resp. quadratic (ccpq) functions can be implemented with sorted breakpoints and slopes. This includes functions that are ccpl (resp. ccpq) on a convex set (i.e. an interval or a point) and infinite out of the domain. These functions can be very usefull for a large class of optimisation problems. Efficient manipulation (such as log(N) insertion) of such data structure is obtained with map standard template library of C++ (that hides balanced trees). This package is a wrapper on such a class based on Rcpp modules. 
}
\details{
\tabular{ll}{
Package: \tab ConConPiWiFun\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-01-08\cr
License: \tab GPL\cr
}
~~ An overview of how to use the package, including the most important ~~
~~ functions ~~
}
\author{
Robin Girard

Maintainer: <robin.girard@mines-paristech.fr>
}
\references{
Related Papers are  
}
\keyword{Optimisation, Dynamic programming}

\examples{
library(ConConPiWiFun)
##
#Construction of a piecewise linear function
##
Slopes=c(-1,2) # increasing ! convexity is required
Breakpoints=c(-Inf,2,4) # increasing. length is number of slopes +1
FirstNonInfBreakpointVal=3
CCPWLfunc1=new(cplfunction,Slopes,Breakpoints,FirstNonInfBreakpointVal)
plot(CCPWLfunc1) #visualisation method
CCPWLfunc1$get_BreakPoints_() ## return Breaks AND Slopes

###Etoile transformation (legendre transform of f)
# Changes f + returns the results !
plot(CCPWLfunc1$Etoile())  #if f = CCPWLfunc1 CCPWLfunc1 becomes is f^*(y) =inf_x {xy-f(x)}
plot(CCPWLfunc1$Etoile())  ## (f^*)^* is f !
                           
###Squeeze function 
# Changes f, no return!
left=-1; right=4
CCPWLfunc1$Squeeze(left,right) # CCPWLfunc1 is now infinite (or not definite) out of [left,right]
# i.e. all breakpoints out of [left,right] removed


###Swap function 
# Changes f  + returns the results !
y=2
plot(CCPWLfunc1$Swap(y)); #now f = CCPWLfunc1 is replaced by x -> f(y-x) 

### Sum function (uses fast insertion) do not affect operands 
CCPWLfunc1=new(cplfunction,c(-1,2) ,c(-Inf,2,4),0)
CCPWLfunc2=new(cplfunction,c(-1,2),c(-Inf,1,3),0)
CCPWLfunc1plus2=Sum(CCPWLfunc1,CCPWLfunc2)
par(mfrow=c(1,3))
plot(CCPWLfunc2,col='red'); 
plot(CCPWLfunc1,col='blue'); 
plot(CCPWLfunc1plus2);

#### Infconvolution application is let as an exercise for students of Master REST. Will be in further version

#### dynamic programming application is let as an exercise for students of Master REST. 
# e.g it can be used to solve the optimisation the following optimisation 
# problem with "storage constraints"  in n*log(n) time ! Will be in further version of the package
# 						min_x sum_i=1^n pi_ix_i
#                   lb_i<=	x_i				<=ub_i 		i=1,...,n
#					clb_i<=	sum_j=1^i x_j	<=clb_i 	i=1,...,n

}
