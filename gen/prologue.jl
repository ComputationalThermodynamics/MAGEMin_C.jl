#
# START OF PROLOGUE
#
using MAGEMin_C, MAGEMin_jll
const HASH_JEN = 0;


function __init__()
    local_lib = joinpath(pwd(), "libMAGEMin.dylib")
    pkg_lib   = normpath(joinpath(@__DIR__, "..", "libMAGEMin.dylib"))
    if isfile(local_lib)
        global libMAGEMin = local_lib
        println("Using locally compiled version of libMAGEMin.dylib ($local_lib)")
    elseif isfile(pkg_lib)
        global libMAGEMin = pkg_lib
        println("Using locally compiled version of libMAGEMin.dylib ($pkg_lib)")
    else
        global libMAGEMin = MAGEMin_jll.libMAGEMin
        println("Using libMAGEMin.dylib from MAGEMin_jll")
    end
end

#
# END OF PROLOGUE
#