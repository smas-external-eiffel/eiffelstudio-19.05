note

	description:

		"Eiffel qualified feature call instructions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class ET_QUALIFIED_FEATURE_CALL_INSTRUCTION

inherit

	ET_FEATURE_CALL_INSTRUCTION
		undefine
			is_qualified_call
		redefine
			target
		end

	ET_QUALIFIED_FEATURE_CALL
		redefine
			target
		end

feature -- Access

	target: ET_EXPRESSION
			-- Target
		deferred
		end

end
