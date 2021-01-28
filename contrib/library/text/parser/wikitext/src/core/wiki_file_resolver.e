note
	description: "Summary description for {WIKI_FILE_RESOLVER}."
	author: ""
	date: "$Date: 2015-03-19 10:17:40 +0000 (Thu, 19 Mar 2015) $"
	revision: "$Revision: 96872 $"

deferred class
	WIKI_FILE_RESOLVER

inherit
	WIKI_ITEM_RESOLVER

feature -- Access

	file_to_url (a_file: WIKI_FILE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the file `a_file' in the context of `a_page'.
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
