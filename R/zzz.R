# TODO: Add comment
# 
# Author: robin
###############################################################################

loadModule("mod_cplfunction", TRUE)
evalqOnLoad({
setMethod( "plot", signature(x="Rcpp_cplfunction",y="ANY") , function(x,y,...) {      
            firstBreakVal=x$FirstBreakVal_;
            tmp=x$get_BreakPoints_();
            if (tmp$Breakpoints[1]==-Inf){
                tmp$Breakpoints[1]=tmp$Breakpoints[2]-1;
                firstBreakVal=   firstBreakVal -tmp$Slopes[1];           
            }
            if (tmp$Breakpoints[length(tmp$Breakpoints)]==Inf){
                tmp$Breakpoints[length(tmp$Breakpoints)]=tmp$Breakpoints[length(tmp$Breakpoints)-1]+1
            }
            xx=tmp$Breakpoints; 
            yy=array(NA,length(xx));
            yy[1]=firstBreakVal;
            for (i in 2:length(yy)){
                yy[i]=yy[i-1]+tmp$Slopes[i-1]*(tmp$Breakpoints[i]-tmp$Breakpoints[i-1]);
            }
            plot(xx,yy,type='l',...);
        } )

setMethod( "show", "Rcpp_cplfunction" , function(object) {      
  cat('\n')
  cat('Value of f at first non infinite break: ',object$FirstBreakVal_,'\n');
  print(object$get_BreakPoints_());
} )

})