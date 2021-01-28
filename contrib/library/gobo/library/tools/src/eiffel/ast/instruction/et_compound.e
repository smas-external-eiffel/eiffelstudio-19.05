note

	description:

		"Eiffel instruction compounds"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class ET_COMPOUND

inherit

	ET_AST_NODE

	ET_HEAD_LIST [ET_INSTRUCTION]
		redefine
			make, make_with_capacity
		end

create

	make, make_with_capacity

feature {NONE} -- Initialization

	make
			-- Create a new compound.
		do
			keyword := tokens.do_keyword
			precursor
		end

	make_with_capacity (nb: INTEGER)
			-- Create a new compound with capacity `nb'.
		do
			keyword := tokens.do_keyword
			precursor (nb)
		end

feature -- Initialization

	reset
			-- Reset instructions as they were when they were last parsed.
		local
			i, nb: INTEGER
		do
			nb := count - 1
			from i := 0 until i > nb loop
				storage.item (i).reset
				i := i + 1
			end
		end

feature -- Status report

	has_non_null_instruction: BOOLEAN
			-- Does current compound contain at least one non-null instruction?
		local
			i, nb: INTEGER
		do
			nb := count - 1
			from i := 0 until i > nb loop
				if not attached {ET_NULL_INSTRUCTION} storage.item (i) then
					Result := True
						-- Jump out of the loop.
					i := nb + 1
				end
				i := i + 1
			end
		end

feature -- Access

	keyword: ET_KEYWORD
			-- Keyword preceding the list of instructions

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			Result := keyword.position
			if Result.is_null and not is_empty then
				Result := first.position
			end
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			Result := keyword
		end

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			if is_empty then
				Result := keyword
			else
				Result := last.last_leaf
			end
		end

feature -- Setting

	set_keyword (a_keyword: like keyword)
			-- Set `keyword' to `a_keyword'.
		require
			a_keyword_not_void: a_keyword /= Void
		do
			keyword := a_keyword
		ensure
			keyword_set: keyword = a_keyword
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_compound (Current)
		end

feature {NONE} -- Implementation

	fixed_array: KL_SPECIAL_ROUTINES [ET_INSTRUCTION]
			-- Fixed array routines
		once
			create Result
		end

invariant

	keyword_not_void: keyword /= Void

end
