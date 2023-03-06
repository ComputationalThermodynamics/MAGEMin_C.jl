#ifndef __INITIALIZE_H_
#define __INITIALIZE_H_

#include "uthash.h"
#include "Endmembers_tc-ds62.h"
#include "Endmembers_tc-ds634.h"

/* Select required thermodynamic database */
struct EM_db Access_EM_DB(int id, int EM_database) {
	struct EM_db Entry_EM;

	if (EM_database == 0){	
	 	Entry_EM = arr_em_db_tc_ds62[id]; 
	}
	else if (EM_database == 1){	
	 	Entry_EM = arr_em_db_tc_ds62[id]; 
	}
	else if (EM_database == 2){		
		Entry_EM = arr_em_db_tc_ds634[id]; 
	}
	else{
		printf(" Wrong database, values should be 0, metapelite; 1, metabasite; 2, igneous\n");
		printf(" -> using default igneous database to avoid ugly crash\n");
		Entry_EM = arr_em_db_tc_ds634[id]; 
	}
	
	return Entry_EM;
}

/*---------------------------------------------------------------------------*/ 
/*  Hashtable for endmember in thermodynamic database                        */
struct EM2id {
    char EM_tag[20];           /* key (string is WITHIN the structure)       */
    int id;                    /* id of the key (array index)                */
    UT_hash_handle hh;         /* makes this structure hashable              */
};
struct EM2id *EM = NULL;

int find_EM_id(char *EM_tag) {
	struct EM2id *p_s;
	HASH_FIND_STR ( EM, EM_tag, p_s );
	return(p_s->id);	
}

/**
	Hashtable for Pure-phases in the pure-phases list                        
*/
struct PP2id {
    char PP_tag[20];           /* key (string is WITHIN the structure)       */
    int id;                    /* id of the key (array index)                */
    UT_hash_handle hh;         /* makes this structure hashable              */
};
struct PP2id *PP = NULL;

int find_PP_id(char *PP_tag) {
	struct PP2id *pp_s;
	HASH_FIND_STR ( PP, PP_tag, pp_s );
	return(pp_s->id);	
}

/**
	Function to retrieve the endmember names from the database 
	Note the size of the array is n_em_db+1, required for the hashtable              
*/
char** get_EM_DB_names(global_variable gv) {
	struct EM_db EM_return;
	int i, n_em_db;
	n_em_db = gv.n_em_db;
	char ** names = malloc((n_em_db+1) * sizeof(char*));
	for ( i = 0; i < n_em_db; i++){
		names[i] = malloc(20 * sizeof(char));
	}
	for ( i = 0; i < n_em_db; i++){	
		EM_return = Access_EM_DB(i, gv.EM_database);
		strcpy(names[i],EM_return.Name);
	}
	return names;
}

/** 
	Store oxide informations 
**/
typedef struct oxide_datas {
	int 	n_ox;
	char    oxName[12][20];
	double  oxMass[12];
	double  atPerOx[12];

} oxide_data;

oxide_data oxide_info = {
	12,						/* number of endmembers */
	{"SiO2"	,"Al2O3","CaO"	,"MgO"	,"FeO"	,"K2O"	,"Na2O"	,"TiO2"	,"O"	,"MnO"	,"Cr2O3","H2O"			},
	{60.08  ,101.96 ,56.08  ,40.30  ,71.85  ,94.2   ,61.98  ,79.88  ,16.0   ,70.937	,151.99 ,18.015			},
	{3.0	,5.0	,2.0	,2.0	,2.0	,3.0	,3.0	,3.0	,1.0	,2.0 	,5.0	,3.0			}
};


/** 
	set default parameters necessary to initialize the system 
*/
global_variable global_variable_alloc( bulk_info  *z_b ){
	global_variable gv;

	int i,j,k;

	/** 
		allocate data necessary to initialize the system 
	*/
	/* system parameters 		*/
	gv.maxlen_ox 		= 15;
	gv.outpath 			= malloc (100 	* sizeof(char)			);
	gv.version 			= malloc (50  	* sizeof(char)			);
	gv.File 			= malloc (50 	* sizeof(char)			);
	gv.db 				= malloc (5 	* sizeof(char)			);
	gv.Phase 			= malloc (50 	* sizeof(char)			);
	gv.sys_in 			= malloc (5 	* sizeof(char)			);

	gv.arg_bulk 		= malloc (gv.maxlen_ox * sizeof(double)	);
	gv.arg_gamma 		= malloc (gv.maxlen_ox * sizeof(double)	);

	for (i = 0; i < gv.maxlen_ox; i++) {
		gv.arg_bulk[i]  = 0.0;
		gv.arg_gamma[i] = 0.0;
	}

	strcpy(gv.outpath,"./output/");				/** define the outpath to save logs and final results file	 						*/
	strcpy(gv.version,"1.3.0 [06/03/2023]");	/** MAGEMin version 																*/

	/* generate parameters        		*/
	gv.max_n_cp 		= 128;					/** number of considered solution phases 											*/									
	// gv.calc_seismic_cor = 1;					/** compute seismic velocity corrections (melt and anelastic)						*/
	// gv.melt_pressure 	= 0.0;				/** [kbar] pressure shift in case of modelling melt pressure 						*/

	/* residual tolerance 				*/
	gv.br_max_tol       = 1.0e-5;				/** value under which the solution is accepted to satisfy the mass constraint 		*/
	
	/* Magic PGE under-relaxing numbers */
	gv.relax_PGE_val    = 128.0;				/** restricting factor 																*/
	gv.PC_check_val1	= 1.0e-2;				/** br norm under which PC are tested for potential candidate to be added 			*/
	gv.PC_check_val2	= 1.0e-4;				/** br norm under which PC are tested for potential candidate to be added 			*/
	gv.PC_min_dist 		= 1.0;					/** factor multiplying the diagonal of the hyperbox of xeos step 					*/

	/* levelling parameters 			*/
	gv.em2ss_shift		= 1e-6;					/** small value to shift x-eos of pure endmember from bounds after levelling 		*/
	gv.bnd_filter_pc    = 10.0;					/** value of driving force the pseudocompound is considered 						*/
	gv.bnd_filter_pge   = 2.5;					/** value of driving force the pseudocompound is considered 						*/
	gv.max_G_pc         = 5.0;					/** dG under which PC is considered after their generation		 					*/
	gv.eps_sf_pc		= 1e-10;				/** Minimum value of site fraction under which PC is rejected, 
													don't put it too high as it will conflict with bounds of x-eos					*/

	/* PGE LP pseudocompounds parameters */
	gv.n_pc 			= 5000;
	gv.n_Ppc			= 2048;

	/* local minimizer options 	*/
	gv.bnd_val          = 1.0e-10;				/** boundary value for x-eos 										 				*/
	gv.ineq_res  	 	= 0.0;
	gv.box_size_mode_1	= 0.25;					/** box edge size of the compositional variables used during PGE local minimization */
	gv.maxeval_mode_1   = 1024;					/** max number of evaluation of the obj function for mode 1 (PGE)					*/

	/* Partitioning Gibbs Energy 		*/
	gv.xi_em_cor   		= 0.99;	
	gv.outter_PGE_ite   = 1;					/** minimum number of outter PGE iterations, before a solution can be accepted 		*/

	/* set of parameters to record the evolution of the norm of the mass constraint */
	gv.it_1             = 128;                  /** first critical iteration                                                        */
	gv.ur_1             = 4.;                   /** under relaxing factor on mass constraint if iteration is bigger than it_1       */
	gv.it_2             = 160;                  /** second critical iteration                                                       */
	gv.ur_2             = 8.;                   /** under relaxing factor on mass constraint if iteration is bigger than it_2       */
	gv.it_3             = 192;                  /** third critical iteration                                                        */
	gv.ur_3             = 16.;                  /** under relaxing factor on mass constraint if iteration is bigger than it_3       */
	gv.it_f             = 256;                  /** gives back failure when the number of iteration is bigger than it_f             */

	/* phase update options 			*/
	gv.min_df 			= 0.0;					/** value under which a phase in hold is reintroduced */

	/* numerical derivatives P,T steps (same value as TC) */
	gv.gb_P_eps			= 2e-3;					/** small value to calculate V using finite difference: V = dG/dP;					*/
	gv.gb_T_eps			= 2e-3;					/** small value to calculate V using finite difference: V = dG/dP;					*/
	gv.poisson_ratio 	= 0.3;					/** poisson ratio to compute elastic shear modulus 									*/

	/* initialize other values 			*/
	gv.mean_sum_xi		= 1.0;
	gv.sigma_sum_xi		= 1.0;
	gv.alpha        	= gv.max_fac;			/** active under-relaxing factor 													*/
	gv.maxeval		    = gv.maxeval_mode_1;
	gv.tot_min_time 	= 0.0;
	gv.tot_time 		= 0.0;

	/* set default parameters (overwritten later from args)*/
	gv.EM_database  	=  2; 					/** 0, metapelite; 1 metabasite; 2 igneous											*/
	gv.n_points 		=  1;
	gv.maxeval  		= -1;
	gv.solver   		=  1;					/* 1 = PGE+Legacy, 2 = Legacy only */
	gv.verbose 			=  0;
	gv.output_matlab 	=  0;
	gv.test     		= -1;

	/* default PT conditions for test */
	z_b->P 				= 12.0;		
	z_b->T 				= 1100.0 + 273.15;		
	z_b->R 				= 0.0083144;

	strcpy(gv.File,		"none"); 	/** Filename to be read to have multiple P-T-bulk conditions to solve 	*/
	strcpy(gv.sys_in,	"mol"); 	/** system unit 														*/
	strcpy(gv.db,		"ig"); 		/** database 															*/

	return gv;
}


/** 
	Metapelite database informations
**/
typedef struct metapelite_datasets {
	int 	n_em_db;
	int 	n_ox;
	int 	n_pp;
	int 	n_ss;
	char    ox[11][20];
	char    PP[15][20];
	char    SS[16][20];

	int 	verifyPC[16];
	int 	n_SS_PC[16];
	double 	SS_PC_stp[16];

	double 	PC_df_add;					/** min value of df under which the PC is added 									*/
	double  solver_switch_T;
	double  min_melt_T;

	double  inner_PGE_ite;				/** number of inner PGE iterations, this has to be made mass or dG dependent 		*/
	double  max_n_phase;				/** maximum mol% phase change during one PGE iteration in wt% 						*/
	double  max_g_phase;				/** maximum delta_G of reference change during PGE 									*/
	double 	max_fac;					/** maximum update factor during PGE under-relax < 0.0, over-relax > 0.0 	 		*/

	double  merge_value;				/** max norm distance between two instances of a solution phase						*/	
	double 	re_in_n;					/** fraction of phase when being reintroduce.  										*/

	double  obj_tol;

} metapelite_dataset;

metapelite_dataset metapelite_db = {
	256,						/* number of endmembers */
	11,							/* number of oxides */			
	15,							/* number of pure phases */
	16,							/* number of solution phases */
	{"SiO2"	,"Al2O3","CaO"	,"MgO"	,"FeO"	,"K2O"	,"Na2O"	,"TiO2"	,"O"	,"MnO"	,"H2O"												},
	{"q"	,"crst"	,"trd"	,"coe"	,"stv"	,"ky"	,"sill"	,"and"	,"ru"	,"sph"	,"wo"	,"pswo"	,"ne"	,"O2"  ,"H2O"				},
	{"liq"	,"pl4tr","bi"	,"g"	,"ep"	,"ma"	,"mu"	,"opx"	,"sa"	,"cd"	,"st"	,"chl"	,"ctd"	,"sp"  ,"ilm"  ,"mt"		},
	
	{1		,1		,1		,1		,1		,1		,1		,1		,1 		,1 		,1 		,1 		,1 		,1 		,1 		,1			},  // allow solvus?
	{2450	,231 	,981	,756	,110 	,1875	,1875	,1277	,230	,216	,540	,2270	,216	,405 	,140 	,27			},  // # of pseudocompound
	{0.249	,0.049	,0.19	,0.19	,0.049	,0.19	,0.19	,0.249	,0.19	,0.19	,0.19	,0.249	,0.19	,0.124 	,0.19 	,0.19 		},  // discretization step

	2.0, 						/* max dG under which a phase is considered to be reintroduced  					*/
	473.15,						/* max temperature above which PGE solver is active 								*/
	873.15,						/** minimum temperature above which melt is considered 								*/

	2,							/** number of inner PGE iterations, this has to be made mass or dG dependent 		*/
	0.05,						/** maximum mol% phase change during one PGE iteration in wt% 						*/
	2.5,						/** maximum delta_G of reference change during PGE 									*/
	1.0,						/** maximum update factor during PGE under-relax < 0.0, over-relax > 0.0 	 		*/

	1e-1,						/** merge instances of solution phase if norm < val 								*/
	1e-4,						/** fraction of solution phase when re-introduced 									*/
	1e-7						/** objective function tolerance 				 									*/
};

/** 
	Igneous database informations 
**/
typedef struct igneous_datasets {
	int 	n_em_db;
	int 	n_ox;
	int 	n_pp;
	int 	n_ss;
	char    ox[11][20];
	char    PP[14][20];
	char    SS[14][20];

	int 	verifyPC[14];
	int 	n_SS_PC[14];
	double 	SS_PC_stp[14];

	double 	PC_df_add;	
	double  solver_switch_T;
	double  min_melt_T;

	double  inner_PGE_ite;				/** number of inner PGE iterations, this has to be made mass or dG dependent 		*/
	double  max_n_phase;				/** maximum mol% phase change during one PGE iteration in wt% 						*/
	double  max_g_phase;				/** maximum delta_G of reference change during PGE 									*/
	double 	max_fac;					/** maximum update factor during PGE under-relax < 0.0, over-relax > 0.0 	 		*/

	double  merge_value;				/** max norm distance between two instances of a solution phase						*/	
	double 	re_in_n;					/** fraction of phase when being reintroduce.  										*/

	double  obj_tol;

} igneous_dataset;

igneous_dataset igneous_db = {
	291,						/* number of endmembers */
	11,							/* number of oxides */			
	14,							/* number of pure phases */
	14,							/* number of solution phases */
	{"SiO2"	,"Al2O3","CaO"	,"MgO"	,"FeO"	,"K2O"	,"Na2O"	,"TiO2"	,"O"	,"Cr2O3","H2O"								},
	{"q"	,"crst"	,"trd"	,"coe"	,"stv"	,"ky"	,"sill"	,"and"	,"ru"	,"sph"	,"wo"	,"pswo"	,"ne"	,"O2"		},
	{"spn"	,"bi"	,"cd"	,"cpx"	,"ep"	,"g"	,"hb"	,"ilm"	,"liq"	,"mu"	,"ol"	,"opx"	,"pl4T"	,"fl"		},
	
	{1		,1		,1		,1		,1		,1		,1		,1		,1 		,1 		,1 		,1 		,1 		,1			}, // allow solvus?
	{1521	,1645	,121	,4124	,110	,1224	,4950	,420	,3099	,2376	,222	,2495	,231	,1			}, // # of pseudocompound
	{0.249	,0.124	,0.098	,0.249	,0.049	,0.199	,0.249	,0.0499	,0.198	,0.198	,0.098	,0.249	,0.049	,1.0 		}, // discretization step

	4.0, 						/** max dG under which a phase is considered to be reintroduced  					*/
	673.15,						/** max temperature above which PGE solver is active 								*/
	873.15,						/** minimum temperature above which melt is considered 								*/

	8,							/** number of inner PGE iterations, this has to be made mass or dG dependent 		*/
	0.025,						/** maximum mol% phase change during one PGE iteration in wt% 						*/
	2.5,						/** maximum delta_G of reference change during PGE 									*/
	1.0,						/** maximum update factor during PGE under-relax < 0.0, over-relax > 0.0 	 		*/

	2e-1,						/** merge instances of solution phase if norm < val 								*/
	1e-4,						/** fraction of solution phase when re-introduced 									*/

	1e-7						/** objective function tolerance 				 									*/
};



/* Function to allocate the memory of the data to be used/saved during PGE iterations */
global_variable global_variable_init( 	global_variable  	 gv,
										bulk_info 			*z_b 	){
	int i, j;

	/* load database */
	if (gv.EM_database == 0){
		metapelite_dataset db 	= metapelite_db;
		gv.n_em_db 			= db.n_em_db;
		gv.len_pp   		= db.n_pp;		
		gv.len_ss  			= db.n_ss;
		gv.len_ox  			= db.n_ox;

		gv.PC_df_add		= db.PC_df_add;					/** min value of df under which the PC is added 									*/
		gv.solver_switch_T  = db.solver_switch_T;
		gv.min_melt_T       = db.min_melt_T ;				/** minimum temperature above which melt is considered 								*/

		gv.inner_PGE_ite    = db.inner_PGE_ite;				/** number of inner PGE iterations, this has to be made mass or dG dependent 		*/
		gv.max_n_phase  	= db.max_n_phase;				/** maximum mol% phase change during one PGE iteration in wt% 						*/
		gv.max_g_phase  	= db.max_g_phase;				/** maximum delta_G of reference change during PGE 									*/
		gv.max_fac          = db.max_fac;					/** maximum update factor during PGE under-relax < 0.0, over-relax > 0.0 	 		*/

		gv.merge_value		= db.merge_value;				/** merge instances of solution phase if norm < val 								*/
		gv.re_in_n          = db.re_in_n;					/** fraction of phase when being reintroduce.  										*/
		gv.obj_tol 			= db.obj_tol;

		/* alloc */
		gv.ox 				= malloc (gv.len_ox * sizeof(char*)		);
		for (i = 0; i < gv.len_ox; i++){
			gv.ox[i] 		= malloc(20 * sizeof(char));	
			strcpy(gv.ox[i],db.ox[i]);
		}

		gv.PP_list 			= malloc (gv.len_pp * sizeof(char*)		);
		for (i = 0; i < (gv.len_pp); i++){	
			gv.PP_list[i] 	= malloc(20 * sizeof(char));
			strcpy(gv.PP_list[i],db.PP[i]);
		}

		gv.SS_list 			= malloc ((gv.len_ss) * sizeof (char*)	);
		gv.n_SS_PC     		= malloc ((gv.len_ss) * sizeof (int) 	);
		gv.verifyPC  		= malloc ((gv.len_ss) * sizeof (int) 	);
		gv.SS_PC_stp     	= malloc ((gv.len_ss) * sizeof (double) );
		for (i = 0; i < gv.len_ss; i++){ 
			gv.SS_list[i] 	= malloc(20 * sizeof(char)				);
			strcpy(gv.SS_list[i],db.SS[i]);
			gv.verifyPC[i]  = db.verifyPC[i]; 
			gv.n_SS_PC[i] 	= db.n_SS_PC[i]; 
			gv.SS_PC_stp[i] = db.SS_PC_stp[i]; 	
		}

	}
	else if (gv.EM_database == 2){
		igneous_dataset db 	= igneous_db;
		gv.n_em_db 			= db.n_em_db;
		gv.len_pp   		= db.n_pp;		
		gv.len_ss  			= db.n_ss;
		gv.len_ox  			= db.n_ox;

		gv.PC_df_add		= db.PC_df_add;					/** min value of df under which the PC is added 									*/
		gv.solver_switch_T  = db.solver_switch_T;
		gv.min_melt_T       = db.min_melt_T;				/** minimum temperature above which melt is considered 								*/

		gv.inner_PGE_ite    = db.inner_PGE_ite;				/** number of inner PGE iterations, this has to be made mass or dG dependent 		*/
		gv.max_n_phase  	= db.max_n_phase;				/** maximum mol% phase change during one PGE iteration in wt% 						*/
		gv.max_g_phase  	= db.max_g_phase;				/** maximum delta_G of reference change during PGE 									*/
		gv.max_fac          = db.max_fac;					/** maximum update factor during PGE under-relax < 0.0, over-relax > 0.0 	 		*/

		gv.merge_value		= db.merge_value;				/** merge instances of solution phase if norm < val 								*/
		gv.re_in_n          = db.re_in_n;					/** fraction of phase when being reintroduce.  										*/
		gv.obj_tol 			= db.obj_tol;

		gv.ox 				= malloc (gv.len_ox * sizeof(char*)		);
		for (i = 0; i < gv.len_ox; i++){
			gv.ox[i] 		= malloc(20 * sizeof(char));	
			strcpy(gv.ox[i],db.ox[i]);
		}

		gv.PP_list 			= malloc (gv.len_pp * sizeof(char*)		);
		for (i = 0; i < (gv.len_pp); i++){	
			gv.PP_list[i] 	= malloc(20 * sizeof(char));
			strcpy(gv.PP_list[i],db.PP[i]);
		}

		gv.SS_list 			= malloc ((gv.len_ss) * sizeof (char*)	);
		gv.n_SS_PC     		= malloc ((gv.len_ss) * sizeof (int) 	);
		gv.verifyPC  		= malloc ((gv.len_ss) * sizeof (int) 	);
		gv.SS_PC_stp     	= malloc ((gv.len_ss) * sizeof (double) );
		for (i = 0; i < gv.len_ss; i++){ 
			gv.SS_list[i] 	= malloc(20 * sizeof(char)				);
			strcpy(gv.SS_list[i],db.SS[i]);
			gv.verifyPC[i]  = db.verifyPC[i]; 
			gv.n_SS_PC[i] 	= db.n_SS_PC[i]; 
			gv.SS_PC_stp[i] = db.SS_PC_stp[i]; 	
		}
	}

	/**
	   ALLOCATE MEMORY OF OTHER GLOBAL VARIABLES
	*/
	gv.bulk_rock 		= malloc (gv.len_ox * sizeof(double)	);
	gv.PGE_mass_norm  	= malloc (gv.it_f*2 * sizeof (double) 	); 
	gv.Alg  			= malloc (gv.it_f*2 * sizeof (int) 		); 
	gv.gamma_norm  		= malloc (gv.it_f*2 * sizeof (double) 	); 
	gv.ite_time  		= malloc (gv.it_f*2 * sizeof (double) 	); 
	
	/* store values for numerical differentiation */
	/* The last entries MUST be [0-1][end] = 0.0  */
	gv.n_Diff = 11;
	gv.pdev = malloc (2 * sizeof(double*));			
    for (i = 0; i < 2; i++){
		gv.pdev[i] = malloc (gv.n_Diff * sizeof(double));
	}
	gv.pdev[0][0]  =  0.0;	gv.pdev[1][0]  =  1.0;	
	gv.pdev[0][1]  =  0.0;	gv.pdev[1][1]  = -1.0;	
	gv.pdev[0][2]  =  1.0;	gv.pdev[1][2]  =  1.0;	
	gv.pdev[0][3]  =  1.0;	gv.pdev[1][3]  = -1.0;	
	gv.pdev[0][4]  =  2.0;	gv.pdev[1][4]  =  0.0;
	gv.pdev[0][5]  =  1.0;	gv.pdev[1][5]  =  0.0;	
	gv.pdev[0][6]  =  0.0;	gv.pdev[1][6]  =  0.0;
	gv.pdev[0][7]  =  3.0;	gv.pdev[1][7]  =  0.0;
	gv.pdev[0][8]  =  1.0;	gv.pdev[1][8]  =  0.0;
	gv.pdev[0][9]  =  0.0;	gv.pdev[1][9]  =  0.0;
	gv.pdev[0][10] =  0.0;	gv.pdev[1][10] =  0.0;

	gv.V_cor = malloc (2 * sizeof(double));

	/* declare size of chemical potential (gamma) vector */
	gv.dGamma 			= malloc (gv.len_ox * sizeof(double)	);
	gv.gam_tot  		= malloc (gv.len_ox * sizeof (double) 	); 
	gv.gam_tot_0		= malloc (gv.len_ox * sizeof (double) 	); 
	gv.delta_gam_tot  	= malloc (gv.len_ox * sizeof (double) 	); 
	gv.mass_residual 	= malloc (gv.len_ox * sizeof(double)	);	

	gv.lwork 			= 64;
	gv.ipiv     		= malloc ((gv.len_ox*3) * sizeof (int) 	);
	gv.work     		= malloc ((gv.len_ox*gv.lwork) * sizeof (double) 	);

	gv.n_solvi			= malloc ((gv.len_ss) * sizeof (int) 	);
    gv.id_solvi 		= malloc ((gv.len_ss) * sizeof (int*)	);
    
	for (i = 0; i < gv.len_ss; i++){ 
		gv.id_solvi[i]  = malloc (gv.max_n_cp  * sizeof(int)); 	
	}
	
	/* size of the flag array */
    gv.n_flags     = 6;

	/* allocate memory for pure and solution phase fractions */
	gv.pp_n    			= malloc (gv.len_pp * sizeof(double)	);									/** pure phase fraction vector */
	gv.pp_n_mol 		= malloc (gv.len_pp * sizeof(double)	);									/** pure phase fraction vector */
	gv.pp_xi    		= malloc (gv.len_pp * sizeof(double)	);									/** pure phase fraction vector */
	gv.delta_pp_n 		= malloc (gv.len_pp * sizeof(double)	);									/** pure phase fraction vector */
	gv.delta_pp_xi 		= malloc (gv.len_pp * sizeof(double)	);									/** pure phase fraction vector */
    gv.pp_flags 		= malloc (gv.len_pp * sizeof(int*)		);

	for (i = 0; i < (gv.len_pp); i++){	
		gv.pp_flags[i]   	= malloc (gv.n_flags  * sizeof(int));
	}
		
	/**
		PGE Matrix and RHS
	*/
	/* PGE method matrix and gradient arrays */
	gv.A_PGE  = malloc ((gv.len_ox*gv.len_ox*4) 	* sizeof(double));			
	gv.A0_PGE = malloc ((gv.len_ox*gv.len_ox*4) 	* sizeof(double));			
	gv.b_PGE  = malloc ((gv.len_ox*gv.len_ox) 		* sizeof(double));			

	gv.cp_id  = malloc ((gv.len_ox) 				* sizeof(int)	);			
	gv.pp_id  = malloc ((gv.len_ox) 				* sizeof(int)	);			

	gv.dn_cp  = malloc ((gv.len_ox) 				* sizeof(double));			
	gv.dn_pp  = malloc ((gv.len_ox) 				* sizeof(double));			

	/* stoechiometry matrix */
	gv.A = malloc ((gv.len_ox) * sizeof(double*));			
    for (i = 0; i < (gv.len_ox); i++){
		gv.A[i] = malloc ((gv.len_ox) * sizeof(double));
	}
	gv.b = malloc (gv.len_ox * sizeof(double));	


	/** 
		allocate oxides informations 						
	*/	
	z_b->apo     		= malloc (gv.len_ox * sizeof (double) ); 
	z_b->masspo     	= malloc (gv.len_ox * sizeof (double) );


	/**
		retrieve the right set of oxide and their informations 
	*/
	oxide_data ox_in 	= oxide_info;
    for (i = 0; i < gv.len_ox; i++){
    	for (j = 0; j < ox_in.n_ox; j++){
			if (strcmp( gv.ox[i], ox_in.oxName[j]) == 0){
				z_b->apo[i]     = ox_in.atPerOx[j];
				z_b->masspo[i]  = ox_in.oxMass[j];
				break;
			}
		}
	}

	z_b->bulk_rock_cat  = malloc (gv.len_ox * sizeof (double) ); 
	z_b->bulk_rock  	= malloc (gv.len_ox * sizeof (double) ); 

	return gv;
}


/* Get benchmark bulk rock composition given by Holland et al., 2018*/
global_variable get_bulk_metapelite( global_variable gv) {
 	if (gv.test != -1){
		if (gv.verbose == 1){
			printf("\n");
			printf("   - Minimization using in-built bulk-rock  : test %2d\n",gv.test);	
		}							
	}
	else{
		gv.test = 0;
		if (gv.verbose == 1){
			printf("\n");
			printf("   - No predefined bulk provided -> user custom bulk (if none provided, will run default KLB1)\n");	
		}	
	}
	if (gv.test == 0){ 			//FPWorldMedian pelite
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O MnO H2O 	*/
		/* Forshaw, J. B., & Pattison, D. R. (2023) 		*/
		gv.bulk_rock[0]  = 70.999;		/** SiO2 	*/
		gv.bulk_rock[1]  = 12.8065;		/** Al2O2 	*/
		gv.bulk_rock[2]  = 0.771;		/** CaO  	*/
		gv.bulk_rock[3]  = 3.978;		/** MgO 	*/
		gv.bulk_rock[4]  = 6.342;		/** FeO 	*/
		gv.bulk_rock[5]  = 2.7895;		/** K2O	 	*/
		gv.bulk_rock[6]  = 1.481;		/** Na2O 	*/
		gv.bulk_rock[7]  = 0.758;		/** TiO2 	*/
		gv.bulk_rock[8]  = 0.72933;		/** O 		*/
		gv.bulk_rock[9]  = 0.075;		/** MnO 	*/
		gv.bulk_rock[10] = 30.000;		/** H2O 	*/
	}		
	else if (gv.test == 1){ 			//FPWorldMedian pelite !! WATER UNDER SATURATED!!
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O MnO H2O 	*/
		/* Forshaw, J. B., & Pattison, D. R. (2023) 		*/
		gv.bulk_rock[0]  = 70.999;		/** SiO2 	*/
		gv.bulk_rock[1]  = 12.8065;		/** Al2O2 	*/
		gv.bulk_rock[2]  = 0.771;		/** CaO  	*/
		gv.bulk_rock[3]  = 3.978;		/** MgO 	*/
		gv.bulk_rock[4]  = 6.342;		/** FeO 	*/
		gv.bulk_rock[5]  = 2.7895;		/** K2O	 	*/
		gv.bulk_rock[6]  = 1.481;		/** Na2O 	*/
		gv.bulk_rock[7]  = 0.758;		/** TiO2 	*/
		gv.bulk_rock[8]  = 0.72933;		/** O 		*/
		gv.bulk_rock[9]  = 0.075;		/** MnO 	*/
		gv.bulk_rock[10] = 5.000;		/** H2O 	*/
	}	
	else if (gv.test == 2){ 			//Pelite 
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O MnO H2O 	*/
		/* White et al., 2014, Fig 8. water oversaturated 	*/
		gv.bulk_rock[0]  = 64.578;		/** SiO2 	*/
		gv.bulk_rock[1]  = 13.651;		/** Al2O2 	*/
		gv.bulk_rock[2]  = 1.586;		/** CaO  	*/
		gv.bulk_rock[3]  = 5.529;		/** MgO 	*/
		gv.bulk_rock[4]  = 8.025;		/** FeO 	*/
		gv.bulk_rock[5]  = 2.943;		/** K2O	 	*/
		gv.bulk_rock[6]  = 2.000;		/** Na2O 	*/
		gv.bulk_rock[7]  = 0.907;		/** TiO2 	*/
		gv.bulk_rock[8]  = 0.65;		/** O 		*/
		gv.bulk_rock[9]  = 0.175;		/** MnO 	*/
		gv.bulk_rock[10] = 40.000;		/** H2O 	*/
	}	
	else if (gv.test == 3){ 			//Pelite 
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O MnO H2O 	*/
		/* White et al., 2014, Fig 8. water undersaturated 	*/
		gv.bulk_rock[0]  = 64.578;		/** SiO2 	*/
		gv.bulk_rock[1]  = 13.651;		/** Al2O2 	*/
		gv.bulk_rock[2]  = 1.586;		/** CaO  	*/
		gv.bulk_rock[3]  = 5.529;		/** MgO 	*/
		gv.bulk_rock[4]  = 8.025;		/** FeO 	*/
		gv.bulk_rock[5]  = 2.943;		/** K2O	 	*/
		gv.bulk_rock[6]  = 2.000;		/** Na2O 	*/
		gv.bulk_rock[7]  = 0.907;		/** TiO2 	*/
		gv.bulk_rock[8]  = 0.65;		/** O 		*/
		gv.bulk_rock[9]  = 0.175;		/** MnO 	*/
		gv.bulk_rock[10] = 6.244;		/** H2O 	*/
	}		
	else if (gv.test == 4){ 			//Pelite 
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O MnO H2O 	*/
		/* Garnet-Migmatite AV0832a (Riel et al., 2013) 	*/
		gv.bulk_rock[0]  = 73.9880;		/** SiO2 	*/
		gv.bulk_rock[1]  = 8.6143;		/** Al2O2 	*/
		gv.bulk_rock[2]  = 2.0146;		/** CaO  	*/
		gv.bulk_rock[3]  = 2.7401;		/** MgO 	*/
		gv.bulk_rock[4]  = 3.8451;		/** FeO 	*/
		gv.bulk_rock[5]  = 1.7686;		/** K2O	 	*/
		gv.bulk_rock[6]  = 2.4820;		/** Na2O 	*/
		gv.bulk_rock[7]  = 0.6393;		/** TiO2 	*/
		gv.bulk_rock[8]  = 0.1;			/** O 		*/
		gv.bulk_rock[9]  = 0.0630;		/** MnO 	*/
		gv.bulk_rock[10] = 10.0;		/** H2O 	*/
	}
	else{
		printf("Unknown test %i - please specify a different test! \n", gv.test);
	 	exit(EXIT_FAILURE);
	}
	return gv;
}

/* Get benchmark bulk rock composition given by Holland et al., 2018*/
global_variable get_bulk_igneous( global_variable gv) {
 	if (gv.test != -1){
		if (gv.verbose == 1){
			printf("\n");
			printf("   - Minimization using in-built bulk-rock  : test %2d\n",gv.test);	
		}							
	}
	else{
		gv.test = 0;
		if (gv.verbose == 1){
			printf("\n");
			printf("   - No predefined bulk provided -> user custom bulk (if none provided, will run default KLB1)\n");	
		}	
	}
	if (gv.test == 0){ //KLB1
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* Bulk rock composition of Peridotite from Holland et al., 2018, given by E. Green */
		gv.bulk_rock[0]  = 38.494 ;		/** SiO2 	*/
		gv.bulk_rock[1]  = 1.776;		/** Al2O2 	*/
		gv.bulk_rock[2]  = 2.824;		/** CaO  	*/
		gv.bulk_rock[3]  = 50.566;		/** MgO 	*/
		gv.bulk_rock[4]  = 5.886;		/** FeO 	*/
		gv.bulk_rock[5]  = 0.01;		/** K2O	 	*/
		gv.bulk_rock[6]  = 0.250;		/** Na2O 	*/
		gv.bulk_rock[7]  = 0.10;		/** TiO2 	*/
		gv.bulk_rock[8]  = 0.096;		/** O 		*/
		gv.bulk_rock[9]  = 0.109;		/** Cr2O3 	*/
		gv.bulk_rock[10] =	0.0;	
	}
	
	else if (gv.test == 1){ //RE46
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* Bulk rock composition of RE46 - Icelandic basalt -Yang et al., 1996, given by E. Green */
		/*   50.72   9.16  15.21  16.25  7.06   0.01  1.47   0.39   0.35   0.01  */
		gv.bulk_rock[0] = 50.72;	
		gv.bulk_rock[1] = 9.16;	
		gv.bulk_rock[2] = 15.21;	
		gv.bulk_rock[3] = 16.25;	
		gv.bulk_rock[4] = 7.06;	
		gv.bulk_rock[5] = 0.01;	
		gv.bulk_rock[6]  = 1.47;
		gv.bulk_rock[7]  = 0.39;
		gv.bulk_rock[8]  = 0.35;
		gv.bulk_rock[9]  = 0.01;
		gv.bulk_rock[10] =	0.0;
	}
	else if (gv.test == 2){
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* N_MORB, Gale et al., 2013, given by E. Green */
		gv.bulk_rock[0] = 53.21;	
		gv.bulk_rock[1] = 9.41;	
		gv.bulk_rock[2] = 12.21;	
		gv.bulk_rock[3] = 12.21;	
		gv.bulk_rock[4] = 8.65;	
		gv.bulk_rock[5] = 0.09;	
		gv.bulk_rock[6]  = 2.90;
		gv.bulk_rock[7]  = 1.21;
		gv.bulk_rock[8]  = 0.69;
		gv.bulk_rock[9]  = 0.02;
		gv.bulk_rock[10] =	0.0;
	}
	else if (gv.test == 3){ //MIX1G
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* MIX1-G, Hirschmann et al., 2003, given by E. Green */
		gv.bulk_rock[0] = 45.25;	
		gv.bulk_rock[1] = 8.89;	
		gv.bulk_rock[2] = 12.22;	
		gv.bulk_rock[3] = 24.68;	
		gv.bulk_rock[4] = 6.45;	
		gv.bulk_rock[5] = 0.03;	
		gv.bulk_rock[6]  = 1.39;
		gv.bulk_rock[7]  = 0.67;
		gv.bulk_rock[8]  = 0.11;
		gv.bulk_rock[9]  = 0.02;
		gv.bulk_rock[10] =	0.0;
	}
	else if (gv.test == 4){
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* High Al basalt Baker 1983 */
		gv.bulk_rock[0] = 54.40;	
		gv.bulk_rock[1] = 12.96;	
		gv.bulk_rock[2] = 11.31;	
		gv.bulk_rock[3] = 7.68;	
		gv.bulk_rock[4] = 8.63;	
		gv.bulk_rock[5] = 0.54;	
		gv.bulk_rock[6]  = 3.93;
		gv.bulk_rock[7]  = 0.79;
		gv.bulk_rock[8]  = 0.41;
		gv.bulk_rock[9]  = 0.01;
		gv.bulk_rock[10] =	0.0;
	}	
	else if (gv.test == 5){ //T101
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* Tonalite 101 */
		gv.bulk_rock[0] = 66.01;	
		gv.bulk_rock[1] = 11.98;	
		gv.bulk_rock[2] = 7.06;	
		gv.bulk_rock[3] = 4.16;	
		gv.bulk_rock[4] = 5.30;	
		gv.bulk_rock[5] = 1.57;	
		gv.bulk_rock[6]  = 4.12;
		gv.bulk_rock[7]  = 0.66;
		gv.bulk_rock[8]  = 0.97;
		gv.bulk_rock[9]  = 0.01;
		gv.bulk_rock[10] =	50.0;
	}		
	else if (gv.test == 6){	//Wet Basalt
		/* SiO2 Al2O3 CaO MgO FeO K2O Na2O TiO2 O Cr2O3 H2O */
		/* Bulk rock composition of test 8 */
		gv.bulk_rock[0] = 50.0810;	
		gv.bulk_rock[1] = 8.6901;	
		gv.bulk_rock[2] = 11.6698;	
		gv.bulk_rock[3] = 12.1438;	
		gv.bulk_rock[4] = 7.7832;	
		gv.bulk_rock[5] = 0.2150;
		gv.bulk_rock[6]  = 2.4978;
		gv.bulk_rock[7]  = 1.0059;
		gv.bulk_rock[8]  = 0.4670;
		gv.bulk_rock[9]  = 0.0100;
		gv.bulk_rock[10] =	5.4364;
	}
	else{
		printf("Unknown test %i - please specify a different test! \n", gv.test);
	 	exit(EXIT_FAILURE);
	}
	return gv;
}


/**
  reset global variable for parallel calculations 
*/
global_variable reset_gv(					global_variable 	 gv,
											bulk_info 	 z_b,
											PP_ref 				*PP_ref_db,
											SS_ref 				*SS_ref_db
){

	int i,j,k;
	for (k = 0; k < gv.n_flags; k++){
		for (i = 0; i < gv.len_pp; i++){
			gv.pp_flags[i][k]   = 0;
		}
		for (int i = 0; i < gv.len_ss; i++){ 
			SS_ref_db[i].ss_flags[k]   = 0;
		}
	}
	
	/* reset pure phases fractions and xi */
	for (int i = 0; i < gv.len_pp; i++){		
		gv.pp_n[i] 		  = 0.0;
		gv.pp_n_mol[i]	  = 0.0;
		gv.delta_pp_n[i]  = 0.0;
		gv.pp_xi[i] 	  = 0.0;
		gv.delta_pp_xi[i] = 0.0;
	}
	
	/* reset pure phases */
	char liq_tail[] = "L";
	for (int i = 0; i < gv.len_pp; i++){
		if ( EndsWithTail(gv.PP_list[i], liq_tail) == 1 ){
			if (z_b.T < gv.min_melt_T){
				gv.pp_flags[i][0] = 0;
				gv.pp_flags[i][1] = 0;
				gv.pp_flags[i][2] = 0;
				gv.pp_flags[i][3] = 1;
			}
			else{
				gv.pp_flags[i][0] = 1;
				gv.pp_flags[i][1] = 0;
				gv.pp_flags[i][2] = 0;
				gv.pp_flags[i][3] = 0;
			}
		}
		// else if(strcmp( gv.PP_list[i], "O2") == 0){
		// 	gv.pp_flags[i][0] = 0;
		// 	gv.pp_flags[i][1] = 0;
		// 	gv.pp_flags[i][2] = 0;
		// 	gv.pp_flags[i][3] = 1;
		// }
		else{
			gv.pp_flags[i][0] = 1;
			gv.pp_flags[i][1] = 0;
			gv.pp_flags[i][2] = 1;
			gv.pp_flags[i][3] = 0;
		}
	}
	gv.tot_time 	  	  = 0.0;
	gv.tot_min_time 	  = 0.0;
	gv.LP_PGE_switch	  = 0;
	gv.melt_fraction	  = 0.;
	gv.solid_fraction	  = 0.;
	gv.melt_density       = 0.;
	gv.melt_bulkModulus   = 0.;

	gv.solid_density      = 0.;
	gv.solid_bulkModulus  = 0.;
	gv.solid_shearModulus = 0.;
	gv.solid_Vp 		  = 0.;
	gv.solid_Vs 		  = 0.;

	// gv.melt_pressure 	  = 0.;
	gv.system_fO2 		  = 0.;
	gv.system_density     = 0.;
	gv.system_entropy     = 0.;
	gv.system_enthalpy    = 0.;
	gv.system_bulkModulus = 0.;
	gv.system_shearModulus= 0.;
	gv.system_Vp 		  = 0.;
	gv.system_Vs 		  = 0.;
	gv.system_volume	  = 0.;
	gv.V_cor[0]			  = 0.;
	gv.V_cor[1]			  = 0.;
	gv.check_PC1		  = 0;
	gv.check_PC2		  = 0;
	gv.len_cp 		  	  = 0;
	gv.ph_change  	      = 0;
	gv.BR_norm            = 1.0;					/** start with 1.0 																	*/
	gv.G_system           = 0.0;	
	gv.div				  = 0;
	gv.status			  = 0;
	gv.n_phase            = 0;                  /** reset the number of phases to start with */
	gv.global_ite		  = 0;					/** reset the number of global iteration to zero */
	gv.n_cp_phase         = 0;					/** reset the number of ss phases to start with */
	gv.n_pp_phase         = 0;					/** reset the number of pp phases to start with */
	gv.alpha          	  = gv.max_fac;

	/* reset iteration record */
	for (i = 0; i < gv.it_f; i++){	
		gv.Alg[i] 				= 0;
		gv.PGE_mass_norm[i] 	= 0.0;
		gv.gamma_norm[i] 		= 0.0;	
		gv.ite_time[i] 			= 0.0;
	}

	/* reset norm and residuals */
    for (i = 0; i < gv.len_ox; i++){	
        gv.mass_residual[i] = 0.0;
		gv.dGamma[i]     	= 0.0;
        gv.gam_tot[i]     	= 0.0;
        gv.gam_tot_0[i]   	= 0.0;
        gv.delta_gam_tot[i] = 0.0;
		gv.mass_residual[i] = 0.0;	
    }

    for (i = 0; i < gv.len_ss; i++){	
        gv.n_solvi[i] = 0;
		for (k = 0; k < gv.max_n_cp; k++){	
			gv.id_solvi[i][k] = 0;
		} 
    }

	for (i = 0; i < (gv.len_ox); i++){ 
		gv.b[i] = 0.0;
		for (j = 0; j < gv.len_ox; j++){
			gv.A[i][j] = 0.0;
		}
	}

	return gv;
}

/**
  reset stable phases entries
*/
void reset_sp(						global_variable 	 gv,
									stb_system  		*sp
){

	sp[0].frac_S_wt						= 0.0;
	sp[0].frac_M_wt						= 0.0;
	sp[0].frac_F_wt						= 0.0;

	sp[0].frac_S						= 0.0;
	sp[0].frac_M						= 0.0;
	sp[0].frac_F						= 0.0;

	/* reset system */
	for (int i = 0; i < gv.len_ox; i++){
		strcpy(sp[0].ph[i],"");	
		sp[0].bulk[i] 					= 0.0;
		sp[0].bulk_wt[i] 				= 0.0;
		sp[0].gamma[i] 					= 0.0;
		sp[0].bulk_S[i] 				= 0.0;
		sp[0].bulk_M[i] 				= 0.0;
		sp[0].bulk_F[i] 				= 0.0;
		sp[0].bulk_S_wt[i] 				= 0.0;
		sp[0].bulk_M_wt[i] 				= 0.0;
		sp[0].bulk_F_wt[i] 				= 0.0;
		sp[0].ph_type[i] 				= -1;
		sp[0].ph_id[i] 					=  0;
		sp[0].ph_frac[i] 				=  0.0;
		sp[0].ph_frac_wt[i] 			=  0.0;
	}

	/* reset phases */
	for (int n = 0; n < gv.len_ox; n++){
		for (int i = 0; i < gv.len_ox; i++){
			sp[0].PP[n].Comp[i] 			= 0.0;
			sp[0].SS[n].Comp[i] 			= 0.0;
			sp[0].PP[n].Comp_wt[i] 			= 0.0;
			sp[0].SS[n].Comp_wt[i] 			= 0.0;
			sp[0].SS[n].compVariables[i] 	= 0.0;
		}
		for (int i = 0; i < gv.len_ox+1; i++){
			strcpy(sp[0].SS[n].emNames[i],"");	
			
			sp[0].SS[n].emFrac[i] 			= 0.0;
			sp[0].SS[n].emFrac_wt[i] 		= 0.0;
			sp[0].SS[n].emChemPot[i] 		= 0.0;

			for (int j = 0; j < gv.len_ox; j++){
				sp[0].SS[n].emComp[i][j]	= 0.0;
				sp[0].SS[n].emComp_wt[i][j]	= 0.0;
			}
		}
	}

}

/**
  reset bulk rock composition informations (needed if the bulk-rock is not constant during parallel computation)
*/
bulk_info reset_z_b_bulk(			global_variable 	 gv,
									bulk_info 	 		 z_b
){
	int i, j, k;

	int sum = 0;
	for (i = 0; i < gv.len_ox; i++) {
		z_b.bulk_rock[i] = gv.bulk_rock[i];
		if (gv.bulk_rock[i] > 0.0){
			sum += 1;
		}
	}

	/** calculate fbc to be used for normalization factor of liq */
	z_b.fbc			= 0.0; 
	for (i = 0; i < gv.len_ox; i++){
		z_b.fbc += z_b.bulk_rock[i]*z_b.apo[i];
	}
	
	z_b.nzEl_val = sum;					/** store number of non zero values */
	z_b.zEl_val  = gv.len_ox - sum;			/** store number of zero values */
	
	z_b.nzEl_array  = malloc (z_b.nzEl_val * sizeof (int) ); 
	if (z_b.zEl_val > 0){
		z_b.zEl_array   = malloc (z_b.zEl_val * sizeof (int) ); 
		j = 0; k = 0;
		for (i = 0; i < gv.len_ox; i++){
			if (gv.bulk_rock[i] == 0.){
				z_b.zEl_array[j] = i;
				j += 1;
			}
			else{
				z_b.nzEl_array[k] = i;
				k += 1;
			}
		}
	}
	else {
		for (i = 0; i < gv.len_ox; i++){
			z_b.nzEl_array[i] = i;
		}
	}

	for ( i = 0; i < z_b.nzEl_val; i++){
		z_b.bulk_rock_cat[i] = z_b.bulk_rock[z_b.nzEl_array[i]];
	}
	for ( i = z_b.nzEl_val; i < gv.len_ox; i++){
		z_b.bulk_rock_cat[i] = 0.0;
	}
	
	return z_b;
};


/**
  reset considered phases entries
*/
void reset_cp(						global_variable 	 gv,
									bulk_info 	 z_b,
									csd_phase_set  		*cp
){
	
	for (int i = 0; i < gv.max_n_cp; i++){		
		strcpy(cp[i].name,"");						/* get phase name */	
		cp[i].in_iter			=  0;
		cp[i].split				=  0;
		cp[i].id 				= -1;				/* get phaseid */
		cp[i].n_xeos			=  0;				/* get number of compositional variables */
		cp[i].n_em				=  0;				/* get number of endmembers */
		cp[i].n_sf				=  0;			
		cp[i].df 				=  0.0;
		cp[i].factor 			=  0.0;
		
		for (int ii = 0; ii < gv.n_flags; ii++){
			cp[i].ss_flags[ii] 	= 0;
		}

		cp[i].ss_n        		= 0.0;				/* get initial phase fraction */
		cp[i].ss_n_mol      	= 0.0;				/* get initial phase fraction */
		cp[i].delta_ss_n    	= 0.0;				/* get initial phase fraction */
		
		for (int ii = 0; ii < gv.len_ox + 1; ii++){
			cp[i].p_em[ii]      = 0.0;
			cp[i].xi_em[ii]     = 0.0;
			cp[i].dguess[ii]    = 0.0;
			cp[i].xeos[ii]      = 0.0;
			cp[i].delta_mu[ii]  = 0.0;
			cp[i].dfx[ii]       = 0.0;
			cp[i].mu[ii]        = 0.0;
			cp[i].gbase[ii]     = 0.0;
			cp[i].ss_comp[ii]   = 0.0;
		}
		 
		for (int ii = 0; ii < (gv.len_ox + 1)*2; ii++){
			cp[i].sf[ii]    	= 0.0;
		}
		cp[i].mass 				= 0.0;
		cp[i].volume 			= 0.0;
		cp[i].phase_density 	= 0.0;
		cp[i].phase_cp 			= 0.0;
	}

};

/**
  reset compositional variables (xeos) when something goes wrong during minimization 
*/
void reset_SS(						global_variable 	 gv,
									bulk_info 	 z_b,
									SS_ref 				*SS_ref_db
){
	/* reset solution phases */
	for (int iss = 0; iss < gv.len_ss; iss++){

		for (int j = 0; j < gv.n_flags; j++){	
			SS_ref_db[iss].ss_flags[j]   = 0;
		}

		SS_ref_db[iss].min_mode	= 1;
		SS_ref_db[iss].tot_pc 	= 0;
		SS_ref_db[iss].id_pc  	= 0;
		for (int j = 0; j < gv.len_ox; j++){
			SS_ref_db[iss].solvus_id[j] = -1;	
		}

		/* reset levelling pseudocompounds */
		for (int i = 0; i < (SS_ref_db[iss].tot_pc); i++){
			SS_ref_db[iss].info[i]   = 0;
			SS_ref_db[iss].G_pc[i]   = 0.0;
			SS_ref_db[iss].DF_pc[i]  = 0.0;
			for (int j = 0; j < gv.len_ox; j++){
				SS_ref_db[iss].comp_pc[i][j]  = 0.0;
			}
			for (int j = 0; j < SS_ref_db[iss].n_em; j++){
				SS_ref_db[iss].p_pc[i][j]  = 0.0;	
			}
			for (int j = 0; j < (SS_ref_db[iss].n_xeos); j++){
				SS_ref_db[iss].xeos_pc[i][j]  = 0.0;
			}
			SS_ref_db[iss].factor_pc[i] = 0.0;
		}

		/* reset LP part of PGE (algo 2.0) */
		SS_ref_db[iss].tot_Ppc 	= 0;
		SS_ref_db[iss].id_Ppc  	= 0;
		for (int i = 0; i < (SS_ref_db[iss].n_Ppc); i++){
			SS_ref_db[iss].info_Ppc[i]   = 0;
			SS_ref_db[iss].G_Ppc[i]      = 0.0;
			SS_ref_db[iss].DF_Ppc[i]     = 0.0;
			for (int j = 0; j < gv.len_ox; j++){
				SS_ref_db[iss].comp_Ppc[i][j]  = 0.0;
			}
			for (int j = 0; j < SS_ref_db[iss].n_em; j++){
				SS_ref_db[iss].p_Ppc[i][j]  = 0;	
				SS_ref_db[iss].mu_Ppc[i][j] = 0;	
			}
			for (int j = 0; j < (SS_ref_db[iss].n_xeos); j++){
				SS_ref_db[iss].xeos_Ppc[i][j]  = 0.0;
			}
			SS_ref_db[iss].factor_Ppc[i] = 0.0;
		}

		/* reset solution phase model parameters */
		for (int j = 0; j < SS_ref_db[iss].n_em; j++){
			SS_ref_db[iss].gb_lvl[j]     = 0.0;
			SS_ref_db[iss].gbase[j]      = 0.0;
			SS_ref_db[iss].xi_em[j]      = 0.0;
			SS_ref_db[iss].z_em[j]       = 1.0;
			SS_ref_db[iss].mu[j] 	     = 0.0;
		}
		SS_ref_db[iss].sum_xi		     = 0.0;
		SS_ref_db[iss].df			     = 0.0;
		SS_ref_db[iss].df_raw		     = 0.0;

		for (int k = 0; k < SS_ref_db[iss].n_xeos; k++) {					/** initialize initial guess using default thermocalc guess	*/ 
			SS_ref_db[iss].iguess[k]     = 0.0;
			SS_ref_db[iss].dguess[k]     = 0.0;
			SS_ref_db[iss].mguess[k]     = 0.0;
			SS_ref_db[iss].xeos[k]       = 0.0;
			SS_ref_db[iss].bounds[k][0]  = SS_ref_db[iss].bounds_ref[k][0];
			SS_ref_db[iss].bounds[k][1]  = SS_ref_db[iss].bounds_ref[k][1];
			SS_ref_db[iss].xeos_sf_ok[k] = 0.0;
		}

		for (int j = 0; j < SS_ref_db[iss].n_em; j++){
			SS_ref_db[iss].p[j]     = 0.0;
			SS_ref_db[iss].ape[j]   = 0.0;
		}
		SS_ref_db[iss].forced_stop = 0; 
		SS_ref_db[iss].min_mode    = 1;
		SS_ref_db[iss].nlopt_verb  = 0; // no output by default
	}

};

/**
  function to allocate memory for simplex linear programming (A)
*/	
void init_simplex_A( 	simplex_data 		*splx_data,
						global_variable 	 gv
){
	simplex_data *d  = (simplex_data *) splx_data;

	/* prescribe tolerance parameters */
	d->dG_B_tol	   = -1e-6;
	d->min_F_tol   =  1e6;
	
	/* allocate reference assemblage memory */
	d->A           = malloc ((gv.len_ox*gv.len_ox)  * sizeof(double));
	d->Alu         = malloc ((gv.len_ox*gv.len_ox)  * sizeof(double));
	d->A1  		   = malloc ((gv.len_ox*gv.len_ox)  * sizeof(double));
	
	d->ph_id_A     = malloc (gv.len_ox * sizeof(int*));
    for (int i = 0; i < gv.len_ox; i++){
		d->ph_id_A[i] = malloc ((gv.len_ox*4)  * sizeof(int));
	}
	
	d->pivot   	   = malloc ((gv.len_ox) * sizeof(int));
	d->g0_A   	   = malloc ((gv.len_ox) * sizeof(double));
	d->dG_A   	   = malloc ((gv.len_ox) * sizeof(double));
	d->n_vec   	   = malloc ((gv.len_ox) * sizeof(double));
	d->stage   	   = malloc ((gv.len_ox) * sizeof(int));

	d->gamma_ps	   = malloc ((gv.len_ox) * sizeof(double));
	d->gamma_ss	   = malloc ((gv.len_ox) * sizeof(double));
	d->gamma_tot   = malloc ((gv.len_ox) * sizeof(double));
	d->gamma_delta = malloc ((gv.len_ox) * sizeof(double));

	/* initialize arrays */
	int k;
    for (int i = 0; i < gv.len_ox; i++){
		d->gamma_tot[i] 	= 0.0;
		d->gamma_delta[i] 	= 0.0;
		d->pivot[i]	   = 0;
		d->g0_A[i]     = 0.0;
		d->dG_A[i]     = 0.0;
		d->n_vec[i]    = 0.0;
		d->gamma_ps[i] = 0.0;
		d->gamma_ss[i] = 0.0;
		
		for (int j = 0; j < gv.len_ox; j++){
			k = i + j*gv.len_ox;
			d->A[k]  = 0.0;
			d->A1[k] = 0.0;
		}
		
		for (int j = 0; j < 4; j++){
			d->ph_id_A[i][j] = 0;
		}
	}

};

/**
  function to allocate memory for simplex linear programming (B)
*/	
void init_simplex_B_em(				simplex_data 		 *splx_data,
									global_variable 	 gv

){
	simplex_data *d  = (simplex_data *) splx_data;
	
	d->ph_id_B    = malloc (3  * sizeof(int));
	d->B   	 	  = malloc ((gv.len_ox) * sizeof(double));
	d->B1   	  = malloc ((gv.len_ox) * sizeof(double));

	/** initialize arrays */
	for (int j = 0; j < 3; j++){
		d->ph_id_B[j] = 0;
	}

	for (int j = 0; j < gv.len_ox; j++){
		d->B[j]   = 0.0;	
		d->B1[j]  = 0.0;	
	}
};

/**
  function to allocate memory for simplex linear programming (A)
*/	
void reset_simplex_A( 	simplex_data 		*splx_data,
 						bulk_info 	 		 z_b,
						global_variable 	 gv
){
	simplex_data *d  = (simplex_data *) splx_data;
	
	/* allocate reference assemblage memory */
	d->n_local_min =  0;
	d->n_filter    =  0;
	d->ph2swp      = -1;
	d->n_swp       =  0;
	d->swp         =  0;
	d->n_Ox        =  z_b.nzEl_val;

	/* initialize arrays */
	int k;
    for (int i = 0; i < gv.len_ox; i++){
		d->gamma_tot[i] 	= 0.0;
		d->gamma_delta[i] 	= 0.0;
		d->pivot[i]	  = 0;
		d->g0_A[i]     = 0.0;
		d->dG_A[i]     = 0.0;
		d->n_vec[i]    = 0.0;
		d->stage[i]    = 0;
		d->gamma_ps[i] = 0.0;
		d->gamma_ss[i] = 0.0;
		
		for (int j = 0; j < gv.len_ox; j++){
			k = i + j*gv.len_ox;
			d->A[k]  = 0.0;
			d->Alu[k] = 0.0;
			d->A1[k] = 0.0;
		}
		
		for (int j = 0; j < 4; j++){
			d->ph_id_A[i][j] = 0;
		}
	}


};

/**
  function to allocate memory for simplex linear programming (B)
*/	
void reset_simplex_B_em(			simplex_data 		*splx_data,
									global_variable 	 gv

){
	simplex_data *d  = (simplex_data *) splx_data;

	/** initialize arrays */
	for (int j = 0; j < 3; j++){
		d->ph_id_B[j] = 0;
	}

	for (int j = 0; j < gv.len_ox; j++){
		d->B[j]   = 0.0;	
		d->B1[j]  = 0.0;	
	}
};

#endif
