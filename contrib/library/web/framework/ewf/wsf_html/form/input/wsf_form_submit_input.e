note
	description: "Summary description for {WSF_FORM_INPUT}."
	author: ""
	date: "$Date: 2017-03-07 13:26:26 +0000 (Tue, 07 Mar 2017) $"
	revision: "$Revision: 99933 $"

class
	WSF_FORM_SUBMIT_INPUT

inherit
	WSF_FORM_INPUT
		redefine
			specific_input_attributes_string
		end
	WSF_FORM_WITH_ALTERNATIVE_ACTIONS
	
create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "submit"


feature {NONE} -- Conversion

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			append_submit_image_input_attributes_to (Result)
		end
end
