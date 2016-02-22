/* Copyright (c) 2007-2014 Massachusetts Institute of Technology
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */
 
// Written in the D programming language.

/**
 * D bindings for the nlopt library.
 * 
 * Authors:   John Michael Hall
 * Date:      2/21/2016
 * See_Also:  $(LINK http://ab-initio.mit.edu/wiki/index.php/NLopt)
 */

module libnlopt.api;

import core.stdc.stddef;

extern(C) @nogc nothrow
{
	alias nlopt_func = double function(uint n, const(double)* x, 
									   double* gradient, 
									   void* func_data); 

	alias nlopt_mfunc = void function(uint m, double* result, 
									  uint n, const(double)* x, 
									  double* gradient, 
									  void* func_data);
/* A preconditioner, which preconditions v at x to return vpre. 
   (The meaning of "preconditioning" is algorithm-dependent.) */
	alias nlopt_precond = void function(uint n, double* x, 
										const(double)* v, double* vpre, 
										void* data);
}

enum nlopt_algorithm
{
/* Naming conventions:

	NLOPT_{G/L}{D/N}_* 
	= global/local derivative/no-derivative optimization, 
		  respectively 

*_RAND algorithms involve some randomization.

*_NOSCAL algorithms are *not* scaled to a unit hypercube
		 (i.e. they are sensitive to the units of x)
*/
    NLOPT_GN_DIRECT = 0,
    NLOPT_GN_DIRECT_L,
    NLOPT_GN_DIRECT_L_RAND,
    NLOPT_GN_DIRECT_NOSCAL,
    NLOPT_GN_DIRECT_L_NOSCAL,
    NLOPT_GN_DIRECT_L_RAND_NOSCAL,
    NLOPT_GN_ORIG_DIRECT,
    NLOPT_GN_ORIG_DIRECT_L,
    NLOPT_GD_STOGO,
    NLOPT_GD_STOGO_RAND,
    NLOPT_LD_LBFGS_NOCEDAL,
    NLOPT_LD_LBFGS,
    NLOPT_LN_PRAXIS,
    NLOPT_LD_VAR1,
    NLOPT_LD_VAR2,
    NLOPT_LD_TNEWTON,
    NLOPT_LD_TNEWTON_RESTART,
    NLOPT_LD_TNEWTON_PRECOND,
    NLOPT_LD_TNEWTON_PRECOND_RESTART,
    NLOPT_GN_CRS2_LM,
    NLOPT_GN_MLSL,
    NLOPT_GD_MLSL,
    NLOPT_GN_MLSL_LDS,
    NLOPT_GD_MLSL_LDS,
    NLOPT_LD_MMA,
    NLOPT_LN_COBYLA,
    NLOPT_LN_NEWUOA,
    NLOPT_LN_NEWUOA_BOUND,
    NLOPT_LN_NELDERMEAD,
    NLOPT_LN_SBPLX,
 /* new variants that require local_optimizer to be set,
not with older constants for backwards compatibility */
    NLOPT_LN_AUGLAG,
    NLOPT_LD_AUGLAG,
    NLOPT_LN_AUGLAG_EQ,
    NLOPT_LD_AUGLAG_EQ,
    NLOPT_LN_BOBYQA,
    NLOPT_GN_ISRES,
    NLOPT_AUGLAG,
    NLOPT_AUGLAG_EQ,
    NLOPT_G_MLSL,
    NLOPT_G_MLSL_LDS,
    NLOPT_LD_SLSQP,
    NLOPT_LD_CCSAQ,
    NLOPT_GN_ESCH,
    NLOPT_NUM_ALGORITHMS, /* not an algorithm, just the number of them */
}

extern(System) @nogc nothrow
{
	const(char*) nlopt_algorithm_name(nlopt_algorithm a);
}

enum nlopt_result
{
    NLOPT_FAILURE = -1, /* generic failure code */
    NLOPT_INVALID_ARGS = -2,
    NLOPT_OUT_OF_MEMORY = -3,
    NLOPT_ROUNDOFF_LIMITED = -4,
    NLOPT_FORCED_STOP = -5,
    NLOPT_SUCCESS = 1, /* generic success code */
    NLOPT_STOPVAL_REACHED = 2,
    NLOPT_FTOL_REACHED = 3,
    NLOPT_XTOL_REACHED = 4,
    NLOPT_MAXEVAL_REACHED = 5,
    NLOPT_MAXTIME_REACHED = 6,
}

enum NLOPT_MINF_MAX_REACHED = nlopt_result.NLOPT_STOPVAL_REACHED;

extern(System) @nogc nothrow 
{
	void nlopt_srand(uint seed);
	void nlopt_srand_time();
	
	void nlopt_version(int* major, int* minor, int* bugfix);
}

/*************************** OBJECT-ORIENTED API **************************/
/* The style here is that we create an nlopt_opt "object" (an opaque pointer),
   then set various optimization parameters, and then execute the
   algorithm.  In this way, we can add more and more optimization parameters
   (including algorithm-specific ones) without breaking backwards
   compatibility, having functions with zillions of parameters, or
   relying non-reentrantly on global variables.*/

struct nlopt_opt_s;
alias nlopt_opt_s *nlopt_opt;

/* the only immutable parameters of an optimization are the algorithm and
   the dimension n of the problem, since changing either of these could
   have side-effects on lots of other parameters */

extern(System) @nogc nothrow 
{

	nlopt_opt nlopt_create(nlopt_algorithm algorithm, uint n);
	void nlopt_destroy(nlopt_opt opt);
	nlopt_opt nlopt_copy(const(nlopt_opt) opt);
	
	nlopt_result nlopt_optimize(nlopt_opt opt, double* x,  double* opt_f);
	
	nlopt_result nlopt_set_min_objective(nlopt_opt opt, nlopt_func f, 
								         void* f_data);
	nlopt_result nlopt_set_max_objective(nlopt_opt opt, nlopt_func f, 
										 void* f_data);
										 
	nlopt_result nlopt_set_precond_min_objective(
		nlopt_opt opt, nlopt_func f, nlopt_precond pre, void* f_data);
	nlopt_result nlopt_set_precond_max_objective(
		nlopt_opt opt, nlopt_func f, nlopt_precond pre, void* f_data);
		
	nlopt_algorithm  nlopt_get_algorithm(const(nlopt_opt) opt);
	uint nlopt_get_dimension(const(nlopt_opt) opt);

/* constraints: */

	nlopt_result nlopt_set_lower_bounds(nlopt_opt opt, const(double)* lb);
	nlopt_result nlopt_set_lower_bounds1(nlopt_opt opt, double lb);
	nlopt_result nlopt_get_lower_bounds(const(nlopt_opt) opt, double* lb);
	nlopt_result nlopt_set_upper_bounds(nlopt_opt opt, const(double)* ub);
	nlopt_result nlopt_set_upper_bounds1(nlopt_opt opt, double ub);
	nlopt_result nlopt_get_upper_bounds(const(nlopt_opt) opt, double* ub);
	nlopt_result nlopt_remove_inequality_constraints(nlopt_opt opt);
	nlopt_result nlopt_add_inequality_constraint(
		nlopt_opt opt, nlopt_func fc, void* fc_data, double tol);
	nlopt_result nlopt_add_precond_inequality_constraint(
		nlopt_opt opt, nlopt_func fc, nlopt_precond pre, void* fc_data, 
		double tol);
	nlopt_result nlopt_add_inequality_mconstraint(
		nlopt_opt opt, uint m, nlopt_mfunc fc, void* fc_data, 
		const(double)* tol);
	nlopt_result nlopt_remove_equality_constraints(nlopt_opt opt);
	nlopt_result nlopt_add_equality_constraint(
		nlopt_opt opt, nlopt_func h, void* h_data, double tol);
	nlopt_result  nlopt_add_precond_equality_constraint(
		nlopt_opt opt, nlopt_func h, nlopt_precond pre, void* h_data, 
		double tol);
	nlopt_result nlopt_add_equality_mconstraint(
		nlopt_opt opt, uint m, nlopt_mfunc h, void* h_data, 
		const(double)* tol);

/* stopping criteria: */

	nlopt_result nlopt_set_stopval(nlopt_opt opt, double stopval);
	double nlopt_get_stopval(const(nlopt_opt) opt);
	
	nlopt_result nlopt_set_ftol_rel(nlopt_opt opt, double tol);
	double nlopt_get_ftol_rel(const(nlopt_opt) opt);
	nlopt_result nlopt_set_ftol_abs(nlopt_opt opt, double tol);
	double nlopt_get_ftol_abs(const(nlopt_opt) opt);

	nlopt_result nlopt_set_xtol_rel(nlopt_opt opt, double tol);
	double nlopt_get_xtol_rel(const(nlopt_opt) opt);
	nlopt_result nlopt_set_xtol_abs1(nlopt_opt opt, double tol);
	nlopt_result nlopt_set_xtol_abs(nlopt_opt opt, const(double)* tol);
	nlopt_result nlopt_get_xtol_abs(const(nlopt_opt) opt, double* tol);

	nlopt_result nlopt_set_maxeval(nlopt_opt opt, int maxeval);
	int nlopt_get_maxeval(const(nlopt_opt) opt);

	nlopt_result nlopt_set_maxtime(nlopt_opt opt, double maxtime);
	double nlopt_get_maxtime(const(nlopt_opt) opt);

	nlopt_result nlopt_force_stop(nlopt_opt opt);
	nlopt_result nlopt_set_force_stop(nlopt_opt opt, int val);
	int nlopt_get_force_stop(const(nlopt_opt) opt);

/* more algorithm-specific parameters */

	nlopt_result nlopt_set_local_optimizer(nlopt_opt opt, nlopt_opt local_opt);

	nlopt_result nlopt_set_population(nlopt_opt opt, uint pop);
	uint nlopt_get_population(const(nlopt_opt) opt);

	nlopt_result nlopt_set_vector_storage(nlopt_opt opt, uint dim);
	uint nlopt_get_vector_storage(const(nlopt_opt) opt);

	nlopt_result nlopt_set_default_initial_step(nlopt_opt opt, const(double)* x);
	nlopt_result nlopt_set_initial_step(nlopt_opt opt, const(double)* dx);
	nlopt_result nlopt_set_initial_step1(nlopt_opt opt, double dx);
	nlopt_result nlopt_get_initial_step(const(nlopt_opt) opt, 
										const(double)* x, 
										double* dx);
}

/* the following are functions mainly designed to be used internally
   by the Fortran and SWIG wrappers, allow us to tel nlopt_destroy and
   nlopt_copy to do something to the f_data pointers (e.g. free or
   duplicate them, respectively) */
   
extern(C) @nogc nothrow alias nlopt_munge = void* function(void* p); 
extern(System) @nogc nothrow void nlopt_set_munge(
	nlopt_opt opt, nlopt_munge munge_on_destroy, nlopt_munge munge_on_copy);
extern(C) @nogc nothrow alias nlopt_munge2 = void* function(void* p, void* data); 
extern(System) @nogc nothrow void nlopt_munge_data(
	nlopt_opt opt, nlopt_munge2 munge, void* data);

/*************************** DEPRECATED API **************************/
/* The new "object-oriented" API is preferred, since it allows us to
   gracefully add new features and algorithm-specific options in a
   re-entrant way, and we can automatically assume reasonable defaults
   for unspecified parameters. */
deprecated
{

	extern(C) @nogc nothrow 
	{
		alias nlopt_func_old = double function(int n, const(double)* x, 
											   double* gradient, 
											   void* func_data); 

		nlopt_result nlopt_minimize(
			nlopt_algorithm algorithm, 
			int n, nlopt_func_old f, void* f_data, 
			const(double)* lb, const(double)* ub, 
			double* x, 
			double* minf, 
			double minf_max, double ftol_rel, double ftol_abs, 
			double xtol_rel, const(double)* xtol_abs, 
			int maxeval, double maxtime);

		nlopt_result nlopt_minimize_constrained(
			nlopt_algorithm algorithm, 
			int n,  nlopt_func_old f, void* f_data, 
			int m, nlopt_func_old fc, void* fc_data, ptrdiff_t fc_datum_size,
			const(double)* lb, const(double)* ub, 
			double* x, 
			double *minf, 
			double minf_max, double ftol_rel, double ftol_abs, 
			double xtol_rel, const(double)* xtol_abs, 
			int maxeval, double maxtime);

		nlopt_result  nlopt_minimize_econstrained(
			nlopt_algorithm algorithm, 
			int n, nlopt_func_old f, void* f_data, 
			int m, nlopt_func_old fc, void* fc_data, ptrdiff_t fc_datum_size, 
			int p, nlopt_func_old h, void* h_data, ptrdiff_t h_datum_size, 
			const(double)* lb, const(double)* ub, 
			double* x, 
			double* minf, 
			double minf_max, double ftol_rel, double ftol_abs, 
			double xtol_rel, const(double)* xtol_abs, 
			double htol_rel, double htol_abs, 
			int maxeval, double maxtime);
			
		void nlopt_get_local_search_algorithm(
			nlopt_algorithm* deriv,  nlopt_algorithm* nonderiv, int* maxeval);					   
		void nlopt_set_local_search_algorithm(
			nlopt_algorithm deriv, nlopt_algorithm nonderiv, int maxeval);
			
		int nlopt_get_stochastic_population();
		void nlopt_set_stochastic_population(int pop);
	}
}
