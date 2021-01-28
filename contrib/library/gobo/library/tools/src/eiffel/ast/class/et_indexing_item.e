note

	description:

		"Eiffel note clauses which appear in a semicolon-separated list of note clauses"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class ET_INDEXING_ITEM

inherit

	ET_AST_NODE

feature -- Access

	indexing_clause: ET_INDEXING
			-- Note clause in semicolon-separated list
		deferred
		ensure
			indexing_clause_not_void: Result /= Void
		end

end