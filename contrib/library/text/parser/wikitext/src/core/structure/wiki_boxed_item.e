note
	description: "Summary description for {WIKI_BOXED_ITEM}."
	author: ""
	date: "$Date: 2013-08-02 09:42:20 +0000 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92840 $"

class
	WIKI_BOXED_ITEM

inherit
	WIKI_BOX [WIKI_ITEM]

create
	make

feature {NONE} -- Initialization

	make (a_item: WIKI_ITEM)
		do
			initialize
			add_element (a_item)
		end

invariant

	single_item: count = 1

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
