% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generateProblemList.R
\name{generateProblemList}
\alias{generateProblemList}
\title{Generate instances for EBO::optimizertuneRace()}
\usage{
generateProblemList(...)
}
\arguments{
\item{...}{[\code{EBO:: task()}]\cr
Task defines the problem setting.}
}
\value{
List of instances with different problems / tasks.
}
\description{
This functions enables users to create an instance list with different problems, which are
used for EBO::optimizertuneRace().
}
\examples{
\dontrun{
set.seed(1)

library(mlrMBO)
library(ParamHelpers)
library(mlr)

set.seed(1)

# define problem 1
data1 <- data.frame(a = runif(50,10,5555), b = runif(50,-30000,-500),
                   c = runif(50,0,1000))
data1$ratio <- rowSums(data1[,1:3]^2)
data1$ratio <- data1$ratio/max(data1$ratio)
colnames(data1) <- c("power", "time", "pressure","ratio")

psOpt = makeParamSet(

 makeIntegerParam("power", lower = 10, upper = 5555),

 makeIntegerParam("time", lower = -30000, upper = -500),

 makeIntegerParam("pressure", lower = 0, upper = 1000)
)

task1 = task(
 simulation = "regr.randomForest",
 data = data1,
 target = "ratio",
 psOpt = psOpt,
 minimize = FALSE
)


# define problem 2
data2 <- data.frame(a = runif(80,0,0.25), b = runif(80, 0,0.1),
                   c = runif(80,0,1), d = runif(80,0,1))
data2$interface <- rowSums((data2[,1:4]*8)^2)
data2$interface <- data2$interface/max(data2$interface)
colnames(data2) <- c("f", "k", "du","dv")


psOpt = ParamHelpers::makeParamSet(
 ParamHelpers::makeNumericParam("f", lower = 0, upper = 0.25),
 ParamHelpers::makeNumericParam("k", lower = 0, upper = 0.1),
 ParamHelpers::makeNumericParam("du", lower = 0, upper = 1),
 ParamHelpers::makeNumericParam("dv", lower = 0, upper = 1)
)

task2 = task(
 simulation = "regr.randomForest",
 data = data2,
 target = "interface",
 psOpt = psOpt,
 minimize = FALSE
)


################## Define problemList #############

problemList = generateProblemList(task1, task2)
}
}
