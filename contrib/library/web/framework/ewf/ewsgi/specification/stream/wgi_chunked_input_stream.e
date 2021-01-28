note
	description: "Input stream for chunked encoding request."
	date: "$Date: 2016-10-12 14:58:16 +0000 (Wed, 12 Oct 2016) $"
	revision: "$Revision: 99291 $"
	EIS: "name=Chunked Transfer Coding", "protocol=URI", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.6.1"

class
	WGI_CHUNKED_INPUT_STREAM

inherit
	WGI_INPUT_STREAM
		redefine
			last_character_available
		end

create
	make

feature {NONE} -- Implementation

	make (an_input: like input)
		do
			create last_string.make_empty
			create last_chunk_data.make_empty
			last_chunk_size := 0
			index := 0
			chunk_lower := 0
			chunk_upper := 0
			create tmp_hex_chunk_size.make_empty
			input := an_input
		end

feature -- Input

	read_character
			-- Read the next character in input stream.
			-- Make the result available in `last_character'
		local
			d: like last_chunk_data
			l_index_in_chunk: INTEGER
		do
			index := index + 1
			if index > chunk_upper then
				read_chunk_block
				if
					last_chunk_size = 0
				then
					read_trailer_and_crlf
					last_character := '%U'
				else
					l_index_in_chunk := chunk_index (index)
					d := last_chunk_data
					if d.valid_index (l_index_in_chunk) then
						last_character := d [l_index_in_chunk]
					else
						check has_character: False end
						last_character := '%U'
					end
				end
			else
				l_index_in_chunk := chunk_index (index)
				d := last_chunk_data
				if d.valid_index (l_index_in_chunk) then
					last_character := d [l_index_in_chunk]
				else
					check has_character: False end
					last_character := '%U'
				end
			end
		end

	read_string (nb: INTEGER)
			-- Read the next `nb' characters and
			-- make the string result available in `last_string'
			--| Chunked-Body   = *chunk
			--| last-chunk
			--| trailer
			--| CRLF
		local
			i: like index
		do
			last_string.wipe_out
			if is_trailer_reached then
				-- trailer already reached, no more data
				check input.end_of_input end
			else
				if last_chunk_size = 0 then
					read_chunk_block
				end
				from
					index := index + 1
					i := index
				until
					i - index + 1 = nb or last_chunk_size = 0
				loop
					if i + nb - 1 <= chunk_upper then
						last_string.append (last_chunk_data.substring (chunk_index (i), chunk_index (i) + nb - 1))
						i := i + nb - 1
					else
						-- Need to read new chunk
						-- first get all available data from current chunk
						if i > chunk_upper then
							last_string.append (last_chunk_data.substring (i - chunk_lower + 1, chunk_index (chunk_upper)))
							i := chunk_upper
						end
						-- then continue
						read_chunk_block
						i := i + 1
						check i = chunk_lower end
					end
				end
				if last_chunk_size = 0 then
					read_trailer_and_crlf
				end
				index := i
			end
		end

feature -- Access

	last_string: STRING_8
			-- Last string read.
			--
			-- Note: this query *might* return the same object.
			-- Therefore a clone should be used if the result
			-- is to be kept beyond the next call to this feature.
			-- However `last_string' is not shared between file objects.)

	last_character: CHARACTER_8
			-- Last item read.

	last_character_available: BOOLEAN
			-- <Precursor>
		do
			Result := not is_trailer_reached
		end

feature -- Access: chunk			

	last_chunk_size: INTEGER
			-- Last chunk size.

	last_chunk_data: STRING_8
			-- Last chunk data.

	last_trailer: detachable STRING_8
			-- Last optional trailer content if any.

	last_chunk_extension: detachable STRING_8
			-- Last optional extension if any

feature -- Chunk reading

	read_chunk
			-- Read next chunk
			-- WARNING: do not mix read_chunk calls and read_string/read_character
			-- this would mess up the traversal.
			-- note: modify last_chunk_size, last_chunk, last_extension
		do
			read_chunk_block
			if last_chunk_size = 0 then
				read_trailer_and_crlf
			end
		end

feature -- Status report

	is_open_read: BOOLEAN
			-- Can items be read from input stream?
		do
			Result := input.is_open_read
		end

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
		do
			Result := input.end_of_input or is_trailer_reached
		end

	is_trailer_reached: BOOLEAN
			-- Trailer reached?
		do
			Result := last_trailer /= Void
		end

feature {NONE} -- Access: chunk

	chunk_index (a_index: INTEGER): INTEGER
			-- Index in `last_chunk_data' for global input index `a_index'.
		do
			Result := a_index - chunk_lower + 1
		end

	index: INTEGER
			-- Global input index.

	chunk_lower: INTEGER
			-- Lower global index for `last_chunk_data'.

	chunk_upper: INTEGER
			-- Upper global index for `last_chunk_data'.

feature {NONE} -- Chunk parsing

	tmp_hex_chunk_size: STRING_8

	read_chunk_block
			-- Read next chunk
			-- WARNING: do not mix read_chunk calls and read_string/read_character
			-- this would mess up the traversal.
		local
			l_input: like input
		do
			if input.end_of_input then
			else
				chunk_lower := chunk_upper + 1
				last_chunk_data.wipe_out
				last_chunk_size := 0
				read_chunk_size
				if last_chunk_size > 0 then
					chunk_upper := chunk_upper + last_chunk_size
					read_chunk_data
					check last_chunk_data.count = last_chunk_size end

					l_input := input
					check not l_input.end_of_input end
					l_input.read_character
					check l_input.last_character = '%R' end
					check not l_input.end_of_input end
					l_input.read_character
					check l_input.last_character = '%N' end
				end
			end
		ensure
			attached last_chunk_data as l_last_chunk implies l_last_chunk.count = chunk_upper - chunk_lower + 1
		end

	read_chunk_data
		require
			last_chunk_data.is_empty
			last_chunk_size > 0
		local
			l_input: like input
		do
			debug ("wgi")
				io.error.put_string (" Read chunk data ("+ last_chunk_size.out +") %N")
			end
			l_input := input
			l_input.read_string (last_chunk_size)
			last_chunk_data := l_input.last_string
		ensure
			last_chunk_attached: last_chunk_data /= Void
			last_chunk_size_ok: last_chunk_data.count = last_chunk_size
		end

	read_chunk_size
		require
			tmp_hex_chunk_size_is_empty: tmp_hex_chunk_size.is_empty
		local
			eol : BOOLEAN
			c: CHARACTER
			hex : HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
			l_input: like input
		do
			debug ("wgi")
				io.error.put_string (" Read chunk size: ")
			end

			l_input := input
			from
				l_input.read_character
			until
				eol
			loop
				c := l_input.last_character
				debug ("wgi")
					io.error.put_string (c.out)
				end
				inspect c
				when '%R' then
					-- We are in the end of the line, we need to read the next character to start the next line.
					eol := True
					l_input.read_character
				when ';' then
					-- We are in an extension chunk data
					read_extension_chunk
				else
					tmp_hex_chunk_size.append_character (c)
					l_input.read_character
				end
			end
			if tmp_hex_chunk_size.same_string ("0") then
				last_chunk_size := 0
			else
				create hex.make
				hex.parse_string_with_type (tmp_hex_chunk_size, hex.type_integer)
				if hex.parse_successful then
					last_chunk_size := hex.parsed_integer
				else
					last_chunk_size := 0 -- ERROR ...
				end
			end
			tmp_hex_chunk_size.wipe_out

			debug ("wgi")
				io.error.put_string ("%N Chunk size = " + last_chunk_size.out + "%N")
			end
		end

	read_extension_chunk
		local
			l_input: like input
			s: STRING_8
		do
			l_input := input
			debug ("wgi")
				io.error.put_string (" Reading extension chunk ")
			end
			create s.make_empty
			from
				l_input.read_character
				s.append_character (l_input.last_character)
			until
				l_input.last_character = '%R'
			loop
				debug ("wgi")
					io.error.put_character (l_input.last_character)
				end
				l_input.read_character
				s.append_character (l_input.last_character)
			end
			s.remove_tail (1)
			if s.is_empty then
				last_chunk_extension := Void
			else
				last_chunk_extension := s
			end
		end

	read_trailer_and_crlf
			-- trailer = *(entity-header CRLF)
			-- CRLF
		local
			l_input: like input
			l_line_size: INTEGER
			s: STRING_8
		do
			create s.make_empty
			l_input := input
			if not l_input.end_of_input then
				debug ("wgi")
					io.error.put_string (" Reading trailer ")
				end
				from
					l_line_size := 1 -- Dummy value /= 0
				until
					l_line_size = 0
				loop
					l_line_size := 0
					from
						l_input.read_character
						s.append_character (l_input.last_character)
					until
						l_input.last_character = '%R'
					loop
						l_line_size := l_line_size + 1
						debug ("wgi")
							io.error.put_character (l_input.last_character)
						end
						l_input.read_character
						s.append_character (l_input.last_character)
					end
					s.remove_tail (1)
					-- read the LF
					l_input.read_character
					check l_input.last_character = '%N' end
				end
			end
			last_trailer := s
		end

feature {NONE} -- Implementation

	input: WGI_INPUT_STREAM
			-- Input Stream

;note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
