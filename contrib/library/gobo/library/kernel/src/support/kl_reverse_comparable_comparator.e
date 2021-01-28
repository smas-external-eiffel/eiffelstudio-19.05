note

	description:

		"Reverse comparators based on COMPARABLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2000-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2017-04-11 18:34:55 +0000 (Tue, 11 Apr 2017) $"
	revision: "$Revision: 100137 $"

class KL_REVERSE_COMPARABLE_COMPARATOR [G -> detachable COMPARABLE]

inherit

	KL_COMPARABLE_COMPARATOR [G]
		redefine
			attached_less_than
		end

create

	make

feature -- Status report

	attached_less_than (u, v: attached G): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := (v < u)
		end

end
