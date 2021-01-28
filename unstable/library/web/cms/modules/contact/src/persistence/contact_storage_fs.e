note
	description: "[
			Contact message storage based on SQL statements.
		]"
	date: "$Date: 2017-06-12 07:37:33 +0000 (Mon, 12 Jun 2017) $"
	revision: "$Revision: 100460 $"

class
	CONTACT_STORAGE_FS

inherit
	CONTACT_STORAGE_I

	CMS_STORAGE_FS_I

	REFACTORING_HELPER

create
	make

feature -- Access	

feature -- Change

	save_contact_message (m: CONTACT_MESSAGE)
		local
			s: STRING
			now: DATE_TIME
		do
			error_handler.reset
			create now.make_now_utc

			write_information_log (generator + ".save_contact_message")

			create s.make_empty
			s.append ("date=")
			s.append (m.date.out)
			s.append_character ('%N')
			s.append ("name=")
			s.append (api.utf_8_encoded (m.username))
			s.append_character ('%N')

			if attached m.email as l_email then
				s.append ("email=")
				s.append (l_email)
				s.append_character ('%N')
			end
			s.append ("message=%N")
			s.append (api.utf_8_encoded (m.message))
			s.append_character ('%N')

			save_to_file (s, date_to_yyyymmdd_hhmmss_string (now))
		end

end