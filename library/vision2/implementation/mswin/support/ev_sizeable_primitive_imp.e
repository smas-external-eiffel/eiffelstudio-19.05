note
	description:
		"Eiffel Vision sizeable primitive. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	EV_SIZEABLE_PRIMITIVE_IMP

inherit
	EV_SIZEABLE_IMP

feature -- Access

	ev_set_minimum_width (value: INTEGER; a_is_size_forced: BOOLEAN)
			-- Make `value' the new `minimum_width' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_width /= value then
				internal_set_minimum_width (value)
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minwidth, Current, a_is_size_forced)
				end
			end
		end

	ev_set_minimum_height (value: INTEGER; a_is_size_forced: BOOLEAN)
			-- Make `value' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_height /= value then
				internal_set_minimum_height (value)
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minheight, Current, a_is_size_forced)
				end
			end
		end

	ev_set_minimum_size (mw, mh: INTEGER; a_is_size_forced: BOOLEAN)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			w_cd, h_cd: BOOLEAN
			p_imp: like parent_imp
		do
			w_cd := minimum_width /= mw
			h_cd := minimum_height /= mh
			internal_set_minimum_size (mw, mh)
			p_imp := parent_imp
			if p_imp /= Void then
				if w_cd and h_cd then
					p_imp.notify_change (Nc_minsize, Current, a_is_size_forced)
				elseif w_cd then
					p_imp.notify_change (Nc_minwidth, Current, a_is_size_forced)
				elseif h_cd then
					p_imp.notify_change (Nc_minheight, Current, a_is_size_forced)
				end
			end
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




end -- EV_SIZEABLE_PRIMITIVE_IMP

