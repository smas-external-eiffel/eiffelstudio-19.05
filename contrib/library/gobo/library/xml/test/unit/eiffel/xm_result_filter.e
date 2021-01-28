note

	description:

		"Filter collecting content events"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2004-2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-05 23:54:36 +0000 (Tue, 05 Feb 2019) $"
	revision: "$Revision: 102790 $"

class XM_RESULT_FILTER

inherit

	XM_CALLBACKS_FILTER
		redefine
			initialize,
			on_start,
			on_content
		end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make_null,
	make_next

feature {NONE} -- Initialization

	initialize
			-- Initialize current callbacks.
		do
			create content.make_empty
		end

feature

	content: STRING
			-- Collected content

	on_start
			-- Initialize.
		do
			initialize
		end

	on_content (a_string: STRING)
			-- Append to content.
		do
			content := STRING_.appended_string (content, a_string)
		end

invariant

--	content_not_void: content /= Void

end
