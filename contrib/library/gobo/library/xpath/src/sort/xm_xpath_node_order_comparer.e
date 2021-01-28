note

	description:

		"Objects that compare two nodes to determine document order"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004-2017, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2017-04-11 18:34:55 +0000 (Tue, 11 Apr 2017) $"
	revision: "$Revision: 100137 $"

deferred class	XM_XPATH_NODE_ORDER_COMPARER

inherit

	KL_PART_COMPARATOR [XM_XPATH_NODE]
		redefine
			less_than
		end

feature -- Comparison

	three_way_comparison (a_node, another_node: XM_XPATH_NODE): INTEGER
			-- If nodes are then same, 0;
			-- if `a_node' smaller, -1; if greater, 1
		require
			first_node_not_void: a_node /= Void
			second_node_not_void: another_node /= Void
		deferred
		ensure
			valid_result: -1 <= Result and then Result <= 1
		end

	less_than, attached_less_than (u, v: XM_XPATH_NODE): BOOLEAN
        -- Is u considered less than v?
		do
			Result := three_way_comparison (u, v) = -1
		end

end

