note

	description:
	"[
		Binary search tree nodes where items are their own keys.
		Nodes may be linked to other binary search tree nodes.
	]"
	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2008, Daniel Tuser and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class DS_BINARY_SEARCH_TREE_SET_NODE [G]

inherit

	DS_BINARY_SEARCH_TREE_CONTAINER_NODE [G, G]
		rename
			key as item,
			set_key as set_item
		end

create {DS_BINARY_SEARCH_TREE_SET}

	make

feature {NONE} -- Initialization

	make (a_item: G)
			-- Create a new node.
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature {DS_BINARY_SEARCH_TREE_CONTAINER} -- Duplication

	copy_item_and_key_to (other: like Current)
			-- Copy `item' and `key' to `other'.
		do
			other.set_item (item)
		end

end
