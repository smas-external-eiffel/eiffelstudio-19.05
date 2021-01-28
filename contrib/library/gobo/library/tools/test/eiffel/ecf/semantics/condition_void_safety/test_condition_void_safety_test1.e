note

	description:

		"Test ECF condition void_safety"

	copyright: "Copyright (c) 2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class TEST_CONDITION_VOID_SAFETY_TEST1

inherit

	EIFFEL_TEST_CASE

create

	make_default

feature -- Test

	test_validity
			-- Test for ECF condition void_safety.
		do
			compile_and_test ("test1")
		end

feature {NONE} -- Implementation

	rule_dirname: STRING
			-- Name of the directory containing the tests of the ECF condition void_safety being tested
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"library", "tools", "test", "eiffel", "ecf", "semantics", "condition_void_safety">>)
			Result := Execution_environment.interpreted_string (Result)
		end

	testdir: STRING
			-- Name of temporary directory where to run the test
		do
			Result := "Ttest1"
		end

end