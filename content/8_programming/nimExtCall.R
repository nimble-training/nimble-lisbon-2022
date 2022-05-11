
# Calling external C/C++ code



Cquantile <- nimbleExternalCall(
    function(x = double(1), probs = double(1),
             out = double(1), n = integer(), k = integer()){},
    Cfun =  'my_quantile_function',
    headerFile = file.path(getwd(), 'test.h'), returnType = void(),
     oFile = file.path(getwd(), 'test.o'))


system('g++ test.cpp -c -o test.o')

test <- nimbleFunction(
    setup = function(model) {},
    run = function() {
        x <- rnorm(50)
        p <- c(.05,.5,.95)
                                        #out <- numeric(3)
        out <- rep(0,3)
        Cquantile(x, p, out, 50, 3)
        print(out)
    })

rtest <- test(model)
ctest <- compileNimble(rtest, project = model, resetFunctions = TRUE)
ctest$run()
   



ppSamplerQ <- nimbleFunction(
          setup = function(model, mcmc, dataNodes) {
                parentNodes <- model$getParents(dataNodes, stochOnly = TRUE)
                calcNodes <- model$getDependencies(parentNodes, self = FALSE)
                vars <- mcmc$mvSamples$getVarNames()  # need ordering of variables in mvSamples / samples matrix
                nData <- length(model$expandNodeNames(dataNodes, returnScalarComponents = TRUE))
          },
          run = function(samples = double(2), probs = double(1)) {
              niter <- dim(samples)[1]
              ppSamples <- matrix(nrow = niter, ncol = length(probs))
              for(i in 1:niter) {
                    probsTemp <- probs  # or use ppSamples
                    values(model, vars) <<- samples[i, ]
                    model$simulate(calcNodes, includeData = TRUE)
                    tmp <- values(model, dataNodes)
                    Cquantile(tmp, probsTemp)
                    ppSamples[i, ] <- probsTemp
              }
              return(ppSamples)
              returnType(double(2))
          })



