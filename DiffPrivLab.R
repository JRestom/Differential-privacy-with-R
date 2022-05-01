# Install the release version of diffpriv from CRAN:
install.packages("diffpriv")

# Install the latest development version of diffpriv from GitHub:
install.packages("devtools")
devtools::install_github("brubinstein/diffpriv")

#Now we create the data

data = rnorm(10,mean = 100, sd = 30)

# a target function we'd like to run on private data
# we will use the identity function 
target1 = function(X) X;

# target seeks to release a numeric, so we'll use the Laplace mechanism(could be gaussian)
# a standard generic mechanism for privatizing numeric responses
library(diffpriv);
mech = DPMechLaplace(target = target1);

# set a dataset sampling distribution, then estimate target sensitivity with
# sufficient samples for subsequent mechanism responses to achieve random
# differential privacy with confidence 1-gamma
# in the sampler n MUST be equal to length(data)
distr <- function(n) rnorm(n);
mech <- sensitivitySampler(mech, oracle = distr, n = length(data), gamma = 0.1);

r = releaseResponse(mech, privacyParams = DPParamsEps(epsilon = 1), X = data)

# Finally we want to see how much epsilon affects the outcome
# so in order to do this we will use mean as our target (Query) and we will
# plot the percent error vs epsilon for each column 

plot(data,main="Before and after diffpriv",ylab="Data")
lines(data)
lines(r$response,col="red")
points(r$response,col="red")
legend("topleft",
       c("Before","After"),
       fill=c("black","red")
)

# Now we want to see how much epsilon affects our outcome
# To do this we will use mean as our target function (Query)
# and we will plot epsilon vs percent error

target2 = function(X) mean(X)

# New vector to save new outcomes

data2=vector();

percentError=function(oldValue,newValue){
  return (100*(abs(oldValue-newValue)/oldValue));
}

mech = DPMechLaplace(target = target2);
mech <- sensitivitySampler(mech, oracle = distr, n = length(data), gamma = 0.1);

#Loop to try different epsilons 
x=seq(0.01,100,0.1)
for(epsi in x){
  r = releaseResponse(mech, privacyParams = DPParamsEps(epsilon = epsi), X = data)
  data2=c(data2,1-percentError(mean(data),r$response))
}

plot(x,data2,log="x",type="l",main="Precision vs epsilon",ylab="Error",xlab="epsilon")

 

