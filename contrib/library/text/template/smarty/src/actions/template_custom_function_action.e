note
	description: "Summary description for {TEMPLATE_CUSTOM_FUNCTION_ACTION}."
	author: ""
	date: "$Date: 2016-12-02 22:55:13 +0000 (Fri, 02 Dec 2016) $"
	revision: "$Revision: 99617 $"

class
	TEMPLATE_CUSTOM_FUNCTION_ACTION

inherit
	TEMPLATE_CUSTOM_ACTION

create
	make

feature {NONE} -- Initialization

	make (fct: like function)
		do
			function := fct
		end

	function: FUNCTION [STRING, STRING_TABLE [STRING], detachable ANY]

feature -- Execution

	item (a_text: STRING; a_params: STRING_TABLE [STRING]; a_struct_action: TEMPLATE_STRUCTURE_ACTION): detachable ANY
		do
			Result := function.item ([a_text, a_params])
		end

invariant

note
	copyright: "2011-2016, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
