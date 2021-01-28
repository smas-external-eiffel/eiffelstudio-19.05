note
	description: "Objects that test EV_VERTICAL_RANGE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-31 17:18:34 +0000 (Wed, 31 Dec 2008) $"
	revision: "$Revision: 76491 $"

class
	VERTICAL_RANGE_SIMPLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		do
			create range
			range.set_minimum_height (250)
			range.set_value (50)
			
			widget := range
		end
		
feature {NONE} -- Implementation

	range: EV_VERTICAL_RANGE;
		-- Widget that test is to be performed on.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class VERTICAL_RANGE_SIMPLE_TEST
