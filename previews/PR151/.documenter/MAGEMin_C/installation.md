
# MAGEMin_C.jl: installation guide {#MAGEMin_C.jl:-installation-guide}

First install julia. We recommend downloading and installing `Julia` from the [julia](https://julialang.org) webpage.

Next, installing the `MAGEMin_C` package is very easy:

```julia
]
pkg> add MAGEMin_C
```


You can check if it works on your system by running the build-in test suite:

```julia
pkg> test MAGEMin_C
```


...and that&#39;s it!

::: tip Note

By pushing `backspace` you return from the package manager to the main julia terminal. This will download a compiled version of the library as well as some wrapper functions to your system.

:::

## Update to newest version {#Update-to-newest-version}

If you have a previous version of `MAGEMin_C` installed, the easiest way to update `MAGEMin_C` is the following:

```julia
julia>]
pkg> rm MAGEMin_C       # In case you also use MAGEMin_C this needs to be removed first before updating it, as MAGEMinApp is locked on the last version of MAGEMin_C
pkg> update             # update the repository
pkg> add MAGEMin_C     # reinstall MAGEMin
pkg> up MAGEMin_C      # sometimes needed to update to the last version
```


If you cannot update to the last `MAGEMin_C` version, try to set the `Julia` registry to &quot;eager&quot; using the following command, then redo the update process.

```julia
julia> ENV["JULIA_PKG_SERVER_REGISTRY_PREFERENCE"] = "eager"
```


If a new version of `MAGEMin_C` is available but the update did not work you can try to add the package by providing its version  number as:

```julia
    julia> ] add MAGEMin_C@x.y.z
```


where `x`, `y` and `z` are the integers of the version  number.
