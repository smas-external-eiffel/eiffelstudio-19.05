note

	description:

		"Eiffel class parents in semicolon-separated list of class parents"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class ET_PARENT_ITEM

inherit

	ET_AST_NODE

feature -- Access

	parent: ET_PARENT
			-- Class parent in semicolon-separated list
		deferred
		ensure
			parent_not_void: Result /= Void
		end

end
