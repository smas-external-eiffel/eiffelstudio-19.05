note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-02-13 15:06:53 +0000 (Wed, 13 Feb 2019) $"
	revision: "$Revision: 102833 $"

class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP
		redefine
			create_interface_objects
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			default_create
		end

	create_interface_objects
			-- Create attributes
		do
			Precursor
			create string_constant_set_procedures.make (10)
			create string_constant_retrieval_functions.make (10)
			create integer_constant_set_procedures.make (10)
			create integer_constant_retrieval_functions.make (10)
			create pixmap_constant_set_procedures.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create integer_interval_constant_retrieval_functions.make (10)
			create integer_interval_constant_set_procedures.make (10)
			create font_constant_set_procedures.make (10)
			create font_constant_retrieval_functions.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create color_constant_set_procedures.make (10)
			create color_constant_retrieval_functions.make (10)
		end

	user_initialization
			-- <Precursor>
		local
			manager: SD_DOCKING_MANAGER
		do
			create manager.make (Current, Current)
			close_request_actions.extend (agent
											local
												l_env: EV_ENVIRONMENT
											do
												create l_env
												if attached l_env.application as l_app then
													l_app.destroy
												else
													check False end -- Implied by application is running
												end
											end)
			prepare_content_1 (manager)
			prepare_content_2 (manager)
			prepare_tool_bar_content (manager)
		end

feature {NONE} -- Implementation functions

	prepare_content_1 (manager: SD_DOCKING_MANAGER)
			-- Prepare the first tab.
		require
			not_void: manager /= Void
		local
			content_1: SD_CONTENT
		do
			create content_1.make_with_widget (create {EV_RICH_TEXT}, "CONTENT_ONE", manager)
			content_1.set_long_title ("Content 1 long title")
			content_1.set_short_title ("Content 1 title")
			manager.contents.extend (content_1)
			content_1.set_top ({SD_ENUMERATION}.top)
		end

	prepare_content_2 (manager: SD_DOCKING_MANAGER)
			-- Prepare the second tab.
		require
			not_void: manager /= Void
		local
			content_2: SD_CONTENT
		do
			create content_2.make_with_widget (create {EV_RICH_TEXT}, "CONTENT_TWO", manager)
			content_2.set_long_title ("Content 2 long title")
			content_2.set_short_title ("Content 2 title")
			manager.contents.extend (content_2)
			content_2.set_top ({SD_ENUMERATION}.top)
		end

	prepare_tool_bar_content (manager: SD_DOCKING_MANAGER)
			-- Prepare a tool bar.
		require
			not_void: manager /= Void
		local
			l_items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_BUTTON
			l_count, l_max_count: INTEGER
			l_tool_bar_content: SD_TOOL_BAR_CONTENT
			l_text: STRING_32
		do
			-- First we prepare tool bar items
			from
				l_max_count := 5
				create l_items.make (l_max_count)
			until
				l_count >= l_max_count
			loop
				create l_item.make
				l_text := "Button " + l_count.out
				l_item.set_text (l_text)
				l_item.set_name (l_text)
				l_item.set_description (l_text)

				l_item.set_pixmap ((create {EV_STOCK_PIXMAPS}).Default_window_icon)
				l_items.extend (l_item)
				if l_count = 2 then
					l_items.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
				end
				l_count := l_count + 1
			end

			-- Then we create tool bar content, extend it to tool bar manager
			create l_tool_bar_content.make_with_items ("Tool bar one", l_items)
			manager.tool_bar_manager.contents.extend (l_tool_bar_content)
			l_tool_bar_content.set_top ({SD_ENUMERATION}.top)
		end

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

