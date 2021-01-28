note
	description: "[
		Represent a Cipher Algorithm
	]"
	date: "$Date: 2018-11-15 20:31:45 +0000 (Thu, 15 Nov 2018) $"
	revision: "$Revision: 102468 $"

deferred class
	SSL_CIPHER_ALGORITHM

feature -- Access

	name: STRING
			-- name of the algorithm.
		deferred
		end

	key_size: INTEGER
			-- The size of the key being used as an integer in bits (e.g. 128, 256).
		deferred
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
