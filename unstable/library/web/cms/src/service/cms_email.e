note
	description: "CMS interface representing an email to be used with {CMS_API}.process_email (e: CMS_EMAIL)."
	date: "$Date: 2017-03-01 10:12:12 +0000 (Wed, 01 Mar 2017) $"
	revision: "$Revision: 99879 $"

class
	CMS_EMAIL

inherit
	NOTIFICATION_EMAIL

create
	make

feature -- Status report

	is_sent: BOOLEAN
			-- Current Email is sent.

feature -- Element change

	set_is_sent (b: BOOLEAN)
		do
			is_sent := b
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
