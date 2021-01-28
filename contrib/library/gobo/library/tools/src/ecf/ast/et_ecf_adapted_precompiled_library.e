note

	description:

		"ECF Eiffel adapted precompiled class libraries"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-07 22:54:15 +0000 (Thu, 07 Feb 2019) $"
	revision: "$Revision: 102807 $"

class ET_ECF_ADAPTED_PRECOMPILED_LIBRARY

inherit

	ET_ECF_ADAPTED_LIBRARY

create

	make

feature -- Access

	eifgens_location: detachable STRING
			-- Path to EIFGENs folder

feature -- Setting

	set_eifgens_location (a_eifgens_location: like eifgens_location)
			-- Set `eifgens_location' to `a_eifgens_location'.
		do
			eifgens_location := a_eifgens_location
		ensure
			eifgens_location_set: eifgens_location = a_eifgens_location
		end

end
