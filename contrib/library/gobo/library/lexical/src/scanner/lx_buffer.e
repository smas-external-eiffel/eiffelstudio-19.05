note

	description:

		"Lexical analyzer input buffers"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class LX_BUFFER

create

	make

feature {NONE} -- Initialization

	make (a_string: STRING)
			-- Create a new buffer for `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			content := a_string
			index := 1
		ensure
			content_set: content = a_string
		end

feature -- Access

	content: STRING
			-- Input buffer characters

	index: INTEGER
			-- Current index in `content'

feature -- Setting

	set_index (i: INTEGER)
			-- Set `index' to `i'.
		require
			i_large_enough: i >= 1
		do
			index := i
		ensure
			index_set: index = i
		end

feature -- Element change

	refill
			-- Refill buffer.
		do
			index := content.count + 1
		end

invariant

	content_not_void: content /= Void
	valid_index: index >= 1

end
