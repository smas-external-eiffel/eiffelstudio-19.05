note
	description: "[
		Externals for interacting with SQLite API (void *).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-10-08 00:26:41 +0000 (Thu, 08 Oct 2009) $"
	revision: "$Revision: 81049 $"

class
	SQLITE_API_EXTERNALS

feature -- Initialization

	sqlite3_initialize (a_api: SQLITE_API): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_initialize
		end

feature -- Clean up

	sqlite3_shutdown (a_api: SQLITE_API): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_shutdown
		end

feature -- Access

	sqlite3_threadsafe (a_api: SQLITE_API): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_threadsafe
		end

	sqlite3_libversion (a_api: SQLITE_API): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_libversion
		end

	sqlite3_libversion_number (a_api: SQLITE_API): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_libversion_number
		end

feature {NONE} -- Status report

	sqlite3_complete (a_api: SQLITE_API; a_sql: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_sql_is_null: a_sql /= default_pointer
		do
			Result := {SQLITE_EXTERNALS}.c_sqlite3_complete (a_sql)
		end

feature {NONE} -- External: Experimental

	sqlite3_config (a_api: SQLITE_API; a_config: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := {SQLITE_EXPERIMENTAL_EXTERNALS}.c_sqlite3_config (a_config)
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
