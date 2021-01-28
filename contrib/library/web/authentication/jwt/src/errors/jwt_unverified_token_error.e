note
	description: "Summary description for {JWT_UNVERIFIED_TOKEN_ERROR}."
	date: "$Date: 2017-06-20 16:16:59 +0000 (Tue, 20 Jun 2017) $"
	revision: "$Revision: 100534 $"

class
	JWT_UNVERIFIED_TOKEN_ERROR

inherit
	JWT_ERROR

feature -- Access

	id: STRING = "UNVERIFIED"

	message: READABLE_STRING_8
		do
			Result := "Unverified token"
		end

end