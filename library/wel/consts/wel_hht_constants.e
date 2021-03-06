note
	description: "Possible flags of the results of a hit test on a%
					 %header control"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_HHT_CONSTANTS

feature -- Access

	Hht_nowhere: INTEGER
			-- The point is inside the bounding rectangle of the header control but 
			-- is not over a header item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HHT_NOWHERE"
		end 

	Hht_on_divider: INTEGER
			-- The point is on the divider between two header items. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HHT_ONDIVIDER"
		end 
 
	Hht_on_div_open: INTEGER
			-- The point is on the divider of an item that has a width of zero. 
			-- Dragging the divider reveals the item instead of resizing the item 
			-- to the left of the divider. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HHT_ONDIVOPEN"
		end 

	Hht_on_header: INTEGER
			-- The point is inside the bounding rectangle of the header control. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HHT_ONHEADER"
		end 

	Hht_to_left: INTEGER
			-- The point is to the left of the bounding rectangle of the header control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HHT_TOLEFT"
		end 

	Hht_to_right: INTEGER
			-- The point is to the right of the bounding rectangle of the header control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HHT_TORIGHT"
		end 
 
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




end -- class WEL_HHT_CONSTANTS

