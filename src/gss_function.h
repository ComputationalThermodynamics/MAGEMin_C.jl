#ifndef __GSS_FUNCTION_H_
#define __GSS_FUNCTION_H_

#include "MAGEMin.h"

SS_ref G_SS_mp_EM_function(	global_variable  gv, 
							SS_ref 			 SS_ref_db,
							int 			 EM_database,
							bulk_info 		 z_b,
							char 			*name					);
							
SS_ref G_SS_mb_EM_function(	global_variable  gv, 
							SS_ref 			 SS_ref_db,
							int 			 EM_database,
							bulk_info 		 z_b,
							char 			*name					);

SS_ref G_SS_ig_EM_function(	global_variable  gv, 
							SS_ref 			 SS_ref_db,
							int 			 EM_database,
							bulk_info 		 z_b,
							char 			*name					);

SS_ref G_SS_um_EM_function(	global_variable  gv, 
							SS_ref 			 SS_ref_db,
							int 			 EM_database,
							bulk_info 		 z_b,
							char 			*name					);

typedef struct em_datas{
	double C[14];
	double ElShearMod;
	double gb;
    double charge;	
} em_data;

em_data get_em_data(	int 		 EM_database, 
						int          len_ox,
						bulk_info 	 z_b,
                        double       P,
                        double       T,
						char 		*name, 
						char 		*state			);

em_data get_fs_data(	int             len_ox,
						bulk_info 	    z_b,
                        solvent_prop   *wat,
                        double          P,
                        double          T,
						char 		   *name, 
						char 		   *state		);
#endif
