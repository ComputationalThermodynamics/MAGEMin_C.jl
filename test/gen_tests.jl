# This script helps to generate a lsit of points for testing MAGEMin using reference built-in bulk-rock compositions

cur_dir = pwd();    
if  cur_dir[end-3:end]=="test"
    cd("../")           # change to main directory if we are in /test
end
using MAGEMin_C

gv, DB = init_MAGEMin();

sys_in = "mol"

mutable struct outP{ _T  } 
    P           ::  _T
    T           ::  _T 
    test        ::  Int64

    G           ::  _T
    ph          ::  Vector{String}
    ph_frac     ::  Vector{Float64}
end

outList       = Vector{outP}(undef, 0)

# test 0
test        = 6
gv.verbose  = -1    # switch off any verbose

Tmin        = 800.0
Tmax        = 1400.0
Tstep       = 100.0
Pmin        = 0.0
Pmax        = 30.0
Pstep       = 5.0

for i=Pmin:Pstep:Pmax
    for j=Tmin:Tstep:Tmax

        bulk_rock   = use_predefined_bulk_rock(gv, test)
        out         = point_wise_minimization(sys_in,i,j, bulk_rock, gv, DB)

        push!(outList,outP(i,j,test,out.G_system,out.ph,out.ph_frac[:]))
        print(out)
    end
end

for i=1:length(outList)
    print(outList[i],",\n")
end

