# Documentation

Notes about internal fimplementation of package:

The package is currently build on R6. The R6 provides a generic oop experience which is quite similar to what is  implemented in other languages. Each optimizer is given has its own class which contains methods to accommodate that optimizers' specific need. Every optimizer is derived from a base class called optimizer_wrapper which has common procedures which are used my every optimizer specific class.

The package has two user ended function global_wrapper and sopm. The global_wrapper calls single optimizer and sopm calls multiple optimizer at once. The global_wrapper calls the optimizer specific local wrappers which handles the rest of the work.

Local wrapper creates a layer of abstraction and makes it easy to handle things. It is the responsibility of local wrapper to run a specific optimizer correctly. It does so by making an object of optimizer specific class and manipulating that object by calling class methods.

## 1. optimizer_class (the base class)

The class the following fields / variables.

    ans      
    par      
    fn       
    lower    
    upper    
    method   
    vcontrol    
    trace    
    control  

## **The class methods are :-**

### a) constuctor / initialize

initialize - it is the constructor method of R6 which is run upon object creation and accepts the basic parameters.

### b) check installation

checkinstallation - checks if the specific optimizer can be loaded on the local machine.

### c) translate control

translatecontrol - converts the global control parameters to local control parameter. Uses the names provided in vcontrol for example:- 

`vcontrol = c(popsize = "NP") `
Here the popsize (global control parameter) is being converted to "NP" (local control parameter)

### d) check control

checkcontrol - checks if all the passed control parameters are correct. Else it stops the program and writes which control parameters in not recognized.

### e) change default control

changedefaultcontrol - changes the generated default control to the ones provided. 

---

# How global_wrapper works

The `global_wrapper()` is an aggrigation of wrappers of a number of sochastic optimizers which are available in CRAN repositories. The optimizers are not called directly but are invoked via local optimizers which abstracts away complexity so that the structure of `global_wrapper()` remains simple. The individual optimizers are selected by a `switch()` which uses the argument `method` in the call to `global_wrapper()`. The global_wrapper does simple checks on if the method is available? the function passed is indeed a function, etc.

# Add a new optimizer

There are three files involved in adding a new optimizer:-

1. global_wrapper.R

2. local_wrapper.R

3. A new file to be created which will contain `R6Class` of the optimizer. The name of the file will be in format "name_of_optimizer_wrapper.R"

But first we need to make sure that the new function is available, that is, the package containing it is installed.

we need to carry out the following in :- 

1. global_wrapper:-
   
   - Include the function name in `method_list` which is present in `global_wrapper.R`
   
   - Add an appropriate switch case to select the new method.
   
   - inside the swtich case call the `optimizers' local_wrapper()` function.
   
   - return the standard answer list back to the user.

2. local_wrapper :-
   
   - declare the optimizers local wrapper function 
   - inside the local wrapper function make an object of optimizers' R6 wrapper class
   - invoke all the required methods of the class sequentially in correct order. (for this refer to the internal doc)
   - return the the standard answer list back to the `global_wrapper`.

3. new_class_name_of_the_optimizer_wrapper.R :-
   
   - make a new R6 class give it a proper name( refer class names of other optimizer).
   - inherit optimizer_wrapper class (this class contains useful fields and methods so that we don't have to write those functionalities  again.)
   - write a correct initialize function.
   - decalare a `vcontrol` character vector which should contain the correct control parameters names. These would latter be used to verify if the correct control parameters have be passed or not.
   - decalre any other variable as per the need of  new optimizer 
   - overrite the default methods of optimizer_wrapper as needed.
   - decalre new methods if required to ensure correct working of the new optimizer. (there may be a situation where a new case may arrive which has not been handled before)
   - run the optimizer in a seperate function named `calloptimizer()`
   - return a standard list of values back to the `optimizers' local_wrapper()`.

# How sopm works

`sopm()` is meant for running multiple methods one after the other. It is built upon `global_wrapper()`which is called in a loop and than a final data frame is created which encompases the results of all the mehtods.  `sopm` is extremely useful for comparing methods easily. I caution that it is not an efficient way to run problems, even though it can be extremely helpful in deciding which method to apply to a class of problems. 

# Nested control list in sopm

sopm is required to call multiple methods and these methods can take specific control parameters which might not be common with other methods. In order to pass these specific controls a nested list is used. For example : -

 ```control <- list(maxiter = 100, DEoptim = list(tol = 1e-10), GenSA = list(maxiter = 200))```

In the above example the specific controls to DEoptim is passed via nested list `DEoptim = list (tol = 1e-10)` where we are setting the tolerance, similarly we can set specific controls for other optimizers.

Interesting thing to note is that maxiter is common between both the methods and this parameters will be added to both the lists i.e. DEoptim and GenSA but GenSA has maxiter specificly defined for it thus this specifically defined maxiter control will take precedence. Thus at the end for all practical purposes the internal view of the control list would be:-

`control <- list(DEoptim = list(tol = 1e-10, maxiter = 100,), GenSA = list(maxiter = 200))`

# Trace

Trace is perhapes the only control parameter which has the most varied implementation and still present in nearly every single optimizer package. Because of this the trace has to be customized for each method seperatly. For stochoptim it is decided that trace should have upto 5 levels. Each level decided how much informations is printed on the screen when the optimizer is running. Higher the level of trace higher the volume of information printed on screen. When the trace = 0 no information is printed and when it is 5 information is printed at each step.

## Trace implementation for DEoptim:

trace = 0 : no information is printed

trace = 1 : the standard return list is printed

trace = 2 : 25 % of information is printed

trace = 3 : 50 % of informations is printed

trace = 4 : 75 % of information is printed

trace = 5 : 100% of the information is prined.

# Testing the package

The package has to tested for various features and errors. Features must be tested to see if they are working properly plus any new changes must not break the old features. The expected errors must also be tested to prevent any unwanted behaviour of the package. 
