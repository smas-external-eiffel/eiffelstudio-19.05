note
	description: "Summary description for {WSF_FORM_RADIO_INPUT}."
	author: ""
	date: "$Date: 2017-03-07 13:26:26 +0000 (Tue, 07 Mar 2017) $"
	revision: "$Revision: 99933 $"

class
	WSF_FORM_RADIO_INPUT

inherit
	WSF_FORM_SELECTABLE_INPUT

create
	make,
	make_with_value

feature -- Access

	input_type: STRING = "radio"

invariant

end
