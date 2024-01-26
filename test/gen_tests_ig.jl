# This script helps to generate a lsit of points for testing MAGEMin using reference built-in bulk-rock compositions

cur_dir = pwd();    
if  cur_dir[end-3:end]=="test"
    cd("../")           # change to main directory if we are in /test
end
using MAGEMin_C

# Initialize database 
db          = "ig"  # database: ig, igneous (Holland et al., 2018); mp, metapelite (White et al 2014b)
gv, z_b, DB, splx_data      = init_MAGEMin(db);


sys_in      = "mol"     #default is mol, if wt is provided conversion will be done internally (MAGEMin works on mol basis)
test        = 6         #KLB1
gv          = use_predefined_bulk_rock(gv, test, db);

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
gv.verbose  = -1    # switch off any verbose

Tmin        = 800.0
Tmax        = 1400.0
Tstep       = 100.0
Pmin        = 0.01
Pmax        = 30.01
Pstep       = 5.0

for i=Pmin:Pstep:Pmax
    for j=Tmin:Tstep:Tmax

        bulk_rock   = use_predefined_bulk_rock(gv, test)
        # out         = point_wise_minimization(sys_in,i,j, bulk_rock, gv, DB)
        out         = point_wise_minimization(i,j, gv, z_b, DB, splx_data, sys_in)
        push!(outList,outP(i,j,test,out.G_system,out.ph,out.ph_frac[:]))
        print(out)
    end
end

for i=1:length(outList)
    print(outList[i],",\n")
end

