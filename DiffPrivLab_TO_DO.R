# Install the release version of diffpriv from CRAN:
install.packages("diffpriv")

# Install the latest development version of diffpriv from GitHub:
install.packages("devtools")
devtools::install_github("brubinstein/diffpriv")

#Now we create the data
#TO DO


# a target function we'd like to run on private data
# we will use the identity function 
#TO DO


# target seeks to release a numeric, so we'll use the Laplace mechanism(could be gaussian)
# a standard generic mechanism for privatizing numeric responses
library(diffpriv);

#TO DO


# set a dataset sampling distribution, then estimate target sensitivity with
# sufficient samples for subsequent mechanism responses to achieve random
# differential privacy with confidence 1-gamma
# in the sampler n MUST be equal to length(data)
# TO DO


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
#TO DO (target function)


# New vector to save new outcomes

data2=vector();

# TO DO (percentError Function)


mech = DPMechLaplace(target = target2);
mech <- sensitivitySampler(mech, oracle = distr, n = length(data), gamma = 0.1);

#Loop to try different epsilons 
#TO DO


 

