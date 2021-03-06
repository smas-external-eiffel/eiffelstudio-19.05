note
	Description: "Objects that enable to create a class related%
			%to a specific database table from a template and%
			%a class description (class DB_REPOSITORY)."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	Date: "$Date: 2014-01-15 18:27:37 +0000 (Wed, 15 Jan 2014) $"
	Revision: "$Revision: 94004 $"
	Product: EiffelStore
	Database: All_Bases

class
	DB_ACCESS_CLASS_GENERATOR

inherit
	DB_CLASS_GENERATOR

feature -- Status report

	description_set: BOOLEAN
			-- Are table names set?
		do
			Result := table_name_list /= Void
		end

feature -- Basic operations

	set_table_names (table_names: ARRAYED_LIST [DB_REPOSITORY])
			-- Set table names to map template to the database tables.
		require
			not_void: table_names /= Void
		do
			table_name_list := table_names
		ensure
			table_name_list_set: description_set
		end

feature {NONE} -- Implementation

	append_block (a_result_block, template_block: STRING; column_number: INTEGER)
			-- Replace tags in `attribute_block' with values of attribute in
			-- `column' (which is at `column_number').
			-- Append result to `a_result_block'.
		local
			mapped_item: STRING
			table_name: STRING
		do
			if attached table_name_list as l_table_name_list then
				table_name := l_table_name_list.i_th (column_number).repository_name.as_lower
				mapped_item := template_block.twin
				mapped_item.replace_substring_all (tags.Lower_class_name, table_name)
				to_initcap (table_name)
				mapped_item.replace_substring_all (tags.Initcap_class_name, table_name)
				table_name.to_upper
				mapped_item.replace_substring_all (tags.Upper_class_name, table_name)
				mapped_item.replace_substring_all (tags.Iterator, column_number.out)
				a_result_block.append (mapped_item)
			end
		end

	description_count: INTEGER
			-- Count of database entities (table or attribute) in description.
		do
			if attached table_name_list as l_table_name_list then
				Result := l_table_name_list.count
			end
		end

	table_name_list: detachable ARRAYED_LIST [DB_REPOSITORY];
			-- Database table name list.

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DB_ACCESS_CLASS_GENERATOR


