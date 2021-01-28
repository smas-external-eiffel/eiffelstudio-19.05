note

	description:

		"Objects that make security decisions"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004-2015, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class XM_XSLT_DEFAULT_SECURITY_MANAGER

inherit

	XM_XSLT_SECURITY_MANAGER

	XM_XPATH_DEFAULT_SECURITY_MANAGER

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make, make_highly_secure

feature {NONE} -- Initialization

	make
			-- Create with low security.
		do
			-- do_nothing
		end

	make_highly_secure
			-- Create with high security.
		do
			is_highly_secure := True
		end

feature -- Access

	is_output_uri_permitted (an_absolute_uri: UT_URI): BOOLEAN
			-- Is writing permitted to `an_absolute_uri'?
		do
			if is_highly_secure then
				Result := attached an_absolute_uri.scheme as l_scheme and then (STRING_.same_string (l_scheme, "stdout")
					or else STRING_.same_string (l_scheme, "string"))
			else
				Result := True
			end
		end

end

