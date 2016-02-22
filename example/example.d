// Written in the D programming language.

/**
 * Sample program implementing nlopt in D
 * 
 *
 *
 *
 * Copyright: Copyright © 2016, John Michael Hall
 * License:   LGPL-2.1 or later
 * Authors:   John Michael Hall
 * Date:      2/21/2016
 * See_Also:  $(LINK http://ab-initio.mit.edu/wiki/index.php/NLopt)
 */

import libnlopt;
import std.math : sqrt;


extern(C) @nogc nothrow double myfunc(uint n, const(double)* x, 
									  double* grad, void* my_func_data)
{
    if (grad)
	{
        grad[0] = 0.0;
        grad[1] = 0.5 / sqrt(x[1]);
    }
    return sqrt(x[1]);
}

struct my_constraint_data
{
	double a;
	double b;
}

extern(C) @nogc nothrow double myconstraint(uint n, const(double)* x, 
											     double* grad, void* data)
{
    my_constraint_data* d = cast(my_constraint_data*) data;
    double a = d.a;
	double b = d.b;
    if (grad) {
        grad[0] = 3 * a * (a * x[0] + b) * (a * x[0] + b);
        grad[1] = -1.0;
    }
    return ((a * x[0] + b) * (a * x[0] + b) * (a * x[0] + b) - x[1]);
}


void main()
{
	import std.stdio : writeln, writefln;
	import core.stdc.math : HUGE_VAL;

	double[2] lb = [-HUGE_VAL, 0]; /* lower bounds */
	nlopt_opt opt;
	opt = nlopt_create(NLOPT_LD_MMA, 2); /* algorithm and dimensionality */
	
	nlopt_set_lower_bounds(opt, lb.ptr);
	
	nlopt_set_min_objective(opt, &myfunc, null);
	
	my_constraint_data c_data1 = {2.0, 0.0};
	my_constraint_data c_data2 = {-1.0, 1.0};
	
	nlopt_add_inequality_constraint(opt, &myconstraint, &c_data1, 1e-8);
	nlopt_add_inequality_constraint(opt, &myconstraint, &c_data2, 1e-8);
	nlopt_set_xtol_rel(opt, 1e-4);
	
	double[2] x = [1.234, 5.678];
	double minf;
	
	
	if (nlopt_optimize(opt, x.ptr, &minf) < 0) {
		writeln("nlopt failed!\n");
	}
	else {
		writefln("found minimum at f(%g,%g) = %0.10g\n", x[0], x[1], minf);
	}
	nlopt_destroy(opt);
	
	writeln("main ends");
}



