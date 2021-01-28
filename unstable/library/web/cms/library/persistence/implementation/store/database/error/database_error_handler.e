note
	description: "Database error handler"
	date: "$Date: 2014-11-13 15:23:47 +0000 (Thu, 13 Nov 2014) $"
	revision: "$Revision: 96085 $"

class
	DATABASE_ERROR_HANDLER

inherit
	ERROR_HANDLER

create
	make

feature -- Error operation

	add_database_error (a_message: READABLE_STRING_32; a_code: INTEGER)
			-- Add a database error.
		local
			l_error: DATABASE_ERROR
		do
			create l_error.make_from_message (a_message, a_code)
			add_error (l_error)
		end

	add_database_no_change_error (a_message: READABLE_STRING_32; a_code: INTEGER)
			-- Add a database error.
		local
			l_error: DATABASE_NO_CHANGE_ERROR
		do
			create l_error.make_from_message (a_message, a_code)
			add_error (l_error)
		end

end
