note
	description: "Summary description for {WIKI_LIST_ITEM}."
	author: ""
	date: "$Date: 2013-08-02 09:42:20 +0000 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92840 $"

class
	WIKI_LIST_ITEM

inherit
	WIKI_LIST
		redefine
			debug_output,
			process
		end

create
	make_item

feature {NONE} -- Initialization

	make_item (a_description: STRING; s: STRING)
		do
			make (a_description)
			create text.make (s)
		end

feature -- Access

	text: WIKI_LINE -- STRING

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_list_item (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := Precursor + " " + text.debug_output
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
