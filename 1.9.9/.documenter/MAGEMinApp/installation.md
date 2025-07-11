
## How to install MAGEMinApp.jl {#How-to-install-MAGEMinApp.jl}

First install julia. We recommend that you follow the instructions on how to install `Julia` from the [julia](https://julialang.org) webpage.

Once `Julia` is installed, open a terminal (Linux, MacOS) or a powershell (Windows) and launch a threaded `Julia` instance to make use of parallel computation:

```
julia -t auto
```


::: tip Tip

The number of available threads is machine-dependent. To know how many threads you have you can type the command `versioninfo()` in a `Julia`terminal. The keyword `auto` will use all you have in your machine. You can also specify the number of threads you want to use, e.g.,  `julia -t 4` for four cores.

:::

```julia
julia> using Pkg

julia> Pkg.add("MAGEMinApp")
```


After the package is installed, one can load the package by using:

```julia
julia> using MAGEMinApp
```


And execute the app as:

```julia
julia> App()
[ Info: Listening on: 127.0.0.1:8050, thread id: 1
```


Now you can open `127.0.0.1:8050` in your favorite web browser.

...and that&#39;s it!

## Update to newest version {#Update-to-newest-version}

If you have a previous version of `MAGEMinApp` installed, the easiest way to update `MAGEMinApp` is the following:

```julia
julia>]
pkg> rm MAGEMinApp      # First remove MAGEMinApp
pkg> rm MAGEMin_C       # In case you also use MAGEMin_C this needs to be removed first before updating it, as MAGEMinApp is locked on the last version of MAGEMin_C
pkg> update             # update the repository
pkg> add MAGEMinApp     # reinstall MAGEMin
pkg> up MAGEMinApp      # sometimes needed to update to the last version
(pkg> add MAGEMin_C)    # If you want to have MAGEMin_C too
```


If you cannot update to the last `MAGEMinApp` version, try to set the `Julia` registry to &quot;eager&quot; using the following command, then redo the update process.

```julia
julia> ENV["JULIA_PKG_SERVER_REGISTRY_PREFERENCE"] = "eager"
```


If a new version of `MAGEMinApp` is available but the update did not work you can try to add the package by providing its version  number as:

```julia
    julia> ] add MAGEMinApp@x.y.z
```


where `x`, `y` and `z` are the integers of the version  number.

## Running MAGEMin_C it in parallel {#Running-MAGEMin_C-it-in-parallel}

Julia can be run in parallel using multi-threading. To take advantage of this, you need to start julia from the terminal with:

```bash
julia -t auto
```


which will automatically use all threads on your machine. Alternatively, use `julia -t 4` to start it on 4 threads. If you are interested to see what you can do on your machine, type:

```julia
versioninfo()
Julia Version 1.9.0
Commit 8e630552924 (2023-05-07 11:25 UTC)
Platform Info:
OS: macOS (arm64-apple-darwin22.4.0)
CPU: 12 × Apple M2 Max
WORD_SIZE: 64
LIBM: libopenlibm
LLVM: libLLVM-14.0.6 (ORCJIT, apple-m1)
Threads: 8 on 8 virtual cores
```


The function `multi_point_minimization` will automatically utilize parallelization if you run it on &gt;1 threads.
