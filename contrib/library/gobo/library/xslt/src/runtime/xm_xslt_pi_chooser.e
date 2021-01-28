note

	description:

		"Objects that select from alternate xml-stylsheet PIs"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class	XM_XSLT_PI_CHOOSER

feature -- Access

	selected_index (a_list: DS_LIST [STRING]): INTEGER
			-- Index of chosen xml-stylesheet from within `a_list';
			-- The first entry in the list is the preferred stylesheet.
		require
			multiple_choices: a_list /= Void and then a_list.count > 1
		deferred
		ensure
			valid_choice: Result >= 1 and then Result <= a_list.count
		end

end
