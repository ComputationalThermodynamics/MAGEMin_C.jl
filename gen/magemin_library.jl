module LibMAGEMin

using MAGEMin_jll
export MAGEMin_jll

using CEnum

#
# START OF PROLOGUE
#
using MAGEMin, MAGEMin_jll
const HASH_JEN = 0;


function __init__()
    if isfile("libMAGEMin.dylib")
        global libMAGEMin = joinpath(pwd(),"libMAGEMin.dylib")
        println("Using locally compiled version of libMAGEMin.dylib")
    else
        global libMAGEMin = MAGEMin_jll.libMAGEMin
        println("Using libMAGEMin.dylib from MAGEMin_jll")
    end
end

#
# END OF PROLOGUE
#

# typedef double ( * nlopt_func ) ( unsigned n , const double * x , double * gradient , /* NULL if not needed */ void * func_data )
const nlopt_func = Ptr{Cvoid}

# typedef void ( * nlopt_mfunc ) ( unsigned m , double * result , unsigned n , const double * x , double * gradient , /* NULL if not needed */ void * func_data )
const nlopt_mfunc = Ptr{Cvoid}

# typedef void ( * nlopt_precond ) ( unsigned n , const double * x , const double * v , double * vpre , void * data )
const nlopt_precond = Ptr{Cvoid}

@cenum nlopt_algorithm::UInt32 begin
    NLOPT_GN_DIRECT = 0
    NLOPT_GN_DIRECT_L = 1
    NLOPT_GN_DIRECT_L_RAND = 2
    NLOPT_GN_DIRECT_NOSCAL = 3
    NLOPT_GN_DIRECT_L_NOSCAL = 4
    NLOPT_GN_DIRECT_L_RAND_NOSCAL = 5
    NLOPT_GN_ORIG_DIRECT = 6
    NLOPT_GN_ORIG_DIRECT_L = 7
    NLOPT_GD_STOGO = 8
    NLOPT_GD_STOGO_RAND = 9
    NLOPT_LD_LBFGS_NOCEDAL = 10
    NLOPT_LD_LBFGS = 11
    NLOPT_LN_PRAXIS = 12
    NLOPT_LD_VAR1 = 13
    NLOPT_LD_VAR2 = 14
    NLOPT_LD_TNEWTON = 15
    NLOPT_LD_TNEWTON_RESTART = 16
    NLOPT_LD_TNEWTON_PRECOND = 17
    NLOPT_LD_TNEWTON_PRECOND_RESTART = 18
    NLOPT_GN_CRS2_LM = 19
    NLOPT_GN_MLSL = 20
    NLOPT_GD_MLSL = 21
    NLOPT_GN_MLSL_LDS = 22
    NLOPT_GD_MLSL_LDS = 23
    NLOPT_LD_MMA = 24
    NLOPT_LN_COBYLA = 25
    NLOPT_LN_NEWUOA = 26
    NLOPT_LN_NEWUOA_BOUND = 27
    NLOPT_LN_NELDERMEAD = 28
    NLOPT_LN_SBPLX = 29
    NLOPT_LN_AUGLAG = 30
    NLOPT_LD_AUGLAG = 31
    NLOPT_LN_AUGLAG_EQ = 32
    NLOPT_LD_AUGLAG_EQ = 33
    NLOPT_LN_BOBYQA = 34
    NLOPT_GN_ISRES = 35
    NLOPT_AUGLAG = 36
    NLOPT_AUGLAG_EQ = 37
    NLOPT_G_MLSL = 38
    NLOPT_G_MLSL_LDS = 39
    NLOPT_LD_SLSQP = 40
    NLOPT_LD_CCSAQ = 41
    NLOPT_GN_ESCH = 42
    NLOPT_GN_AGS = 43
    NLOPT_NUM_ALGORITHMS = 44
end

function nlopt_algorithm_name(a)
    ccall((:nlopt_algorithm_name, libMAGEMin), Ptr{Cchar}, (nlopt_algorithm,), a)
end

function nlopt_algorithm_to_string(algorithm)
    ccall((:nlopt_algorithm_to_string, libMAGEMin), Ptr{Cchar}, (nlopt_algorithm,), algorithm)
end

function nlopt_algorithm_from_string(name)
    ccall((:nlopt_algorithm_from_string, libMAGEMin), nlopt_algorithm, (Ptr{Cchar},), name)
end

@cenum nlopt_result::Int32 begin
    NLOPT_FAILURE = -1
    NLOPT_INVALID_ARGS = -2
    NLOPT_OUT_OF_MEMORY = -3
    NLOPT_ROUNDOFF_LIMITED = -4
    NLOPT_FORCED_STOP = -5
    NLOPT_NUM_FAILURES = -6
    NLOPT_SUCCESS = 1
    NLOPT_STOPVAL_REACHED = 2
    NLOPT_FTOL_REACHED = 3
    NLOPT_XTOL_REACHED = 4
    NLOPT_MAXEVAL_REACHED = 5
    NLOPT_MAXTIME_REACHED = 6
    NLOPT_NUM_RESULTS = 7
end

function nlopt_result_to_string(algorithm)
    ccall((:nlopt_result_to_string, libMAGEMin), Ptr{Cchar}, (nlopt_result,), algorithm)
end

function nlopt_result_from_string(name)
    ccall((:nlopt_result_from_string, libMAGEMin), nlopt_result, (Ptr{Cchar},), name)
end

function nlopt_srand(seed)
    ccall((:nlopt_srand, libMAGEMin), Cvoid, (Culong,), seed)
end

function nlopt_srand_time()
    ccall((:nlopt_srand_time, libMAGEMin), Cvoid, ())
end

function nlopt_version(major, minor, bugfix)
    ccall((:nlopt_version, libMAGEMin), Cvoid, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), major, minor, bugfix)
end

mutable struct nlopt_opt_s end

const nlopt_opt = Ptr{nlopt_opt_s}

function nlopt_create(algorithm, n)
    ccall((:nlopt_create, libMAGEMin), nlopt_opt, (nlopt_algorithm, Cuint), algorithm, n)
end

function nlopt_destroy(opt)
    ccall((:nlopt_destroy, libMAGEMin), Cvoid, (nlopt_opt,), opt)
end

function nlopt_copy(opt)
    ccall((:nlopt_copy, libMAGEMin), nlopt_opt, (nlopt_opt,), opt)
end

function nlopt_optimize(opt, x, opt_f)
    ccall((:nlopt_optimize, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}, Ptr{Cdouble}), opt, x, opt_f)
end

function nlopt_set_min_objective(opt, f, f_data)
    ccall((:nlopt_set_min_objective, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, Ptr{Cvoid}), opt, f, f_data)
end

function nlopt_set_max_objective(opt, f, f_data)
    ccall((:nlopt_set_max_objective, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, Ptr{Cvoid}), opt, f, f_data)
end

function nlopt_set_precond_min_objective(opt, f, pre, f_data)
    ccall((:nlopt_set_precond_min_objective, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, nlopt_precond, Ptr{Cvoid}), opt, f, pre, f_data)
end

function nlopt_set_precond_max_objective(opt, f, pre, f_data)
    ccall((:nlopt_set_precond_max_objective, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, nlopt_precond, Ptr{Cvoid}), opt, f, pre, f_data)
end

function nlopt_get_algorithm(opt)
    ccall((:nlopt_get_algorithm, libMAGEMin), nlopt_algorithm, (nlopt_opt,), opt)
end

function nlopt_get_dimension(opt)
    ccall((:nlopt_get_dimension, libMAGEMin), Cuint, (nlopt_opt,), opt)
end

function nlopt_get_errmsg(opt)
    ccall((:nlopt_get_errmsg, libMAGEMin), Ptr{Cchar}, (nlopt_opt,), opt)
end

function nlopt_set_param(opt, name, val)
    ccall((:nlopt_set_param, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cchar}, Cdouble), opt, name, val)
end

function nlopt_get_param(opt, name, defaultval)
    ccall((:nlopt_get_param, libMAGEMin), Cdouble, (nlopt_opt, Ptr{Cchar}, Cdouble), opt, name, defaultval)
end

function nlopt_has_param(opt, name)
    ccall((:nlopt_has_param, libMAGEMin), Cint, (nlopt_opt, Ptr{Cchar}), opt, name)
end

function nlopt_num_params(opt)
    ccall((:nlopt_num_params, libMAGEMin), Cuint, (nlopt_opt,), opt)
end

function nlopt_nth_param(opt, n)
    ccall((:nlopt_nth_param, libMAGEMin), Ptr{Cchar}, (nlopt_opt, Cuint), opt, n)
end

function nlopt_set_lower_bounds(opt, lb)
    ccall((:nlopt_set_lower_bounds, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, lb)
end

function nlopt_set_lower_bounds1(opt, lb)
    ccall((:nlopt_set_lower_bounds1, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, lb)
end

function nlopt_set_lower_bound(opt, i, lb)
    ccall((:nlopt_set_lower_bound, libMAGEMin), nlopt_result, (nlopt_opt, Cint, Cdouble), opt, i, lb)
end

function nlopt_get_lower_bounds(opt, lb)
    ccall((:nlopt_get_lower_bounds, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, lb)
end

function nlopt_set_upper_bounds(opt, ub)
    ccall((:nlopt_set_upper_bounds, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, ub)
end

function nlopt_set_upper_bounds1(opt, ub)
    ccall((:nlopt_set_upper_bounds1, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, ub)
end

function nlopt_set_upper_bound(opt, i, ub)
    ccall((:nlopt_set_upper_bound, libMAGEMin), nlopt_result, (nlopt_opt, Cint, Cdouble), opt, i, ub)
end

function nlopt_get_upper_bounds(opt, ub)
    ccall((:nlopt_get_upper_bounds, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, ub)
end

function nlopt_remove_inequality_constraints(opt)
    ccall((:nlopt_remove_inequality_constraints, libMAGEMin), nlopt_result, (nlopt_opt,), opt)
end

function nlopt_add_inequality_constraint(opt, fc, fc_data, tol)
    ccall((:nlopt_add_inequality_constraint, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, Ptr{Cvoid}, Cdouble), opt, fc, fc_data, tol)
end

function nlopt_add_precond_inequality_constraint(opt, fc, pre, fc_data, tol)
    ccall((:nlopt_add_precond_inequality_constraint, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, nlopt_precond, Ptr{Cvoid}, Cdouble), opt, fc, pre, fc_data, tol)
end

function nlopt_add_inequality_mconstraint(opt, m, fc, fc_data, tol)
    ccall((:nlopt_add_inequality_mconstraint, libMAGEMin), nlopt_result, (nlopt_opt, Cuint, nlopt_mfunc, Ptr{Cvoid}, Ptr{Cdouble}), opt, m, fc, fc_data, tol)
end

function nlopt_remove_equality_constraints(opt)
    ccall((:nlopt_remove_equality_constraints, libMAGEMin), nlopt_result, (nlopt_opt,), opt)
end

function nlopt_add_equality_constraint(opt, h, h_data, tol)
    ccall((:nlopt_add_equality_constraint, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, Ptr{Cvoid}, Cdouble), opt, h, h_data, tol)
end

function nlopt_add_precond_equality_constraint(opt, h, pre, h_data, tol)
    ccall((:nlopt_add_precond_equality_constraint, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_func, nlopt_precond, Ptr{Cvoid}, Cdouble), opt, h, pre, h_data, tol)
end

function nlopt_add_equality_mconstraint(opt, m, h, h_data, tol)
    ccall((:nlopt_add_equality_mconstraint, libMAGEMin), nlopt_result, (nlopt_opt, Cuint, nlopt_mfunc, Ptr{Cvoid}, Ptr{Cdouble}), opt, m, h, h_data, tol)
end

function nlopt_set_stopval(opt, stopval)
    ccall((:nlopt_set_stopval, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, stopval)
end

function nlopt_get_stopval(opt)
    ccall((:nlopt_get_stopval, libMAGEMin), Cdouble, (nlopt_opt,), opt)
end

function nlopt_set_ftol_rel(opt, tol)
    ccall((:nlopt_set_ftol_rel, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, tol)
end

function nlopt_get_ftol_rel(opt)
    ccall((:nlopt_get_ftol_rel, libMAGEMin), Cdouble, (nlopt_opt,), opt)
end

function nlopt_set_ftol_abs(opt, tol)
    ccall((:nlopt_set_ftol_abs, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, tol)
end

function nlopt_get_ftol_abs(opt)
    ccall((:nlopt_get_ftol_abs, libMAGEMin), Cdouble, (nlopt_opt,), opt)
end

function nlopt_set_xtol_rel(opt, tol)
    ccall((:nlopt_set_xtol_rel, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, tol)
end

function nlopt_get_xtol_rel(opt)
    ccall((:nlopt_get_xtol_rel, libMAGEMin), Cdouble, (nlopt_opt,), opt)
end

function nlopt_set_xtol_abs1(opt, tol)
    ccall((:nlopt_set_xtol_abs1, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, tol)
end

function nlopt_set_xtol_abs(opt, tol)
    ccall((:nlopt_set_xtol_abs, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, tol)
end

function nlopt_get_xtol_abs(opt, tol)
    ccall((:nlopt_get_xtol_abs, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, tol)
end

function nlopt_set_x_weights1(opt, w)
    ccall((:nlopt_set_x_weights1, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, w)
end

function nlopt_set_x_weights(opt, w)
    ccall((:nlopt_set_x_weights, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, w)
end

function nlopt_get_x_weights(opt, w)
    ccall((:nlopt_get_x_weights, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, w)
end

function nlopt_set_maxeval(opt, maxeval)
    ccall((:nlopt_set_maxeval, libMAGEMin), nlopt_result, (nlopt_opt, Cint), opt, maxeval)
end

function nlopt_get_maxeval(opt)
    ccall((:nlopt_get_maxeval, libMAGEMin), Cint, (nlopt_opt,), opt)
end

function nlopt_get_numevals(opt)
    ccall((:nlopt_get_numevals, libMAGEMin), Cint, (nlopt_opt,), opt)
end

function nlopt_set_maxtime(opt, maxtime)
    ccall((:nlopt_set_maxtime, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, maxtime)
end

function nlopt_get_maxtime(opt)
    ccall((:nlopt_get_maxtime, libMAGEMin), Cdouble, (nlopt_opt,), opt)
end

function nlopt_force_stop(opt)
    ccall((:nlopt_force_stop, libMAGEMin), nlopt_result, (nlopt_opt,), opt)
end

function nlopt_set_force_stop(opt, val)
    ccall((:nlopt_set_force_stop, libMAGEMin), nlopt_result, (nlopt_opt, Cint), opt, val)
end

function nlopt_get_force_stop(opt)
    ccall((:nlopt_get_force_stop, libMAGEMin), Cint, (nlopt_opt,), opt)
end

function nlopt_set_local_optimizer(opt, local_opt)
    ccall((:nlopt_set_local_optimizer, libMAGEMin), nlopt_result, (nlopt_opt, nlopt_opt), opt, local_opt)
end

function nlopt_set_population(opt, pop)
    ccall((:nlopt_set_population, libMAGEMin), nlopt_result, (nlopt_opt, Cuint), opt, pop)
end

function nlopt_get_population(opt)
    ccall((:nlopt_get_population, libMAGEMin), Cuint, (nlopt_opt,), opt)
end

function nlopt_set_vector_storage(opt, dim)
    ccall((:nlopt_set_vector_storage, libMAGEMin), nlopt_result, (nlopt_opt, Cuint), opt, dim)
end

function nlopt_get_vector_storage(opt)
    ccall((:nlopt_get_vector_storage, libMAGEMin), Cuint, (nlopt_opt,), opt)
end

function nlopt_set_default_initial_step(opt, x)
    ccall((:nlopt_set_default_initial_step, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, x)
end

function nlopt_set_initial_step(opt, dx)
    ccall((:nlopt_set_initial_step, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}), opt, dx)
end

function nlopt_set_initial_step1(opt, dx)
    ccall((:nlopt_set_initial_step1, libMAGEMin), nlopt_result, (nlopt_opt, Cdouble), opt, dx)
end

function nlopt_get_initial_step(opt, x, dx)
    ccall((:nlopt_get_initial_step, libMAGEMin), nlopt_result, (nlopt_opt, Ptr{Cdouble}, Ptr{Cdouble}), opt, x, dx)
end

# typedef void * ( * nlopt_munge ) ( void * p )
const nlopt_munge = Ptr{Cvoid}

function nlopt_set_munge(opt, munge_on_destroy, munge_on_copy)
    ccall((:nlopt_set_munge, libMAGEMin), Cvoid, (nlopt_opt, nlopt_munge, nlopt_munge), opt, munge_on_destroy, munge_on_copy)
end

# typedef void * ( * nlopt_munge2 ) ( void * p , void * data )
const nlopt_munge2 = Ptr{Cvoid}

function nlopt_munge_data(opt, munge, data)
    ccall((:nlopt_munge_data, libMAGEMin), Cvoid, (nlopt_opt, nlopt_munge2, Ptr{Cvoid}), opt, munge, data)
end

# typedef double ( * nlopt_func_old ) ( int n , const double * x , double * gradient , /* NULL if not needed */ void * func_data )
const nlopt_func_old = Ptr{Cvoid}

function nlopt_minimize(algorithm, n, f, f_data, lb, ub, x, minf, minf_max, ftol_rel, ftol_abs, xtol_rel, xtol_abs, maxeval, maxtime)
    ccall((:nlopt_minimize, libMAGEMin), nlopt_result, (nlopt_algorithm, Cint, nlopt_func_old, Ptr{Cvoid}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble, Cdouble, Ptr{Cdouble}, Cint, Cdouble), algorithm, n, f, f_data, lb, ub, x, minf, minf_max, ftol_rel, ftol_abs, xtol_rel, xtol_abs, maxeval, maxtime)
end

function nlopt_minimize_constrained(algorithm, n, f, f_data, m, fc, fc_data, fc_datum_size, lb, ub, x, minf, minf_max, ftol_rel, ftol_abs, xtol_rel, xtol_abs, maxeval, maxtime)
    ccall((:nlopt_minimize_constrained, libMAGEMin), nlopt_result, (nlopt_algorithm, Cint, nlopt_func_old, Ptr{Cvoid}, Cint, nlopt_func_old, Ptr{Cvoid}, Cptrdiff_t, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble, Cdouble, Ptr{Cdouble}, Cint, Cdouble), algorithm, n, f, f_data, m, fc, fc_data, fc_datum_size, lb, ub, x, minf, minf_max, ftol_rel, ftol_abs, xtol_rel, xtol_abs, maxeval, maxtime)
end

function nlopt_minimize_econstrained(algorithm, n, f, f_data, m, fc, fc_data, fc_datum_size, p, h, h_data, h_datum_size, lb, ub, x, minf, minf_max, ftol_rel, ftol_abs, xtol_rel, xtol_abs, htol_rel, htol_abs, maxeval, maxtime)
    ccall((:nlopt_minimize_econstrained, libMAGEMin), nlopt_result, (nlopt_algorithm, Cint, nlopt_func_old, Ptr{Cvoid}, Cint, nlopt_func_old, Ptr{Cvoid}, Cptrdiff_t, Cint, nlopt_func_old, Ptr{Cvoid}, Cptrdiff_t, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble, Cdouble, Ptr{Cdouble}, Cdouble, Cdouble, Cint, Cdouble), algorithm, n, f, f_data, m, fc, fc_data, fc_datum_size, p, h, h_data, h_datum_size, lb, ub, x, minf, minf_max, ftol_rel, ftol_abs, xtol_rel, xtol_abs, htol_rel, htol_abs, maxeval, maxtime)
end

function nlopt_get_local_search_algorithm(deriv, nonderiv, maxeval)
    ccall((:nlopt_get_local_search_algorithm, libMAGEMin), Cvoid, (Ptr{nlopt_algorithm}, Ptr{nlopt_algorithm}, Ptr{Cint}), deriv, nonderiv, maxeval)
end

function nlopt_set_local_search_algorithm(deriv, nonderiv, maxeval)
    ccall((:nlopt_set_local_search_algorithm, libMAGEMin), Cvoid, (nlopt_algorithm, nlopt_algorithm, Cint), deriv, nonderiv, maxeval)
end

function nlopt_get_stochastic_population()
    ccall((:nlopt_get_stochastic_population, libMAGEMin), Cint, ())
end

function nlopt_set_stochastic_population(pop)
    ccall((:nlopt_set_stochastic_population, libMAGEMin), Cvoid, (Cint,), pop)
end

@cenum var"##Ctag#365"::UInt32 begin
    _tc_ds634_ = 0
end

mutable struct EM_db
    Name::NTuple{20, Cchar}
    Comp::NTuple{12, Cdouble}
    input_1::NTuple{3, Cdouble}
    input_2::NTuple{4, Cdouble}
    input_3::NTuple{11, Cdouble}
    input_4::NTuple{3, Cdouble}
    EM_db() = new()
end

function Access_EM_DB(id, EM_database)
    ccall((:Access_EM_DB, libMAGEMin), EM_db, (Cint, Cint), id, EM_database)
end

mutable struct EM2id
