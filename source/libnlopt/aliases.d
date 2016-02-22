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
 
 /**
 * Aliases for various nlopt enums
 * 
 * Authors:   John Michael Hall
 * Date:      2/21/2016
 * See_Also:  $(LINK http://ab-initio.mit.edu/wiki/index.php/NLopt)
 */

module libnlopt.aliases;

import libnlopt.api;

alias NLOPT_GN_DIRECT =             nlopt_algorithm.NLOPT_GN_DIRECT;
alias NLOPT_GN_DIRECT_L =           nlopt_algorithm.NLOPT_GN_DIRECT_L;
alias NLOPT_GN_DIRECT_L_RAND =      nlopt_algorithm.NLOPT_GN_DIRECT_L_RAND;
alias NLOPT_GN_DIRECT_NOSCAL =      nlopt_algorithm.NLOPT_GN_DIRECT_NOSCAL;
alias NLOPT_GN_DIRECT_L_NOSCAL =    nlopt_algorithm.NLOPT_GN_DIRECT_L_NOSCAL;
alias NLOPT_GN_DIRECT_L_RAND_NOSCAL = 
    nlopt_algorithm.NLOPT_GN_DIRECT_L_RAND_NOSCAL;
alias NLOPT_GN_ORIG_DIRECT =        nlopt_algorithm.NLOPT_GN_ORIG_DIRECT;
alias NLOPT_GN_ORIG_DIRECT_L =      nlopt_algorithm.NLOPT_GN_ORIG_DIRECT_L;
alias NLOPT_GD_STOGO =              nlopt_algorithm.NLOPT_GD_STOGO;
alias NLOPT_GD_STOGO_RAND =         nlopt_algorithm.NLOPT_GD_STOGO_RAND;
alias NLOPT_LD_LBFGS_NOCEDAL =      nlopt_algorithm.NLOPT_LD_LBFGS_NOCEDAL;
alias NLOPT_LD_LBFGS =              nlopt_algorithm.NLOPT_LD_LBFGS;
alias NLOPT_LN_PRAXIS =             nlopt_algorithm.NLOPT_LN_PRAXIS;
alias NLOPT_LD_VAR1 =               nlopt_algorithm.NLOPT_LD_VAR1;
alias NLOPT_LD_VAR2 =               nlopt_algorithm.NLOPT_LD_VAR2;
alias NLOPT_LD_TNEWTON =            nlopt_algorithm.NLOPT_LD_TNEWTON;
alias NLOPT_LD_TNEWTON_RESTART =    nlopt_algorithm.NLOPT_LD_TNEWTON_RESTART;
alias NLOPT_LD_TNEWTON_PRECOND =    nlopt_algorithm.NLOPT_LD_TNEWTON_PRECOND;
alias NLOPT_LD_TNEWTON_PRECOND_RESTART = 
    nlopt_algorithm.NLOPT_LD_TNEWTON_PRECOND_RESTART;
alias NLOPT_GN_CRS2_LM =            nlopt_algorithm.NLOPT_GN_CRS2_LM;
alias NLOPT_GN_MLSL =               nlopt_algorithm.NLOPT_GN_MLSL;
alias NLOPT_GD_MLSL =               nlopt_algorithm.NLOPT_GD_MLSL;
alias NLOPT_GN_MLSL_LDS =           nlopt_algorithm.NLOPT_GN_MLSL_LDS;
alias NLOPT_GD_MLSL_LDS =           nlopt_algorithm.NLOPT_GD_MLSL_LDS;
alias NLOPT_LD_MMA =                nlopt_algorithm.NLOPT_LD_MMA;
alias NLOPT_LN_COBYLA =             nlopt_algorithm.NLOPT_LN_COBYLA;
alias NLOPT_LN_NEWUOA =             nlopt_algorithm.NLOPT_LN_NEWUOA;
alias NLOPT_LN_NEWUOA_BOUND =       nlopt_algorithm.NLOPT_LN_NEWUOA_BOUND;
alias NLOPT_LN_NELDERMEAD =         nlopt_algorithm.NLOPT_LN_NELDERMEAD;
alias NLOPT_LN_SBPLX =              nlopt_algorithm.NLOPT_LN_SBPLX;
alias NLOPT_LN_AUGLAG =             nlopt_algorithm.NLOPT_LN_AUGLAG;
alias NLOPT_LD_AUGLAG =             nlopt_algorithm.NLOPT_LD_AUGLAG;
alias NLOPT_LN_AUGLAG_EQ =          nlopt_algorithm.NLOPT_LN_AUGLAG_EQ;
alias NLOPT_LD_AUGLAG_EQ =          nlopt_algorithm.NLOPT_LD_AUGLAG_EQ;
alias NLOPT_LN_BOBYQA =             nlopt_algorithm.NLOPT_LN_BOBYQA;
alias NLOPT_GN_ISRES =              nlopt_algorithm.NLOPT_GN_ISRES;
alias NLOPT_AUGLAG =                nlopt_algorithm.NLOPT_AUGLAG;
alias NLOPT_AUGLAG_EQ =             nlopt_algorithm.NLOPT_AUGLAG_EQ;
alias NLOPT_G_MLSL =                nlopt_algorithm.NLOPT_G_MLSL;
alias NLOPT_G_MLSL_LDS =            nlopt_algorithm.NLOPT_G_MLSL_LDS;
alias NLOPT_LD_SLSQP =              nlopt_algorithm.NLOPT_LD_SLSQP;
alias NLOPT_LD_CCSAQ =              nlopt_algorithm.NLOPT_LD_CCSAQ;
alias NLOPT_GN_ESCH =               nlopt_algorithm.NLOPT_GN_ESCH;
alias NLOPT_NUM_ALGORITHMS =        nlopt_algorithm.NLOPT_NUM_ALGORITHMS;


alias NLOPT_FAILURE =           nlopt_result.NLOPT_FAILURE;
alias NLOPT_INVALID_ARGS =      nlopt_result.NLOPT_INVALID_ARGS;
alias NLOPT_OUT_OF_MEMORY =     nlopt_result.NLOPT_OUT_OF_MEMORY;
alias NLOPT_ROUNDOFF_LIMITED =  nlopt_result.NLOPT_ROUNDOFF_LIMITED;
alias NLOPT_FORCED_STOP =       nlopt_result.NLOPT_FORCED_STOP;
alias NLOPT_SUCCESS =           nlopt_result.NLOPT_SUCCESS;
alias NLOPT_STOPVAL_REACHED =   nlopt_result.NLOPT_STOPVAL_REACHED;
alias NLOPT_FTOL_REACHED =      nlopt_result.NLOPT_FTOL_REACHED;
alias NLOPT_XTOL_REACHED =      nlopt_result.NLOPT_XTOL_REACHED;
alias NLOPT_MAXEVAL_REACHED =   nlopt_result.NLOPT_MAXEVAL_REACHED;
alias NLOPT_MAXTIME_REACHED =   nlopt_result.NLOPT_MAXTIME_REACHED;
