note
	description : "simple application execution"
	date        : "$Date: 2016-10-19 11:13:16 +0000 (Wed, 19 Oct 2016) $"
	revision    : "$Revision: 99307 $"

class
	APPLICATION_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature -- Basic operations

	execute
		local
			s: STRING
			dt: HTTP_DATE
 		do
 			-- To send a response we need to setup, the status code and
 			-- the response headers.
 			s := "Hello World!"
			create dt.make_now_utc
			s.append (" (UTC time is " + dt.rfc850_string + ").")
			s.append ("%N")
			s.append ("Your request: " + request.request_uri + " %N")
			response.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "text/html"], ["Content-Length", s.count.out]>>)
			response.set_status_code ({HTTP_STATUS_CODE}.ok)
			response.header.put_content_type_text_html
			response.header.put_content_length (s.count)
			if request.is_keep_alive_http_connection then
				response.header.put_connection_keep_alive
			end
			response.put_string (s)
		end

end
