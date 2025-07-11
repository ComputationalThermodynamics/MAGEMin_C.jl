
# MAGEMin installation (C-library) {#MAGEMin-installation-C-library}

## Linux {#Linux}
<img src="../assets/ubuntu.png" alt="Ubuntu Logo" width="64" align="right">


### C and Fortran Compilers {#C-and-Fortran-Compilers}

Using either `gcc` or `clang` to compile MAGEMin is up to you as the runtime performances are similar. However, in the event you want to modify MAGEMin for your own use, I would advise that you compile MAGEMin with `clang` as the error handling system is more strict, which will save you from unexpected segmentation faults.

```
sudo apt-get install gcc
sudo apt-get install clang
sudo apt-get install gfortran
```


### Open MPI (Message Passing Interface) {#Open-MPI-Message-Passing-Interface}

```
sudo apt-get install openmpi-bin libopenmpi-dev
```


::: tip Note

`mpich` can equally be used.

:::

### LAPACKE (C version of the Fortran LAPACK library) {#LAPACKE-C-version-of-the-Fortran-LAPACK-library}

```
sudo apt-get install liblapacke-dev
```


### NLopt (Non-Linear Optimization Library) {#NLopt-Non-Linear-Optimization-Library}

First, `cmake` must be installed on your machine:

```
sudo apt-get install cmake
```


Then `NLopt` can be installed using:

```
sudo apt-get install libnlopt-dev
```


Alternatively, `NLopt` can be downloaded and installed manually:

```
git clone https://github.com/stevengj/nlopt.git
cd nlopt
mkdir build
cd build
cmake ..
make
sudo make install
```


### MAGEMin {#MAGEMin}

Choose the `C` compiler in the first line of the `Makefile` by commenting out one:

```
#CC=gcc
CC=clang
```


Make sure the Open MPI paths for libraries and include directory in `Makefile` are correct. By default, the paths to Open MPI are the following:

```
LIBS   += (...) -L/usr/lib/x86_64-linux-gnu/openmpi/lib -lmpi
INC     = (...) -I/usr/lib/x86_64-linux-gnu/openmpi/include/
```


Depending on the machine on which you want to install MAGEMin, you might need to manually specify the paths to `NLopt` libraries and include directory too:

```
LIBS   += (...) --L/local/home/kwak/nlopt_install/install/lib -lnlopt 
INC     = (...) -I/local/home/kwak/nlopt_install/install/include
```


If you are using `Lockless` memory allocator, add the following flag in the `Makefile`:

```
LIBS   += (...) -lllalloc
```


Then compile MAGEMin:

```
make clean; make all;
```


::: tip Note

By default, the optimization flag `-O3` and debugging flag `-g` are used.

:::

To test if MAGEMin compilation was successful, you can check the version of MAGEMin by running:

```
./MAGEMin --version
```


## macOS {#macOS}
<img src="../assets/macOS.png" alt="macOS Logo" width="64" align="right">


The installation details for macOS use `Homebrew`. However, the libraries can also be installed using `MacPorts`.

### C and Fortran Compilers {#C-and-Fortran-Compilers-2}

Using either `gcc` or `clang` to compile MAGEMin is up to you as the runtime performances are similar. However, in the event you want to modify MAGEMin for your own use, I would advise that you compile MAGEMin with `clang` as the error handling system is more strict, which will save you from unexpected segmentation faults.

```
brew install llvm
brew install gcc
```


::: tip Note

`gcc` package comes with `gcc`, `g++`, and `gfortran`.

:::

### MPICH (Message Passing Interface) {#MPICH-Message-Passing-Interface}

```
brew install mpich
```


::: tip Note

`openmpi` can equally be used.

:::

### LAPACKE (`C` version of the Fortran `LAPACK` library, should now be included in the `LAPACK` libraries) {#LAPACKE-C-version-of-the-Fortran-LAPACK-library,-should-now-be-included-in-the-LAPACK-libraries}

```
brew install lapack
```


If the `lapacke` libraries are not included, you can download the `LAPACK` package from Netlib that includes it.

### NLopt (Non-Linear Optimization Library) {#NLopt-Non-Linear-Optimization-Library-2}

`NLopt` can be installed using:

```
brew install nlopt
```


### MAGEMin {#MAGEMin-2}

Choose the `C` compiler in the first line of the `Makefile` by commenting out one:

```
#CC=gcc
CC=clang
```


Make sure the `MPICH` paths for libraries and include directory in the `Makefile` are correct, for instance:

```
LIBS   += (...) /opt/homebrew/lib/libmpich.dylib
INC     = (...) -I/opt/homebrew/include 
```


Do the same for `LAPACKE`:

```
LIBS   += (...) /opt/homebrew/opt/lapack/lib/liblapacke.dylib
INC    += (...) -I/opt/homebrew/opt/lapack/include
```


And `NLopt`:

```
LIBS   += (...) /opt/homebrew/lib/libnlopt.dylib
```


Which should give:

```
LIBS    = -lm -framework Accelerate /opt/homebrew/opt/lapack/lib/liblapacke.dylib /opt/homebrew/lib/libnlopt.dylib /opt/homebrew/lib/libmpich.dylib
INC     = -I/opt/homebrew/opt/lapack/include -I/opt/homebrew/include 
```


::: tip Note

This setup is provided by default in the `Makefile` for macOS. As long as you installed every package using `Homebrew`, you should be able to install MAGEMin without modifying these entries.

:::

If you decided to use `openmpi` instead of `mpich`, your `Makefile` should look like:

```
LIBS    = -lm -framework Accelerate /opt/homebrew/opt/lapack/lib/liblapacke.dylib /opt/homebrew/opt/nlopt/lib/libnlopt.dylib /opt/homebrew/opt/openmpi/lib/libmpi.dylib  
INC     = -I/opt/homebrew/opt/openmpi/include/ -I/opt/homebrew/opt/lapack/include -I/usr/local/include -I/opt/homebrew/opt/nlopt/include/
```


Then simply enter the MAGEMin directory and compile MAGEMin as:

```
make clean; make all;
```


::: tip Note

By default, the optimization flag `-O3` and debugging flag `-g` are used.

:::

To test if MAGEMin compilation was successful, you can check the version of MAGEMin by running:

```
./MAGEMin --version
```

