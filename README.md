# nimble-lisbon-2022
Materials for the NIMBLE workshop in Lisbon, June 1-3, 2022. 

To prepare for the workshop:

 - Install NIMBLE (see below)
 - Install additional packages (see below)
 - Download these materials (and check back before the workshop on Wednesday June 1 for updates)

All materials for the workshop will be in this GitHub repository. If you're familiar with Git/GitHub, you already know how to get all the materials on your computer. If you're not, simply click [here](https://github.com/nimble-training/nimble-lisbon-2022/archive/main.zip).

There is some overview information [here](https://htmlpreview.github.io/?https://github.com/nimble-training/nimble-lisbon-2022/blob/main/overview.html), including links to the content modules in order.


## Tentative Schedule

Day 1 (Wednesday June 1; 9h-12:30h and 14h-17h):   

- Introduction to NIMBLE
- Writing models in NIMBLE
- Comparing and customizing MCMC methods
- Strategies for improving MCMC
- Writing your own functions and distributions for NIMBLE models

Day 2 (Thursday June 2; 9h-12:30h and 14h-17h):
- Introduction to programming algorithms (using nimbleFunctions) in NIMBLE
- Model selection and Bayesian nonparametrics
- Advanced algorithm programming (writing your own MCMC sampler, calling out to R and C++, and more)
- Spatial modeling

Day 3 (Friday June 3; half day 9h-12:30h):

- Spatial modeling
- State space models
- Special topics based on participant interests and discussion of participants' research projects 
- (Time permitting) Sequential Monte Carlo and particle MCMC

## Help with NIMBLE

Our user manual is [here](https://r-nimble.org/html_manual/cha-welcome-nimble.html).

We have a 'cheatsheet' [here](https://r-nimble.org/documentation).

For those of you who are not already familiar with writing models in WinBUGS, JAGS, or NIMBLE, you may want to look through the first module (Introduction to NIMBLE) or Section 5.2 of our user manual in advance.

I'm happy to answer questions about writing models as we proceed through the workshop, but if you have no experience with it, reviewing in advance will greatly lessen the odds you feel lost right at the beginning.

## Installing NIMBLE

NIMBLE is an R package on CRAN, so in general it will be straightforward to install as with any R package, but you do need a compiler and related tools on your system.  

In summary, here are the steps.

1. Install compiler tools on your system. [https://r-nimble.org/download](https://r-nimble.org/download) has more details on how to install *Rtools* on Windows and how to install the command line tools of *Xcode* on a Mac. Note that if you have packages requiring a compiler (e.g., *Rcpp*) on your computer, you should already have the compiler tools installed.

2. Install the *nimble* package from CRAN in the usual fashion for an R package. More details (including troubleshooting tips) can also be found in Section 4 of the [NIMBLE manual](https://r-nimble.org/html_manual/cha-installing-nimble.html).

3) To test that things are working please run the following code in R:

```
library(nimble)
code <- nimbleCode({
  y ~ dnorm(0,1)
})
model <- nimbleModel(code)
cModel <- compileNimble(model)
```


If that runs without error, you're all set. If not, please see the troubleshooting tips and email nimble.stats@gmail.com directly if you can't get things going.  

In general we encourage you to update to the most recent version of NIMBLE, 0.12.2.


#### (Not required) Development version(s) of NIMBLE

Sometimes we make an update or new feature available on a github branch before it is released.  In the event a need arises to install from a branch, you can do so as follows (for branch "devel"):

```
library(remotes)
install_github("nimble-dev/nimble", ref = "devel", subdir = "packages/nimble")
```

## Installing additional packages

Some of the packages we will use (beyond those automatically installed with `nimble`) can be installed as follows:

```
install.packages(c("mcmcplots", "CARBayesdata", "sp", "spdep", "classInt", "coda"))
```

`compareMCMCs` is a package in development that is not yet on CRAN:

```
library(remotes)
install_github("nimble-dev/compareMCMCs", subdir = "compareMCMCs")
```

Windows users will probably need to use this invocation:

```
library(remotes)
install_github("nimble-dev/compareMCMCs", subdir = "compareMCMCs", INSTALL_opts = "--no-multiarch")
```

