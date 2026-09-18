/*@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 **
 **   Project      : MAGEMin
 **   License      : GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
 **   Developers   : Nicolas Riel, Boris Kaus
 **   Contributors : Moccetti, N. B., Dominguez, H., Assunção J., Green E., Dolejš, D., Berlie N., and Rummel L.
 **   Organization : Institute of Geosciences, Johannes-Gutenberg University, Mainz
 **   Contact      : nriel[at]uni-mainz.de, kaus[at]uni-mainz.de
 **
 ** ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @*/
/**
       Input/Output function, to read and save data        
*/
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "MAGEMin.h"


/** 
  read in input data from file 
*/
void read_in_data(		global_variable 	 gv,
						io_data 			*input_data,												/** input data structure */
						int      			 n_points
){
	char line[1000];
	FILE* input_file = fopen(gv.File,"rt");	
	if (gv.File != NULL && input_file != NULL){						/** if input file is provided and exists */
		int k = 0;
		int l = 0;
		/* loop through all the lines of the input file making sure that the number of points is not exceeded */
		while( fgets(line, sizeof(line), input_file) != NULL && k < n_points){
			/* if this is the first line belonging to a PT point to take into account */
			if (l == 0){
				/* first allocate memory to fill gamma array */
				input_data[k].in_bulk      = malloc (gv.len_ox * sizeof (double) ); 
				for (int z = 0; z < gv.len_ox; z++){
					input_data[k].in_bulk[z] = 0.0; 
				}

				input_data[k].n_phase = 0;
				input_data[k].P       = 0.0;
				input_data[k].T       = 0.0;

				{
					char   *cur = line;
					char   *nxt = NULL;
					double  v;

					v = strtod(cur, &nxt);
					if (nxt != cur){ input_data[k].n_phase = (int)v; cur = nxt; }
					v = strtod(cur, &nxt);
					if (nxt != cur){ input_data[k].P = v; cur = nxt; }
					v = strtod(cur, &nxt);
					if (nxt != cur){ input_data[k].T = v; cur = nxt; }

					for (int z = 0; z < gv.len_ox; z++){
						v = strtod(cur, &nxt);
						if (nxt == cur){ break; }
						input_data[k].in_bulk[z] = v;
						cur = nxt;
					}
				}
				
				/* allocate memory depending on the number of provided solution phases */
				input_data[k].phase_names = malloc(input_data[k].n_phase * sizeof(char*));
				for (int i = 0; i < input_data[k].n_phase; i++){
					input_data[k].phase_names[i] = malloc(20 * sizeof(char));
				}
				
				/* allocate memory for compositional variables */
				//input_data[k].sum_phase_xeos = malloc(input_data[k].n_phase * sizeof(double));
				input_data[k].phase_xeos 	 = malloc(input_data[k].n_phase * sizeof(double*));
				for (int i = 0; i < input_data[k].n_phase; i++){
					input_data[k].phase_xeos[i] = malloc((gv.len_ox) * sizeof(double));
				}
				/* initialize x-eos to zeros in case there is mistake in the input file */
				for (int i = 0; i < input_data[k].n_phase; i++){
					for (int j = 0; j < (gv.len_ox); j++){
						input_data[k].phase_xeos[i][j] = gv.bnd_val;
					}
				}
				
				/* allocate memory for endmember fractions */
				//input_data[k].sum_phase_emp = malloc(input_data[k].n_phase * sizeof(double));
				input_data[k].phase_emp 	= malloc(input_data[k].n_phase * sizeof(double*));
				for (int i = 0; i < input_data[k].n_phase; i++){
					input_data[k].phase_emp[i] = malloc((gv.len_ox+1) * sizeof(double));
				}
				/* initialize x-eos to zeros in case there is mistake in the input file */
				for (int i = 0; i < input_data[k].n_phase; i++){
					for (int j = 0; j < (gv.len_ox+1); j++){
						input_data[k].phase_emp[i][j] = 0.0;
					}
				}
			}
			
			/* Lines belonging to the provided x-eos for each solution phase listed */
			/* allocates memory only if the number of phases is not 0 				*/
			if(l > 0 && l < input_data[k].n_phase+1){
				char   *cur = line;
				char   *nxt = NULL;
				double  v;

				if (sscanf(line, "%19s", input_data[k].phase_names[l-1]) == 1){
					cur = line + strspn(line, " \t");
					cur += strcspn(cur, " \t\n");
				}

				for (int j = 0; j < gv.len_ox; j++){
					v = strtod(cur, &nxt);
					if (nxt == cur){ break; }
					input_data[k].phase_xeos[l-1][j] = v;
					cur = nxt;
				}
				for (int j = 0; j < gv.len_ox+1; j++){
					v = strtod(cur, &nxt);
					if (nxt == cur){ break; }
					input_data[k].phase_emp[l-1][j] = v;
					cur = nxt;
				}
			}
			
			l++;
			/* reset line count when reading a phase is over and increase the phase count */
			if(l > input_data[k].n_phase){l = 0; k += 1;}
		}
		fclose(input_file);
	}
};

/**
  free memory allocated by read_in_data
*/
void free_input_data(	io_data 			*input_data,												/** input data structure */
						int      			 n_points
){
	for (int k = 0; k < n_points; k++){
		if (input_data[k].in_bulk != NULL){
			free(input_data[k].in_bulk);
		}
		if (input_data[k].phase_names != NULL){
			for (int i = 0; i < input_data[k].n_phase; i++){
				free(input_data[k].phase_names[i]);
			}
			free(input_data[k].phase_names);
		}
		if (input_data[k].phase_xeos != NULL){
			for (int i = 0; i < input_data[k].n_phase; i++){
				free(input_data[k].phase_xeos[i]);
			}
			free(input_data[k].phase_xeos);
		}
		if (input_data[k].phase_emp != NULL){
			for (int i = 0; i < input_data[k].n_phase; i++){
				free(input_data[k].phase_emp[i]);
			}
			free(input_data[k].phase_emp);
		}
	}
};


