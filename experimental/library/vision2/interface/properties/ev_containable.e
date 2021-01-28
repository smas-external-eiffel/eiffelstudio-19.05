note
	description:
		"Abstraction for objects that may be parented."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "parentable, containable, child"
	date: "$Date: 2013-06-03 23:53:45 +0000 (Mon, 03 Jun 2013) $"
	revision: "$Revision: 92667 $"

deferred class
	EV_CONTAINABLE

inherit
	EV_ANY

	EV_IDENTIFIABLE

feature -- Status report

	parent: detachable EV_CONTAINABLE
			-- The parent that `Current' is contained within, if any.
		deferred
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




end -- class EV_CONTAINABLE











