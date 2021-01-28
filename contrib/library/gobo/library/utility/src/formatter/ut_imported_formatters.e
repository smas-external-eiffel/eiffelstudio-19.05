note

	description:

		"Formatting routines"

	library: "Gobo Eiffel Utility Library"
	copyright: "Copyright (c) 1999-2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-07 22:54:15 +0000 (Thu, 07 Feb 2019) $"
	revision: "$Revision: 102807 $"

class UT_IMPORTED_FORMATTERS

feature -- Access

	INTEGER_FORMATTER_: UT_INTEGER_FORMATTER
			-- Formatting routines that ought
			-- to be in class INTEGER
		once
			create Result
		ensure
			instance_free: class
			integer_formatter_not_void: Result /= Void
		end

	CHARACTER_FORMATTER_: UT_CHARACTER_FORMATTER
			-- Formatting routines that ought
			-- to be in class CHARACTER
		once
			create Result
		ensure
			instance_free: class
			character_formatter_not_void: Result /= Void
		end

	BOOLEAN_FORMATTER_: UT_BOOLEAN_FORMATTER
			-- Formatting routines that ought
			-- to be in class BOOLEAN
		once
			create Result
		ensure
			instance_free: class
			boolean_formatter_not_void: Result /= Void
		end

	STRING_FORMATTER_: UT_STRING_FORMATTER
			-- Formatting routines that ought
			-- to be in class STRING
		once
			create Result
		ensure
			instance_free: class
			string_formatter_not_void: Result /= Void
		end

	ARRAY_FORMATTER_: UT_ARRAY_FORMATTER
			-- Formatting routines that ought
			-- to be in class ARRAY
		once
			create Result
		ensure
			instance_free: class
			array_formatter_not_void: Result /= Void
		end

end
