note

	description:

		"Eiffel real constants with underscores"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class ET_UNDERSCORED_REAL_CONSTANT

inherit

	ET_REAL_CONSTANT

create

	make

feature {NONE} -- Initialization

	make (a_literal: like literal)
			-- Create a new Real constant.
		require
			a_literal_not_void: a_literal /= Void
			-- valid_literal: (((_*[0-9]+_*)+\.(_*[0-9]_*)*|(_*[0-9]_*)*\.(_*[0-9]_*)+)([eE][+-]?(_*[0-9]_*)+)?).recognizes (a_literal)
		do
			literal := a_literal
			make_leaf
		ensure
			literal_set: literal = a_literal
			line_set: line = no_line
			column_set: column = no_column
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_underscored_real_constant (Current)
		end

invariant

	-- valid_literal: (((_*[0-9]+_*)+\.(_*[0-9]_*)*|(_*[0-9]_*)*\.(_*[0-9]_*)+)([eE][+-]?(_*[0-9]_*)+)?).recognizes (literal)

end