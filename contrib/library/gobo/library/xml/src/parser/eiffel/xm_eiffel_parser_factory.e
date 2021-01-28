note

	description:

		"Factories for Eiffel XML parsers"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class XM_EIFFEL_PARSER_FACTORY

inherit

	XM_PARSER_FACTORY
		rename
			is_parser_available as is_eiffel_parser_available,
			new_parser as new_eiffel_parser
		end

feature -- Status report

	is_eiffel_parser_available: BOOLEAN
			-- Is Eiffel XML parser available?
		do
			Result := True
		end

feature -- Access

	new_eiffel_parser: XM_PARSER
			-- New Eiffel XML parser
		do
			create {XM_EIFFEL_PARSER} Result.make
		end

end
