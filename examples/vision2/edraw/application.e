note
	description	: "Root class for this application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date: 2009-11-17 20:01:22 +0000 (Tue, 17 Nov 2009) $"
	revision	: "1.0.0"

class
	APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
				-- create and initialize the first window.
			create ev_application
			create_interface_objects
			prepare
			ev_application.launch
		end

	create_interface_objects
		do
			create first_window
		end

	prepare
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
				-- Show the first window.
			first_window.show
		end

feature {NONE} -- Implementation

	ev_application: EV_APPLICATION
			-- Vision2 application

	first_window: DRAWER_MAIN_WINDOW;

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


end -- class APPLICATION
