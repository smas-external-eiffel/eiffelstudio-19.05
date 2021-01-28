note

	description:

		"Test 'gegrep' example"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class LX_ETEST_GEGREP

inherit

	EXAMPLE_TEST_CASE

create

	make_default

feature -- Access

	program_name: STRING = "gegrep"
			-- Program name

	library_name: STRING = "lexical"
			-- Library name of example

feature -- Test

	test_gegrep
			-- Test 'gegrep' example.
		do
			compile_program
		end

end
