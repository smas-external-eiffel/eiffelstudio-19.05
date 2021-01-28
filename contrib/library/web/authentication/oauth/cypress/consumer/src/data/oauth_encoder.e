note
	description: "Encoding facilities for OAUTH purpose."
	date: "$Date: 2015-06-22 18:24:27 +0000 (Mon, 22 Jun 2015) $"
	revision: "$Revision: 97517 $"

class
	OAUTH_ENCODER

feature -- Encode

	encoded_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := url_encoder.general_encoded_string (s)
		end

feature -- Decode

	decoded_string (s: READABLE_STRING_GENERAL): STRING_32
		do
			Result := url_encoder.general_decoded_string (s)
		end

feature {NONE} -- Implementation

	url_encoder: URL_ENCODER
		once
			create Result
		end

note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
