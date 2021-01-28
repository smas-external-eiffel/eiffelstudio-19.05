note
	description: "Objects that represent action sequences for EV_GRID_ROW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2016-09-28 17:43:51 +0000 (Wed, 28 Sep 2016) $"
	revision: "$Revision: 99197 $"

deferred class
	EV_GRID_ROW_ACTION_SEQUENCES

inherit
	EV_ACTION_SEQUENCES

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is selected.
		do
			Result := implementation.select_actions
		ensure
			result_not_void: Result /= Void
		end

	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is deselected.
		do
			Result := implementation.deselect_actions
		ensure
			result_not_void: Result /= Void
		end

	expand_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is expanded.
		do
			Result := implementation.expand_actions
		ensure
			result_not_void: Result /= Void
		end

	collapse_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is collapsed.
		do
			Result := implementation.collapse_actions
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	implementation: EV_GRID_ROW_ACTION_SEQUENCES_I
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
