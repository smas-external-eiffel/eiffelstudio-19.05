note
	description: "Root class for this application."
	author: "Generated by the New Cocoa Application Wizard."
	date: "${FL_DATE}"
	revision: "1.0.0"

class
	APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch 

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
			make
			prepare
			launch
		end

	prepare
			-- Prepare the first window to be displayed.
		do
				-- create and initialize the main window.
			create main_window.make (create {NS_RECT}.make_rect (100, 100, 300, 300), {NS_WINDOW}.titled_window_mask | {NS_WINDOW}.closable_window_mask, False)

				-- set the title of the window.
			main_window.set_title (create {NS_STRING}.make_with_string ("My cocoa application"))

				-- Show the main window.
			main_window.make_key_and_order_front
		end

feature {NONE} -- Implementation

	main_window: NS_WINDOW
			-- Main window.
	
end