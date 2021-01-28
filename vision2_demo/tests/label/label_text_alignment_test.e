note
	description: "Objects that test text_alignment of EV_LABEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-31 17:18:34 +0000 (Wed, 31 Dec 2008) $"
	revision: "$Revision: 76491 $"

class
	LABEL_TEXT_ALIGNMENT_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			combo_box: EV_COMBO_BOX
			list_item: EV_LIST_ITEM
		do
				-- Create `label' using `make_with_text'.
			create label.make_with_text ("A Label")
			label.set_minimum_size (200, 200)
			
			create vertical_box
			vertical_box.extend (label)
			
			create combo_box
			create list_item.make_with_text ("Alignment left")
			list_item.select_actions.extend (agent label.align_text_left)
			combo_box.extend (list_item)
			create list_item.make_with_text ("Alignment center")
			list_item.select_actions.extend (agent label.align_text_center)
			combo_box.extend (list_item)
			create list_item.make_with_text ("Alignment right")
			list_item.select_actions.extend (agent label.align_text_right)
			combo_box.extend (list_item)
			
			vertical_box.extend (combo_box)
			vertical_box.disable_item_expand (combo_box)
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	label: EV_LABEL;
		-- Widget that test is to be performed on.

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


end -- class LABEL_TEXT_ALIGNMENT_TEST
