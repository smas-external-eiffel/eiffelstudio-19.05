note
	description: "[
			Main window of EiffelVision2 rich text example.
			Originally generated by EiffelBuild.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-05-03 20:02:50 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100319 $"

class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP

feature {NONE} -- Initialization

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			environment: EV_ENVIRONMENT
			font_families: LINEAR [STRING_32]
			list_item: EV_LIST_ITEM
			counter: INTEGER
			font: EV_FONT
			l_file_name: PATH
			format: EV_CHARACTER_FORMAT
		do
				-- Initialize color display to black.
			last_displayed_color := (create {EV_STOCK_COLORS}).red
			last_displayed_background_color := (create {EV_STOCK_COLORS}).red

				-- Update toolbar button display.
			format_toolbar.disable_vertical_button_style
			paragraph_toolbar.disable_vertical_button_style

				-- Connect events.
			rich_text.caret_move_actions.extend (agent caret_moved)
			rich_text.selection_change_actions.extend (agent selection_changed)
			rich_text.file_access_actions.extend (agent update_progress_on_file_access)
			close_request_actions.extend (agent exit)

					-- Now load all available fonts into `font_selection' combo box.
			create environment
			font_families := environment.font_families
			from
				font_families.start
			until
				font_families.off
			loop
				create list_item.make_with_text (font_families.item)
				font_selection.extend (list_item)
				font_families.forth
			end

				-- Apply a default font to `rich_edit'.
			create font
			font_families.start
			font.preferred_families.extend (font_families.item)
			font.set_height (10)
			rich_text.set_font (font)

				-- Add permitted font heights to `size_selection' combo box.
			from
				counter := 1
			until
				counter > point_font_heights.count
			loop
				create list_item.make_with_text (point_font_heights.item (counter).out)
				list_item.set_data (counter)
				size_selection.extend (list_item)
				counter := counter + 1
			end

				-- Load contents of `rich_text' from rich text file "welcome.rtf"
			create l_file_name.make_from_string (rich_text_example_root)
			l_file_name := l_file_name.extended ("welcome.rtf")
			rich_text.set_with_named_path (l_file_name)

				-- Now we must add an example of every available font to `rich_text'.
			format := rich_text.character_format (1)
				-- Add an empty line.
			rich_text.buffered_append ("%N%N", format)
			from
				font_selection.start
			until
				font_selection.off
			loop
				format := rich_text.character_format (1)
				font := format.font
				font.preferred_families.wipe_out
				font.preferred_families.extend (font_selection.item.text)
				font.set_height (16)
				format.set_font (font)
				rich_text.buffered_append (font_selection.item.text, format)
				font_selection.forth
				if not font_selection.off then
					rich_text.buffered_append ("%N", format)
				end
			end
			rich_text.flush_buffer_to (rich_text.text_length + 1, rich_text.text_length + 1)

			show_actions.extend (agent window_shown)
		end

	window_shown
			-- `Current' has been shown. Perform necessary processing.
		do
			rich_text.set_focus
		end

feature {NONE} -- Event handling

	bold_selected
			-- `bold_button' has been selected.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				font := format.font
				if bold_button.is_selected then
					font.set_weight ((create {EV_FONT_CONSTANTS}).weight_bold)
				else
					font.set_weight ((create {EV_FONT_CONSTANTS}).weight_regular)
				end
				format.set_font (font)
				create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_weight)
				rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				font := format.font
				if font.weight.is_equal ({EV_FONT_CONSTANTS}.weight_bold) then
					font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
				else
					font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				end
				format.set_font (font)
				rich_text.set_current_format (format)
			end
		end

	font_selected
			-- A font has been selected from `font_selection' combo box.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				font := format.font
				font.preferred_families.wipe_out
				font.preferred_families.extend (font_selection.selected_item.text)
				format.set_font (font)
				create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_family)
				rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				font := format.font
				font.preferred_families.wipe_out
				font.preferred_families.extend (font_selection.selected_item.text)
				format.set_font (font)
				if rich_text.is_displayed then
					rich_text.set_focus
					rich_text.set_current_format (format)
				end
			end
		end

	font_size_selected
			-- A font has been selected from `size_selection' combo box.
		local
			format: EV_CHARACTER_FORMAT
			size: INTEGER
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				if size_selection.text.is_integer then
					size := size_selection.text.to_integer

					if size >= 1 and size <= 200 then
						font := format.font

						font.set_height_in_points (size)
						format.set_font (font)
						create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_height)
						rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
					end
				end
			else
				format := rich_text.character_format (rich_text.caret_position)
				if size_selection.text.is_integer then
					size := size_selection.text.to_integer
					if size >= 1 and size <= 200 then
						font :=format.font
						font.set_height_in_points (size)
						format.set_font (font)
						if rich_text.is_displayed then
							rich_text.set_focus
							rich_text.set_current_format (format)
						end
					end
				end
			end
		end

	italic_selected
			-- `italic_button' has been selected.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				font := format.font
				if italic_button.is_selected then
					font.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
				else
					font.set_shape ({EV_FONT_CONSTANTS}.shape_regular)
				end
				format.set_font (font)
				create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_shape)
				rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				font := format.font
				if font.shape.is_equal ({EV_FONT_CONSTANTS}.shape_italic) then
					font.set_shape ({EV_FONT_CONSTANTS}.shape_regular)
				else
					font.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
				end
				format.set_font (font)
				rich_text.set_current_format (format)
			end
		end

	color_selected
			-- `color_button' has been selected.
		local
			color_dialog: EV_COLOR_DIALOG
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			create color_dialog
			color_dialog.show_modal_to_window (Current)
			if color_dialog.color /= Void then
				update_color (color_dialog.color)
			end
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				if color_dialog.selected_button_name.same_string ((create {EV_DIALOG_NAMES}).ev_ok) then
					format.set_color (color_dialog.color)
					create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.color)
					rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
				end
			else
				format := rich_text.character_format (rich_text.caret_position)
				if color_dialog.selected_button_name.same_string ((create {EV_DIALOG_NAMES}).ev_ok) then
					format.set_color (color_dialog.color)
					rich_text.set_current_format (format)
				end
			end
		end

	background_color_selected
			-- Called by `select_actions' of `background_color_button'.
		local
			color_dialog: EV_COLOR_DIALOG
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			create color_dialog
			color_dialog.show_modal_to_window (Current)
			if color_dialog.color /= Void then
				update_background_color (color_dialog.color)
			end
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				if color_dialog.selected_button_name.same_string ((create {EV_DIALOG_NAMES}).ev_ok) then
					format.set_background_color (color_dialog.color)
					create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.background_color)
					rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
				end
			else
				format := rich_text.character_format (rich_text.caret_position)
				if color_dialog.selected_button_name.same_string ((create {EV_DIALOG_NAMES}).ev_ok) then
					format.set_background_color (color_dialog.color)
					rich_text.set_current_format (format)
				end
			end
		end

	underline_selected
			-- Called by `select_actions' of `underlined_button'.
		local
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				effects := format.effects
				if underlined_button.is_selected then
					effects.enable_underlined
				else
					effects.disable_underlined
				end
				format.set_effects (effects)
				create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined)
				rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				effects := format.effects
				if underlined_button.is_selected then
					effects.enable_underlined
				else
					effects.disable_underlined
				end
				format.set_effects (effects)
				rich_text.set_current_format (format)
			end
		end

	strike_through_selected
			-- Called by `select_actions' of `striked_through_button'.
		local
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			strike_through: BOOLEAN
			effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				effects := format.effects
				strike_through := effects.is_striked_out
				if striked_through_button.is_selected then
					effects.enable_striked_out
				else
					effects.disable_striked_out
				end
				format.set_effects (effects)
				create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out)
				rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				effects := format.effects
				if striked_through_button.is_selected then
					effects.enable_striked_out
				else
					effects.disable_striked_out
				end
				format.set_effects (effects)
				rich_text.set_current_format (format)
			end
		end

	word_wrapping_toggled
			-- Called by `select_actions' of `word_wrapping_menu_item'.
			-- Enable/disable word wrapping in `rich_text' based
			-- on state of `word_wrapping_menu_item'.
		do
			lock_update
			if word_wrapping_menu_item.is_selected then
				rich_text.enable_word_wrapping
			else
				rich_text.disable_word_wrapping
			end
			unlock_update
		end

	left_alignment_selected
			-- Called by `select_actions' of `left_alignment_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if not left_alignment_button.is_selected then
				left_alignment_button.select_actions.block
				left_alignment_button.enable_select
				left_alignment_button.select_actions.resume
			else
				unselect_all_buttons_except (left_alignment_button)
			end
			caret_position := rich_text.caret_position
			paragraph := rich_text.paragraph_format (caret_position)
			paragraph.enable_left_alignment

			if rich_text.has_selection then
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.alignment)
				rich_text.modify_paragraph (rich_text.start_selection, rich_text.end_selection - 1,
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	center_alignment_selected
			-- Called by `select_actions' of `center_alignment_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if not center_alignment_button.is_selected then
				center_alignment_button.select_actions.block
				center_alignment_button.enable_select
				center_alignment_button.select_actions.resume
			else
				unselect_all_buttons_except (center_alignment_button)
			end
			caret_position := rich_text.caret_position
			paragraph := rich_text.paragraph_format (caret_position)
			paragraph.enable_center_alignment

			if rich_text.has_selection then
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.alignment)
				rich_text.modify_paragraph (rich_text.start_selection, rich_text.end_selection - 1,
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	right_alignment_selected
			-- Called by `select_actions' of `right_alignment_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if not right_alignment_button.is_selected then
				right_alignment_button.select_actions.block
				right_alignment_button.enable_select
				right_alignment_button.select_actions.resume
			else
				unselect_all_buttons_except (right_alignment_button)
			end
			caret_position := rich_text.caret_position
			paragraph := rich_text.paragraph_format (caret_position)
			paragraph.enable_right_alignment

			if rich_text.has_selection then
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.alignment)
				rich_text.modify_paragraph (rich_text.start_selection, rich_text.end_selection - 1,
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	justified_selected
			-- Called by `select_actions' of `justified_button'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if not justified_button.is_selected then
				justified_button.select_actions.block
				justified_button.enable_select
				justified_button.select_actions.resume
			else
				unselect_all_buttons_except (justified_button)
			end
			caret_position := rich_text.caret_position
			paragraph := rich_text.paragraph_format (caret_position)
			paragraph.enable_justification

			if rich_text.has_selection then
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.alignment)
				rich_text.modify_paragraph (rich_text.start_selection, rich_text.end_selection - 1,
					paragraph,
					paragraph_info)
			else
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

feature {NONE} -- Implementation

	caret_moved (new_position: INTEGER)
			-- Caret of `rich_text' has moved to position `new_position'.
		local
			current_line_number: INTEGER
			format: EV_CHARACTER_FORMAT
			paragraph_format: EV_PARAGRAPH_FORMAT
			x, y: INTEGER
		do
			current_line_number := rich_text.current_line_number
			y := current_line_number
			x := rich_text.first_position_from_line_number (y)
			x := new_position - x + 1

				-- Display caret position in status bar.
			caret_position_label.set_text (x.out + " " + y.out)

				-- Update display corresponding to character formatting at
				-- new caret position.
			format := rich_text.character_format (new_position)
			display_format (format)

 			paragraph_format := rich_text.paragraph_format (new_position)
			display_paragraph_format (paragraph_format)
		end

	display_format (format: EV_CHARACTER_FORMAT)
			-- Udpate formatting toolbars to reflect formatting in `format'.
		require
			format_not_void: format /= Void
		local
			font: EV_FONT
			name_matched: BOOLEAN
			effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			font := format.font
			effects := format.effects

				-- Updated Displayed font weight
			bold_button.select_actions.block
			if font.weight = {EV_FONT_CONSTANTS}.weight_bold then
				bold_button.enable_select
			else
				bold_button.disable_select
			end
			bold_button.select_actions.resume

				-- Update displayed font shape.
			italic_button.select_actions.block
			if font.shape = {EV_FONT_CONSTANTS}.shape_italic then
				italic_button.enable_select
			else
				italic_button.disable_select
			end
			italic_button.select_actions.resume

				-- Update displayed font underline.
			underlined_button.select_actions.block
			if effects.is_underlined then
				underlined_button.enable_select
			else
				underlined_button.disable_select
			end
			underlined_button.select_actions.resume

				-- Update displayed font strike through.
			striked_through_button.select_actions.block
			if effects.is_striked_out then
				striked_through_button.enable_select
			else
				striked_through_button.disable_select
			end
			striked_through_button.select_actions.resume

				-- Update displayed vertical character offset
			vertical_offset.change_actions.block
			vertical_offset.set_value (effects.vertical_offset)
			vertical_offset.change_actions.resume

				-- Update displayed font size.
			size_selection.set_text (font.height_in_points.out)

				-- Update displayed font name.
			from
				font_selection.start
			until
				font_selection.off or name_matched
			loop
				if font_selection.item.text.is_equal (font.name) then
					font_selection.item.enable_select
					name_matched := True
				end
				font_selection.forth
			end

				-- Update displayed font color.
			if not last_displayed_color.is_equal (format.color) then
				update_color (format.color)
			end
				-- Update displayed font background color
			if not last_displayed_background_color.is_equal (format.background_color) then
				update_background_color (format.background_color)
			end
		end

	display_paragraph_format (paragraph_format: EV_PARAGRAPH_FORMAT)
			-- Update display to reflect paragraph formatting in `paragraph_format'.
		do
			if paragraph_format.is_left_aligned then
				left_alignment_button.select_actions.block
				unselect_all_buttons_except (left_alignment_button)
				left_alignment_button.select_actions.resume
			elseif paragraph_format.is_center_aligned then
				center_alignment_button.select_actions.block
				unselect_all_buttons_except (center_alignment_button)
				center_alignment_button.select_actions.resume
			elseif paragraph_format.is_right_aligned then
				right_alignment_button.select_actions.block
				unselect_all_buttons_except (right_alignment_button)
				right_alignment_button.select_actions.resume
			elseif paragraph_format.is_justified then
				right_alignment_button.select_actions.resume
				unselect_all_buttons_except (justified_button)
				right_alignment_button.select_actions.resume
			end
			left_margin.change_actions.block
			left_margin.set_value (paragraph_format.left_margin)
			left_margin.change_actions.resume

			right_margin.change_actions.block
			right_margin.set_value (paragraph_format.right_margin)
			right_margin.change_actions.resume

			top_spacing.change_actions.block
			top_spacing.set_value (paragraph_format.top_spacing)
			top_spacing.change_actions.resume

			bottom_spacing.change_actions.block
			bottom_spacing.set_value (paragraph_format.bottom_spacing)
			bottom_spacing.change_actions.resume
		end

	selection_changed
			-- The selection in `rich_text' has changed, so update
			-- formatting displayed in toolbar.
		local
			format: EV_CHARACTER_FORMAT
			formatting: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			paragraph_formatting: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			paragraph: EV_PARAGRAPH_FORMAT
			current_value: STRING
		do
			if rich_text.has_selection then
					-- Retrieve the format at the end of the selection.
				format := rich_text.selected_character_format

					-- Retrieve information regarding the consistency of formatting within selected range.
				formatting := rich_text.character_format_range_information (rich_text.start_selection, rich_text.end_selection)

				if formatting.font_height then
						-- Font height is consistent throughout complete selection so display this size.
					current_value := format.font.height_in_points.out
					if not size_selection.text.same_string_general (current_value) then
						from
							size_selection.start
						until
							size_selection.off or current_value = Void
						loop
							if size_selection.item.text.same_string_general (current_value) then
								size_selection.select_actions.block
								size_selection.item.enable_select
								size_selection.select_actions.resume
								current_value := Void
							end
							size_selection.forth
						end
						if current_value /= Void then
							size_selection.set_text (current_value)
						end
					end
				else
						-- Font height is not consistent throughout complete selection so hide the size.
					size_selection.remove_text
					size_selection.remove_selection
				end

				if formatting.font_family then
						-- Font family is consistent throughout compelete selection so display the family.
					current_value := format.font.name.out
					if not font_selection.text.same_string_general (current_value) then
						from
							font_selection.start
						until
							font_selection.off or current_value = Void
						loop
							if font_selection.item.text.same_string_general (current_value) then
								font_selection.select_actions.block
								font_selection.item.enable_select
								font_selection.select_actions.resume
								current_value := Void
							end
							font_selection.forth
						end
					end
				else
						-- Font family is not consistent throughout complete selection so hide family.
					font_selection.remove_text
					font_Selection.remove_selection
				end

				if formatting.color then
						-- Color is consistent throughout selection so update color display if not
						-- already equivalent to the color.
					if not format.color.is_equal (last_displayed_color) or color_undefined then
						update_color (format.color)
					end
				elseif not color_undefined then
						-- Color is not consistent throughout complete selection so display color as
					update_color_as_undefined
				end
				if formatting.background_color then
						-- Background color is consistent throughout selection so update color display if not
						-- already equivalent to the color.
					if not format.background_color.is_equal (last_displayed_background_color) or background_color_undefined then
						update_background_color (format.background_color)
					end
				elseif not background_color_undefined then
						-- Color is not consistent throughout complete selection so display color as
					update_background_color_as_undefined
				end

					-- Update bold display so that it is only displayed as bold if the formatting is
					-- consistently bold.
				bold_button.select_actions.block
				if formatting.font_weight and format.font.weight = (create {EV_FONT_CONSTANTS}).weight_bold then
					bold_button.enable_select
				else
					bold_button.disable_select
				end
				bold_button.select_actions.resume

					-- Update italic display so that it is only displayed as italic if the formatting is
					-- consistently italic.
				italic_button.select_actions.block
				if formatting.font_shape and format.font.shape = (create {EV_FONT_CONSTANTS}).shape_italic then
					italic_button.enable_select
				else
					italic_button.disable_select
				end
				italic_button.select_actions.resume

				vertical_offset.change_actions.block
				if formatting.effects_vertical_offset then
					vertical_offset.set_value (format.effects.vertical_offset)
				else
					vertical_offset.remove_text
				end
				vertical_offset.change_actions.resume

					-- Now handle information regarding paragraphs.
				paragraph := rich_text.selected_paragraph_format
				paragraph_formatting := rich_text.paragraph_format_range_information (rich_text.start_selection,
					rich_text.end_selection)

				if paragraph_formatting.alignment then
					if paragraph.is_left_aligned then
						unselect_all_buttons_except (left_alignment_button)
					elseif paragraph.is_center_aligned then
						unselect_all_buttons_except (center_alignment_button)
					elseif paragraph.is_right_aligned then
						unselect_all_buttons_except (right_alignment_button)
					elseif paragraph.is_justified then
						unselect_all_buttons_except (justified_button)
					else
						check
							invalid_alignment: False
						end
					end
				else
					unselect_all_buttons (paragraph_toolbar)
				end
				if paragraph_formatting.left_margin then
					left_margin.change_actions.block
					left_margin.set_text (paragraph.left_margin.out)
					left_margin.change_actions.resume
				else
					left_margin.remove_text
				end
				if paragraph_formatting.right_margin then
					right_margin.change_actions.block
					right_margin.set_text (paragraph.right_margin.out)
					right_margin.change_actions.resume
				else
					right_margin.remove_text
				end
				if paragraph_formatting.top_spacing then
					top_spacing.change_actions.block
					top_spacing.set_text (paragraph.top_spacing.out)
					top_spacing.change_actions.resume
				else
					top_spacing.remove_text
				end
				if paragraph_formatting.bottom_spacing then
					bottom_spacing.change_actions.block
					bottom_spacing.set_text (paragraph.bottom_spacing.out)
					bottom_spacing.change_actions.resume
				else
					bottom_spacing.remove_text
				end
			else
					-- `selection_changed_actions' is fired once when the selection is removed,
					-- so in this case, we treat the update identically to when the caret has moved
					-- by calling `display_format'.
				format := rich_text.character_format (rich_text.caret_position)
				display_format (format)
				paragraph := rich_text.paragraph_format (rich_text.caret_position)
				display_paragraph_format (paragraph)
			end
		end

	update_color (a_color: EV_COLOR)
			-- Update color displayed in color tool bar button based on `a_color'.
		require
			color_not_void: a_color /= Void
		do
			redraw_button (color_button, a_color, False, "Color")
			last_displayed_color := a_color
			color_undefined := False
		end

	update_background_color (a_color: EV_COLOR)
			-- Update color displayed in background color tool bar button based on `a_color'.
		require
			color_not_void: a_color /= Void
		do
			redraw_button (background_color_button, a_color, False, "B Color")
			last_displayed_background_color := a_color
			background_color_undefined := False
		end

	redraw_button (button: EV_TOOL_BAR_BUTTON; a_color: EV_COLOR; undefined: BOOLEAN; text: STRING)
			--
		local
			pixmap: EV_PIXMAP
			text_size: TUPLE [INTEGER, INTEGER]
			text_width, text_height: INTEGER
		do
			create pixmap
			text_size := pixmap.font.string_size (text)
			text_width := text_size.integer_32_item (1)
			text_height := text_size.integer_32_item (2)
			pixmap.set_size (text_width + text_height + 2, 16)
			pixmap.set_background_color (format_toolbar.background_color)
			pixmap.clear
			pixmap.draw_text_top_left (text_height + 2, ((16 - text_height) // 2), text)

			if undefined then
				pixmap.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				pixmap.draw_rectangle (1, 1 + ((16 - text_height) // 2), text_height - 2, text_height - 2)
			else
				pixmap.set_foreground_color (a_color)
				pixmap.fill_rectangle (1, 1 + ((16 - text_height) // 2), text_height - 2, text_height - 2)
			end
			button.set_pixmap (pixmap)
		end

	update_color_as_undefined
			-- Update color to display in color tool bar button as undefined
		do
			redraw_button (color_button, Void, True, "Color")
			color_undefined := True
		end

	update_background_color_as_undefined
			-- Update color to display in background color tool bar button as undefined.
		do
			redraw_button (background_color_button, Void, True, "B Color")
			background_color_undefined := True
		end

	unselect_all_buttons_except (a_button: EV_TOOL_BAR_TOGGLE_BUTTON)
			-- Unselect all toggle buttons in `parent' of `a_button', excluding `a_button', ensuring
			-- `a_button' is slected..
			-- Do not fire `select_actions' of any buttons.
		require
			a_button_not_void: a_button /= Void
			a_button_parented: a_button.parent /= Void
		local
			tool_bar: EV_TOOL_BAR
			was_already_blocked: BOOLEAN
		do
			tool_bar := a_button.parent
			from
				tool_bar.start
			until
				tool_bar.off
			loop
				if tool_bar.item /= a_button then
					if attached {EV_TOOL_BAR_TOGGLE_BUTTON} tool_bar.item as toggle_button then
						was_already_blocked := False
						if toggle_button.select_actions.state /= toggle_button.select_actions.blocked_state then
							toggle_button.select_actions.block
						else
							was_already_blocked := True
						end
						toggle_button.disable_select
						if not was_already_blocked then
							toggle_button.select_actions.resume
						end
					end
				else
						-- Now ensure `a_button' is selected.
					was_already_blocked := False
					if a_button.select_actions.state /= a_button.select_actions.blocked_state then
						a_button.select_actions.block
					else
						was_already_blocked := True
					end
					a_button.enable_select
					if not was_already_blocked then
						a_button.select_actions.resume
					end
				end
				tool_bar.forth
			end
		end

	unselect_all_buttons (tool_bar: EV_TOOL_BAR)
			-- Unselect all toggle buttons in `tool_bar'.
		require
			tool_bar_not_void: tool_bar /= Void
		do
			from
				tool_bar.start
			until
				tool_bar.off
			loop
				if attached {EV_TOOL_BAR_TOGGLE_BUTTON} tool_bar.item as toggle_button then
					toggle_button.select_actions.block
					toggle_button.disable_select
					toggle_button.select_actions.resume
				end
				tool_bar.forth
			end
		end

	show_paragraph_toolbar_selected
			-- Called by `select_actions' of `show_paragraph_toolbar'.
		do
			if show_paragraph_toolbar.is_selected then
				paragraph_toolbar_holder.show
			else
				paragraph_toolbar_holder.hide
			end
		end

	left_margin_changed (a_value: INTEGER)
			-- Called by `change_actions' of `left_margin'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_left_margin (a_value)
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.left_margin)
				rich_text.modify_paragraph (rich_text.start_selection,
						rich_text.end_selection - 1,
						paragraph,
						paragraph_info)

			else
				caret_position := rich_text.caret_position
				paragraph := rich_text.paragraph_format (caret_position)
				paragraph.set_left_margin (a_value)
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	right_margin_changed (a_value: INTEGER)
			-- Called by `change_actions' of `right_margin'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_right_margin (a_value)
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.right_margin)
				rich_text.modify_paragraph (rich_text.start_selection, rich_text.end_selection - 1,
						paragraph,
						paragraph_info)
			else
				caret_position := rich_text.caret_position
				paragraph := rich_text.paragraph_format (caret_position)
				paragraph.set_right_margin (a_value)
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	top_spacing_changed (a_value: INTEGER)
			-- Called by `change_actions' of `top_spacing'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_top_spacing (a_value)
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.top_spacing)
				rich_text.modify_paragraph (rich_text.start_selection,
						rich_text.end_selection - 1,
						paragraph,
						paragraph_info)
			else
				caret_position := rich_text.caret_position
				paragraph := rich_text.paragraph_format (caret_position)
				paragraph.set_top_spacing (a_value)
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	bottom_spacing_changed (a_value: INTEGER)
			-- Called by `change_actions' of `bottom_spacing'.
		local
			paragraph: EV_PARAGRAPH_FORMAT
			paragraph_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			caret_position: INTEGER
		do
			if rich_text.has_selection then
				create paragraph
				paragraph.set_top_spacing (a_value)
				create paragraph_info.make_with_flags ({EV_PARAGRAPH_CONSTANTS}.bottom_spacing)
				rich_text.modify_paragraph (rich_text.start_selection, rich_text.end_selection - 1,
						paragraph,
						paragraph_info)
			else
				caret_position := rich_text.caret_position
				paragraph := rich_text.paragraph_format (caret_position)
				paragraph.set_bottom_spacing (a_value)
				rich_text.format_paragraph (caret_position, caret_position, paragraph)
			end
		end

	offset_changed (a_value: INTEGER)
			-- Called by `change_actions' of `offset'.
		local
			format: EV_CHARACTER_FORMAT
			char_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			effects: EV_CHARACTER_FORMAT_EFFECTS
		do
			if rich_text.has_selection then
				format := rich_text.character_format (rich_text.start_selection)
				effects := format.effects
				effects.set_vertical_offset (a_value)
				format.set_effects (effects)
				create char_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset)
				rich_text.modify_region (rich_text.start_selection, rich_text.end_selection, format, char_info)
			else
				format := rich_text.character_format (rich_text.caret_position)
				effects := format.effects
				effects.set_vertical_offset (a_value)
				format.set_effects (effects)
				rich_text.set_current_format (format)
			end
			rich_text.set_focus
		end

feature {NONE} -- Implementation

	current_file_name: PATH
		-- File name currently used for Loading and saving files.

	exit
			-- Exit the application
		do
			rich_text.destroy;
			((create {EV_ENVIRONMENT}).application).destroy
		end

	last_displayed_color: EV_COLOR
			-- Last color displayed, stored to prevent unecessary updating of displayed color.

	last_displayed_background_color: EV_COLOR
			-- Last displayed background color, stored to prevent unecessary updating of displayed color.

	color_undefined: BOOLEAN
			-- Is the color currently displayed undefined?

	background_color_undefined: BOOLEAN
			-- Is the background color currently displayed undefined?

	point_font_heights: ARRAY [INTEGER]
			-- Heights in points to be added to `size_selection'.
		once
			Result := <<8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72>>
		end

	open_file
			-- Called by `select_actions' of `open_menu_item'.
		do
			get_file_name (opening_file)
			if not file_dialog_cancelled then
				save_progress.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 100))
				general_label.hide
				save_progress.show
				rich_text.set_with_named_path (current_file_name)
				save_progress.hide
				general_label.show
			end
		end

	save_file
			-- Called by `select_actions' of `s'.
		do
			if current_file_name = Void and not file_dialog_cancelled then
				get_file_name (saving_file)
			end
			if not file_dialog_cancelled then
				save_progress.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 100))
				general_label.hide
				save_progress.show
				rich_text.save_to_named_path (current_file_name)
				save_progress.hide
				general_label.show
			end
		end

	save_file_as
			-- Called by `select_actions' of `save_as_menu_item'.
		do
			get_file_name (saving_file)
			save_file
		end

	get_file_name (file_operation: INTEGER)
			-- Retreieve file name for file operation type `file_operation' into
			-- `current_file_name'. Set `file_dialog_cancelled' to hold whether the
			-- dialog was cancelled or not.
		require
			opening_or_saving_file: file_operation = opening_file or file_operation = saving_file
		local
			file_dialog: EV_FILE_DIALOG
		do
			if file_operation = saving_file then
				create {EV_FILE_SAVE_DIALOG} file_dialog
			else
				create {EV_FILE_OPEN_DIALOG} file_dialog
			end
			file_dialog.filters.extend (["*.rtf", "Rtf Files (*.rtf)"])
			file_dialog.show_modal_to_window (Current)
			if file_dialog.selected_button_name.same_string ((create {EV_DIALOG_NAMES}).ev_cancel)  then
				file_dialog_cancelled := True
			else
				current_file_name := file_dialog.full_file_path
					-- We now add the ".rtf" extension if one has not been added.
				if not current_file_name.has_extension ("rtf") then
					current_file_name := current_file_name.appended_with_extension ("rtf")
				end
				file_dialog_cancelled := False
			end
		end

	opening_file: INTEGER = 1
	saving_file: INTEGER = 2
		-- Constants used to determine which type of file dialog
		-- to display within `get_file_name'.

	file_dialog_cancelled: BOOLEAN
		-- Was dialog shown by last call to `get_file_name' cancelled?

	update_progress_on_file_access (pos: INTEGER)
			-- Display progress of file loading or saving operation.
		local
			app: EV_APPLICATION
		do
			save_progress.set_value (pos)
			app := (create {EV_ENVIRONMENT}).application
				-- We must check that the application is launched as when we first
				-- load the rtf upon starting, the application has not yet been launched.
			if app.is_launched then
				app.process_events
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


end -- class MAIN_WINDOW
