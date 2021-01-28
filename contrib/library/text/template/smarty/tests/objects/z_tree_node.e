note
	description : "Objects that ..."
	author      : "$Author: jfiat $"
	date        : "$Date: 2015-11-06 14:28:18 +0000 (Fri, 06 Nov 2015) $"
	revision    : "$Revision: 98084 $"

deferred
class
	Z_TREE_NODE

feature {NONE} -- Initialization

	make (n: STRING)
		do
			name := n
			id := counter.item + 1
			counter.replace (id)
		end

feature -- Access

	parent: detachable Z_TREE_NODE

	name: STRING

	unicode_text: detachable READABLE_STRING_32

	id: INTEGER

feature -- Change

	set_parent (p: like parent)
		do
			parent := p
		end

	set_unicode_text (v: detachable READABLE_STRING_32)
		do
			unicode_text := v
		end

feature {NONE} -- Impl

	counter: CELL [INTEGER]
		once
			create Result.put (0)
		end

end
