note
	description: "Contains information about a rebar control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_REBARINFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make
			-- Make a REBARINFO structure.
			-- We have to set `cbSize' to the structure
			-- size before to use this object.
			-- As the imagelist are not implemented, we initialize
			-- the list to the default_pointer, otherwise,
			-- the bar has the wrong size.
		do
			structure_make
			set_cbsize (structure_size)
		end

feature -- Access

	mask: INTEGER
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Rbim_* values (only one for now).
			-- See class WEL_RBIM_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_rebarinfo_get_fmask (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_rebarinfo
		end

feature {WEL_REBAR} -- Implementation

	set_cbsize (value: INTEGER)
			-- Set `cbSize' (size of the structure) as `value'.
		do
			cwel_rebarinfo_set_cbsize (item, value)
		end

	set_mask (value: INTEGER)
			-- Set `mask' with `value.
		do
			cwel_rebarinfo_set_fmask (item, value)
		ensure
			mask_set: mask = value
		end

feature {NONE} -- Externals

	c_size_of_rebarinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (REBARINFO)"
		end

	cwel_rebarinfo_set_fmask (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_set_cbsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_set_himl (ptr, value: POINTER)
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_get_fmask (ptr: POINTER): INTEGER
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_get_cbsize (ptr: POINTER): INTEGER
		external
			"C [macro %"rebarinfo.h%"]"
		end

	cwel_rebarinfo_get_himl (ptr: POINTER): POINTER
		external
			"C [macro %"rebarinfo.h%"]"
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
