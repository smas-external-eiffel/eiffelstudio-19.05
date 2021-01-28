note

	description:

		"Test 'geant'"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2001-2002, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class TEST_GEANT

inherit

	TOOL_TEST_CASE

create

	make_default

feature -- Access

	program_name: STRING = "geant"
			-- Program name

feature -- Test

	test_geant
			-- Test 'geant'.
		do
			compile_program
		end

end