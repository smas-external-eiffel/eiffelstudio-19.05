note
	description: "JSON Boolean values"
	author: "$Author: jfiat $"
	date: "$Date: 2017-05-03 20:33:42 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100321 $"

class
	JSON_BOOLEAN

inherit

	JSON_VALUE

create
	make,
	make_true, make_false,
	make_boolean

feature {NONE} -- Initialization

	make (a_value: BOOLEAN)
			-- Initialize Current JSON boolean with `a_boolean'.
		do
			item := a_value
		end

	make_true
			-- Initialize Current JSON boolean with True.
		do
			make (True)
		end

	make_false
			-- Initialize Current JSON boolean with False.
		do
			make (False)
		end

	make_boolean (a_item: BOOLEAN)
			-- Initialize.
		obsolete
			"Use `make' [2017-05-31]"
		do
			make (a_item)
		end

feature -- Access

	item: BOOLEAN
			-- Content

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item.hash_code
		end

	representation: STRING
		do
			if item then
				Result := "true"
			else
				Result := "false"
			end
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_json_boolean' procedure on `a_visitor'.)
		do
			a_visitor.visit_json_boolean (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := item.out
		end

note
	copyright: "2010-2017, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end