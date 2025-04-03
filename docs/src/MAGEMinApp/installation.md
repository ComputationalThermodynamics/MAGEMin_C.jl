
## How to install MAGEMinApp.jl

First install julia. We recommend that you follow the instructions on how to install `Julia` from the [julia](https://julialang.org) webpage.

Once `Julia` is installed, open a terminal (Linux, MacOS) or a powershell (Windows) and launch a threaded `Julia` instance to make use of parallel computation:

```
julia -t 6
```

!!! tip
    The number of available threads is machine-dependent. To know how many threads you have you can type the command `versioninfo()` in a `Julia`terminal.


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
```

...and that's it!

## Update to newest version

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

If you cannot update to the last `MAGEMinApp` version, try to set the `Julia` registry to "eager" using the following command, then redo the update process.

```julia
julia> ENV["JULIA_PKG_SERVER_REGISTRY_PREFERENCE"] = "eager"
```

If a new version of `MAGEMinApp` is available but the update did not work you can try to add the package by providing its version  number as:

```julia
    julia> ] add MAGEMinApp@x.y.z
```

where `x`, `y` and `z` are the integers of the version  number.