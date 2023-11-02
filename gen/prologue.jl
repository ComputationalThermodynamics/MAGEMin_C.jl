#
# START OF PROLOGUE
#
using MAGEMin_C, MAGEMin_jll
const HASH_JEN = 0

using Libdl: dlext


function __init__()
    libname = "libMAGEMin." * dlext
    if isfile(libname)
        global libMAGEMin = joinpath(pwd(), libname)
        println("Using locally compiled version of $(libname)")
    else
        global libMAGEMin = MAGEMin_jll.libMAGEMin
        libname = basename(libMAGEMin)
        println("Using $(libname) from MAGEMin_jll")
    end
end

#
# END OF PROLOGUE
#