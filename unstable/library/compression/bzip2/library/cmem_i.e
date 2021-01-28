note

    description:

        "compiler dependend helper routines"

    library:    "ELJ/base"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date: 2014-01-15 15:31:59 +0000 (Wed, 15 Jan 2014) $"
    revision:   "$Revision: 94000 $"
    last:       "$Author: javierv $"
	status:     "Stable"
	complete:   "yes"

class CMEM_I

feature {NONE}

	mem_32: INTEGER

	integer_as_pointer (value_: INTEGER): POINTER
		external "C macro use <stdio.h>"
		alias "(void*)"
		end

	pointer_as_integer (value_: POINTER): INTEGER
		external "C macro use <stdio.h>"
		alias "(long)"
		end

	deref_pointer_to_integer (value_: POINTER): INTEGER
		external "C macro use <stdio.h>"
		alias "*(long*)"
		end

end
