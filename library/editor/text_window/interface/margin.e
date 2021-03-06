note
	description: "Margin control for use with TEXT_PANEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2012-02-01 18:55:04 +0000 (Wed, 01 Feb 2012) $"
	revision: "$Revision: 88253 $"

class
	MARGIN

inherit
	TEXT_OBSERVER
		export
			{NONE} all
		redefine
			on_text_loaded,
			on_text_block_loaded
		end

	SHARED_EDITOR_DATA

create
	make

feature -- Initialization

	make (a_text_panel: TEXT_PANEL)
			-- Create a new margin
		require
			text_panel_not_void: a_text_panel /= Void
			editor_preferences_set: editor_preferences /= Void
		do
			text_panel := a_text_panel
			build_margin_area
			a_text_panel.text_displayed.add_lines_observer (Current)
			a_text_panel.text_displayed.add_edition_observer (Current)
		end

	build_margin_area
			-- Initialize variables and objects related to display.	
		require
			editor_preferences_set: editor_preferences /= Void
		local
			l_pref: like editor_preferences
		do
			create margin_area
			margin_area.set_minimum_size (1, 1)

			margin_area.expose_actions.extend (agent on_repaint)
			margin_area.resize_actions.extend (agent on_size)

				-- Add widgets to our margin area
			create widget
			widget.extend (margin_area)
			widget.enable_item_expand (margin_area)

				-- Set up the screen.
			create buffered_screen.make_with_size (margin_area.width, text_panel.editor_drawing_area.height)

			l_pref := editor_preferences
			check l_pref /= Void end -- Implied by precondition
			buffered_screen.set_background_color (l_pref.margin_background_color)
			hide_breakpoints
--			hide_line_numbers
		end

feature -- Access

	width: INTEGER
			-- Width in pixels calculated based on which tokens should be displayed
		local
--			l_bptok: EDITOR_TOKEN_BREAKPOINT
		do
		    Result := 1
			if line_numbers_visible then
				Result := Result + internal_line_number_area_width
			end
--			if not hidden_breakpoints then					
--				create l_bptok.make
--				Result := Result + l_bptok.width
--			end
		end

	hidden_breakpoints: BOOLEAN
			-- Are breakpoints hidden? (Default: True)

	line_numbers_visible: BOOLEAN
			-- Are line numbers hidden?
		do
		    Result := text_panel.line_numbers_visible
		end

feature -- Status setting

	hide_breakpoints
			-- Do not show breakpoints even if there are some.
		do
			hidden_breakpoints := True
		end

	show_breakpoints
			-- Show breakpoints if there are some.
		do
			hidden_breakpoints := False
		end

	set_margin_width (a_width: INTEGER)
			-- If `a_width' is greater than `width', assign `a_width' to `width'
			-- update display if necessary.
		do
			widget.set_minimum_width (a_width)
			if width /= buffered_screen.width then
				buffered_screen.set_size (a_width, margin_area.height)
				update_buffered_screen (0, margin_area.height)
				update_display
			end
		end

	set_first_line_displayed (fld: INTEGER)
			-- Assign `fld' to `first_line_displayed'.
		require
			fld_large_enough: fld > 0
		local
			diff, y_offset: INTEGER
			zone: EV_RECTANGLE
		do
			diff := fld - first_line_displayed
			if diff /= 0 then
				first_line_displayed := fld
				if diff.abs < text_panel.number_of_lines_displayed then
					if diff < 0 then
						y_offset := buffered_screen.height + diff * text_panel.line_height
						create zone.make (0, 0, buffered_screen.width, y_offset)
						buffered_screen.draw_sub_pixmap (0, - diff * text_panel.line_height, buffered_screen, zone)
						update_buffered_screen (0, - diff * text_panel.line_height)
					elseif diff > 0 then
						y_offset := diff * text_panel.line_height
						create zone.make (0, y_offset, buffered_screen.width, buffered_screen.height)
						buffered_screen.draw_sub_pixmap (0, 0, buffered_screen, zone)
						update_buffered_screen (buffered_screen.height - y_offset, buffered_screen.height)
					end
					update_display
				else
					margin_area.redraw
				end
			end
		end

feature -- Graphical Interface

	text_panel: TEXT_PANEL
			-- The text panel/editor to which Current is anchored

	widget: EV_VERTICAL_BOX
			-- Widget holding drawing area

	margin_area: EV_DRAWING_AREA
			-- Part of the screen where the information is displayed.

	buffered_screen: EDITOR_BUFFERED_SCREEN
			-- Buffer containing the current displayed margin.		

feature {NONE} -- Text Loading

	on_text_loaded
			-- Finish the margin setup as the entire text has been loaded in the editor.
		do
			--set_first_line_displayed
			refresh_now
		end

	on_text_block_loaded (was_first_block: BOOLEAN)
			-- Update scroll bar as a new block of text as been loaded.
		do
			refresh_now
		end

feature -- Basic operations

	destroy
			-- Destroy
		do
			widget.wipe_out
			create widget -- Dereference original one to help finding memory leak.
			margin_area.destroy
			create margin_area -- Dereference original one to help finding memory leak.
		end

	refresh
			-- Refresh
		do
			set_margin_width (width)
			margin_area.redraw
		end

	refresh_now
			-- Update display without waiting for next idle
		do
			refresh
			margin_area.flush
		end

	setup_margin
			-- Update `Current' as the first page of the new content has been loaded.
		do
			refresh_now
		end

feature {NONE} -- Implementation

	in_resize: BOOLEAN
			-- Are we in a call to on_resize that was not triggered by the function itself?

	first_line_displayed: INTEGER
			-- First line currently displayed

	default_width: INTEGER = 5
			-- Default character width of margin for when number of lines is less than 100,000

	default_line_number_area_width_cell: CELL [INTEGER]
			-- Value of line number area width for files with less than 100,000 lines).
		local
			l_no_lines: INTEGER
			l_max_token: EDITOR_TOKEN_LINE_NUMBER
			l_spacer: STRING
		once
			create l_max_token.make
			l_no_lines := text_panel.text_displayed.number_of_lines
			create l_spacer.make_filled ('0', default_width)
			l_max_token.set_internal_image (l_spacer)
			l_max_token.update_width
			create Result.put (l_max_token.width)
		end

	internal_line_number_area_width: INTEGER
			-- Width of line number display area of Current
		local
			l_max_token: EDITOR_TOKEN_LINE_NUMBER
		do
			if text_panel.text_displayed.number_of_lines < 100_000 then
				Result := default_line_number_area_width_cell.item
			else
				create l_max_token.make
				l_max_token.set_internal_image (text_panel.text_displayed.number_of_lines.out)
				l_max_token.update_width
				Result := Result + l_max_token.width
			end
		end

feature {TEXT_PANEL} -- Display functions

	on_repaint (x, y, a_width, a_height: INTEGER)
			-- Repaint the part of the panel between in the rectangle between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (margin_area.width, y + height) is redrawn.
		do
			if a_width /= 0 and a_height /= 0 then
				update_buffered_screen (y, y + a_height)
				update_display
			end
		end

	update_buffered_screen (top: INTEGER; bottom: INTEGER)
 			-- Update buffered pixmap between lines number `top' and `bottom'.
 		require
 			initialized: initialized
 		local
 			curr_line			: INTEGER
 			first_line_to_draw	: INTEGER
 			last_line_to_draw	: INTEGER
 			curr_y				: INTEGER
 			l_pref				: like editor_preferences
 			l_text				: TEXT
 			l_line				: detachable EDITOR_LINE
 		do
 			l_pref := editor_preferences
 			check l_pref /= Void end -- Implied by precondition
			buffered_screen.set_background_color (l_pref.margin_background_color)
			buffered_screen.clear_rectangle (0, top, buffered_screen.width, bottom - top)
			set_margin_width (width)

			l_text := text_panel.text_displayed

 				-- Draw all lines
 			first_line_to_draw := (text_panel.first_line_displayed + top // text_panel.line_height ).max (1)
 			last_line_to_draw := (text_panel.first_line_displayed + (bottom - 1) // text_panel.line_height).min (l_text.number_of_lines)
 			curr_y := top

 			if first_line_to_draw <= last_line_to_draw then
 				l_text.go_i_th (first_line_to_draw)
 				from
 					curr_line := first_line_to_draw
 				until
 					curr_line > last_line_to_draw or else l_text.after
 				loop
 					l_line := l_text.current_line
 					check l_line /= Void end -- Implied by not `after'
 					display_line (curr_line, l_line)
 					curr_line := curr_line + 1
 					l_text.forth
 				end

 				curr_y := (curr_line - text_panel.first_line_displayed) * text_panel.line_height
 			end
 			if curr_y < bottom then
 				-- The file is too small for the screen, so we fill in the
 				-- last portion of the screen.
				buffered_screen.set_background_color (l_pref.margin_background_color)
				buffered_screen.clear_rectangle (0, curr_y, width, bottom - curr_y)
 			end
 		end

	update_display
			-- Update display by drawing the buffered pixmap on `margin_area'.
		do
			margin_area.draw_sub_pixmap (0,	0, buffered_screen, create {EV_RECTANGLE}.make (0, 0, width, buffered_screen.height))
		end

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER)
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height').
			--| Note: This feature is called during the creation of the window
		local
			old_height: INTEGER
			w,h: INTEGER
		do
				-- Resize & redraw the buffered screen.
			if buffered_screen /= Void then -- System initialized.
				in_resize := True

				if buffered_screen.width < a_width then
--					if in_resize then
						w := width.max (a_width)
						h := a_height.max (1)
--					else
--						w := margin_width.max (a_width).max (buffered_screen.width)
--						h := a_height.max (1).max (buffered_screen.height)
--					end
					buffered_screen.set_size (w, h)
					update_buffered_screen (0, h)
				else
					old_height := buffered_screen.height
--					if in_resize then
						w := width.max (margin_area.width)
						h := a_height.max (1)
--					else
--						w := editor_width.max (editor_area.width - left_margin_width).max (buffered_screen.width)
--						h := a_height.max (1).max (buffered_screen.height)
--					end
					buffered_screen.set_size (w, h)
					if old_height < a_height then
						update_buffered_screen (old_height - 1, h)
					end
				end
				in_resize := False
			end
		end

	display_line (xline: INTEGER; a_line: EDITOR_LINE)
 			-- Display `a_line' on the buffered screen.
 		require
 			xline_valid: xline > 0 and then xline <= text_panel.number_of_lines
 			a_line_valid: a_line.is_valid
 			xline_is_a_line: text_panel.text_displayed.line (xline) = a_line
 		local
-- 			bp_token			: EDITOR_TOKEN_BREAKPOINT
 			curr_token			: EDITOR_TOKEN
 			curr_y, max_chars	: INTEGER
 			spacer_text			: STRING
 		do
 			if text_panel.text_displayed.number_of_lines > 99999 then
	 			max_chars := text_panel.number_of_lines.out.count
 			else
	 			max_chars := default_width
 			end

 			create spacer_text.make_filled ('0', max_chars - xline.out.count)

 				-- Set the correct image for line number
 			-- line_token ?= text_panel.text_displayed.line (xline).number_token
			if attached {EDITOR_TOKEN_LINE_NUMBER}a_line.number_token as l_num_token then
				l_num_token.set_internal_image (spacer_text + xline.out)
			end

   			curr_y := (xline - text_panel.first_line_displayed) * text_panel.line_height
  			from
					-- Display the first applicable token in the margin
				a_line.start
				curr_token := a_line.item
 			until
 				a_line.after or else not curr_token.is_margin_token
 			loop
				if curr_token.is_margin_token then
--					bp_token ?= curr_token
--					if bp_token /= Void and then not hidden_breakpoints then						
--						bp_token.display (curr_y, buffered_screen, text_panel) 	
--					elseif bp_token /= Void then						
--						bp_token.hide
--					else
						if attached {EDITOR_TOKEN_LINE_NUMBER} curr_token as line_token then
							if line_numbers_visible then
								line_token.display (curr_y, buffered_screen, text_panel)
							else
								line_token.hide
							end
						end
--					end
				end
				a_line.forth
				curr_token := a_line.item
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




end -- class MARGIN
