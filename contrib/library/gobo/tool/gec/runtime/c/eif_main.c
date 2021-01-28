/*
	description:

		"C functions used to implement the main function"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-07 22:54:15 +0000 (Thu, 07 Feb 2019) $"
	revision: "$Revision: 102807 $"
*/

#ifndef EIF_MAIN_C
#define EIF_MAIN_C
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifndef EIF_MAIN_H
#include "eif_main.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Used by the ISE runtime to figure out whether the application
 * was launched from EiffelStudio in workbench mode or not.
 */
int debug_mode = 0; /* Assume not in debug mode */

#ifdef __cplusplus
}
#endif

#endif