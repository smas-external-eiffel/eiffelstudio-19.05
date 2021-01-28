note
	description : "Objects that ..."
	author      : "$Author: jfiat $"
	date        : "$Date: 2017-03-07 13:26:26 +0000 (Tue, 07 Mar 2017) $"
	revision    : "$Revision: 99933 $"

class
	IMAGE_UPLOADER

inherit
	WSF_DEFAULT_SERVICE [IMAGE_UPLOADER_EXECUTION]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current
		do
				-- To use particular port number (as 9090) with Standalone connector
				-- Uncomment the following line
			set_service_option ("port", 9090)
			make_and_launch
		end

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end