note

	description:

		"Test for validity rule VQMC-3"

	remark: "[
		In this test the decimal integer constant '128' in 'cc: INTEGER_8 = 128'
		is too big to be representable as an INTEGER_8.

		This rule is in ECMA 367-2, section 8.18.2, p.100.
		ISE reports that the type of 128 is INTEGER_32 and hence does not match
		the declared type INTEGER_8. This is not quite what ECMA 367-2 expects.
	]"

	copyright: "Copyright (c) 2009-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class TEST_VQMC3_TEST2

inherit

	EIFFEL_TEST_CASE

create

	make_default

feature -- Test

	test_validity
			-- Test for validity rule VQMC-3.
		do
			compile_and_test ("test2")
		end

feature {NONE} -- Implementation

	rule_dirname: STRING
			-- Name of the directory containing the tests of the rule being tested
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"library", "tools", "test", "eiffel", "validity", "vqmc3">>)
			Result := Execution_environment.interpreted_string (Result)
		end

	testdir: STRING
			-- Name of temporary directory where to run the test
		do
			Result := "Ttest2"
		end

end
