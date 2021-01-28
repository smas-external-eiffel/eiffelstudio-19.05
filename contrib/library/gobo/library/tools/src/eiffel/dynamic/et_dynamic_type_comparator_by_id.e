note

	description:

		"Dynamic type comparators by id"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2016-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2017-04-11 18:34:55 +0000 (Tue, 11 Apr 2017) $"
	revision: "$Revision: 100137 $"

class ET_DYNAMIC_TYPE_COMPARATOR_BY_ID

inherit

	KL_COMPARATOR [ET_DYNAMIC_TYPE]
		redefine
			less_than
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new comparator.
		do
		end

feature -- Status report

	less_than, attached_less_than (u, v: ET_DYNAMIC_TYPE): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := (u.id < v.id)
		end

end