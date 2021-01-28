note

	description:

		"Executable commands"

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class DP_COMMAND

inherit

	ANY
			-- Needed for SE 2.1b1.

feature -- Status report

	is_executable: BOOLEAN
			-- Can current command be executed?
			-- (Default: True.)
		do
			Result := True
		end

feature -- Execution

	execute
			-- Execute current command.
		require
			is_executable: is_executable
		deferred
		end

end
