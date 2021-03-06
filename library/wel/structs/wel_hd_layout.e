note
	description: "This class represents a structure that contains%
					 %information used to set the size and position of%
					 %a WEL_HEADER_CONTROL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_HD_LAYOUT

inherit
	WEL_STRUCTURE
		redefine
			make
		end
	WEL_BIT_OPERATIONS
		undefine
			copy, is_equal
		end

	WEL_HDI_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
		local
			a_window_pos: WEL_WINDOW_POS
		do
			Precursor {WEL_STRUCTURE}
			create a_window_pos.make
			set_window_pos (a_window_pos)
		end

feature -- Access


	rectangle: WEL_RECT
			-- Contains the coordinates of a rectangle that the header control is to occupy
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_hd_layout_get_prc (item))
		end

	window_pos: WEL_WINDOW_POS
			-- Object that receives information about the appropriate size
			-- and position of the header control.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_hd_layout_get_pwpos (item))
		end


feature -- Element change

	set_rectangle (a_rect: WEL_RECT)
			-- Contains the coordinates of a rectangle that the header control is to occupy
		require
			exists: exists
			rect_not_void: a_rect /= Void
			rect_exists: a_rect.exists
		do
			cwel_hd_layout_set_prc (item, a_rect.item)
		end

	set_window_pos (value: WEL_WINDOW_POS)
			-- Filled usually by Windows
		require
			exists: exists
			value_not_void: value /= Void
			window_pos_exists: value.exists
		do
			cwel_hd_layout_set_pwpos (item, value.item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_hd_layout
		end

feature {NONE} -- Externals

	c_size_of_hd_layout: INTEGER
		external
			"C [macro %"nmtb.h%"]"
		alias
			"sizeof (HD_LAYOUT)"
		end

	cwel_hd_layout_get_prc (ptr: POINTER): POINTER
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*): EIF_POINTER"
		end

	cwel_hd_layout_set_prc (ptr: POINTER; value: POINTER)
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*, RECT FAR*)"
		end

	cwel_hd_layout_get_pwpos (ptr: POINTER): POINTER
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*): EIF_POINTER"
		end

	cwel_hd_layout_set_pwpos (ptr: POINTER; value: POINTER)
		external
			"C [macro %"hd_layout.h%"] (HD_LAYOUT*, WINDOWPOS FAR*)"
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

end
