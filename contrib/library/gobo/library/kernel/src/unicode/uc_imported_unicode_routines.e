note

	description:

		"Imported unicode routines"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-07 22:54:15 +0000 (Thu, 07 Feb 2019) $"
	revision: "$Revision: 102807 $"

class UC_IMPORTED_UNICODE_ROUTINES

feature -- Access

	unicode: UC_UNICODE_ROUTINES
			-- Unicode routines
		once
			create Result
		ensure
			instance_free: class
			unicode_not_void: Result /= Void
		end

end