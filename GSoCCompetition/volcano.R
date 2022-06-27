x = seq(0,15, 0.2)
y = seq(0,15, 0.2)
a = c(5,8)
b = c(0.2, -0.1)
hc <- function(x, y) {
   d = sqrt((x-1)^2+(y-5)^2) # distance from (1,5)
   val = (10-.5*d)+sin(2*d)
}
#ht <- function(x, y, a, b) { # gives errors
#   d = sqrt((x-1)^2+(y-5)^2) # distance from (1,5)
#   val<-0
#   if(y<(a[1]+b[1]*x)) val <-10000
#   if(y>(a[2]+b[2]*x)) val <-10000
#   val <- val + (10-.5*d)+sin(2*d)
#}
z<-outer(x, y, hc)
contour(x, y, z)
abline(5, 0.1)
abline(8, -0.2)
par(lty="dashed")
abline(8, -0.4)
title("jnwave function with constraint lines")
# dev.print(postscript, file="/tmp/jnwavec01.eps", horizontal=FALSE,
#           onefile=FALSE, paper="special")


X11()
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
           ltheta = 120, shade = 0.75, ticktype = "detailed",
           xlab = "X", ylab = "Y", zlab = "Z") 

#dev.print(postscript, file="/tmp/jnwavep01.eps", horizontal=FALSE,
#           onefile=FALSE, paper="special")

