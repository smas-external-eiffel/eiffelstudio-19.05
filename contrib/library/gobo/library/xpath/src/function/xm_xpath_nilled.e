note

	description:

		"Objects that implement the XPath nilled() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005-2015, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class XM_XPATH_NILLED

inherit

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			evaluate_item
		end

	XM_XPATH_TOKENS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make
			-- Establish invariant
		do
			name := "nilled"
			namespace_uri := Xpath_standard_functions_uri
			fingerprint := Nilled_function_type_code
			minimum_argument_count := 1
			maximum_argument_count := 1
			create arguments.make (1)
			arguments.set_equality_tester (expression_tester)
			initialized := True
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, where known
		do
			Result := type_factory.boolean_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE
			-- Type of argument number `argument_number'
		do
			create Result.make_optional_node
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [detachable XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT)
			-- Evaluate as a single item to `a_result'.
		local
			l_node: XM_XPATH_NODE
		do
			arguments.item (1).evaluate_item (a_result, a_context)
			if attached a_result.item as a_result_item and then not a_result_item.is_error then
				if a_result_item.is_node then
					l_node := a_result_item.as_node
					if l_node.node_type = Element_node then
						check
							not_schema_aware: conformance.basic_xslt_processor
							-- Actually, the real critereon is that
							--  the data model has been built from an infoset,
							--  not a PSVI
						end
						a_result.put (create {XM_XPATH_BOOLEAN_VALUE}.make (False))
					else
						a_result.put (Void)
					end
				else
					a_result.put (Void)
				end
			end
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality
			-- Compute cardinality.
		do
			set_cardinality_optional
		end

end
