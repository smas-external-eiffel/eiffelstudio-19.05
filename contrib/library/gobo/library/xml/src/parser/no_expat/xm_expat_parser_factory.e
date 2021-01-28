note

	description:

		"Factories for Expat XML parsers"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class XM_EXPAT_PARSER_FACTORY

inherit

	XM_PARSER_FACTORY
		rename
			is_parser_available as is_expat_parser_available,
			new_parser as new_expat_parser
		end

feature -- Status report

	is_expat_parser_available: BOOLEAN
			-- Is Expat XML parser available?
		do
			Result := False
		end

feature -- Access

	new_expat_parser: XM_PARSER
			-- New Expat XML parser
		do
			check not_possible: False then
			end
		ensure then
			not_possible: False
		end

end
