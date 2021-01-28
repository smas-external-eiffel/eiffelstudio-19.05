note

	description:

		"ECF external linker flag lists"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-07 22:54:15 +0000 (Thu, 07 Feb 2019) $"
	revision: "$Revision: 102807 $"

class ET_ECF_EXTERNAL_LINKER_FLAGS

inherit

	ET_ECF_EXTERNAL_FLAGS
		rename
			fill_external_values as fill_external_linker_flags
		redefine
			external_value
		end

create

	make, make_empty

feature -- Access

	external_value (i: INTEGER): ET_ECF_EXTERNAL_LINKER_FLAG
			-- `i'-th external linker flag
		do
			Result := external_values.item (i)
		end

end
