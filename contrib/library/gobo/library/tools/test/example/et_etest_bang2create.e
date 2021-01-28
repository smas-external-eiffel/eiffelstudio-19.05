note

	description:

		"Test 'bang2create' example"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class ET_ETEST_BANG2CREATE

inherit

	EXAMPLE_TEST_CASE

create

	make_default

feature -- Access

	program_name: STRING = "bang2create"
			-- Program name

	library_name: STRING = "tools"
			-- Library name of example

feature -- Test

	test_bang2create
			-- Test 'bang2create' example.
		do
			compile_program
		end

end
