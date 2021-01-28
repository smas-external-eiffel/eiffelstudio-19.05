note

	description:

		"Xace class options"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class ET_XACE_CLASS_OPTIONS

create

	make

feature {NONE} -- Initialization

	make (a_name: like class_name; an_options: like options)
			-- Create a new class options for class `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
			an_options_not_void: an_options /= Void
		do
			class_name := a_name
			options := an_options
		ensure
			class_name_set: class_name = a_name
			options_set: options = an_options
		end

feature -- Access

	class_name: STRING
			-- Class name

	options: ET_XACE_OPTIONS
			-- Class options

	feature_options: detachable DS_LINKED_LIST [ET_XACE_FEATURE_OPTIONS]
			-- Feature options

feature -- Element change

	put_feature_option (an_option: ET_XACE_FEATURE_OPTIONS)
			-- Add `an_option' to `feature_options'.
		require
			an_option_not_void: an_option /= Void
		local
			l_feature_options: like feature_options
		do
			l_feature_options := feature_options
			if l_feature_options = Void then
				create l_feature_options.make
				feature_options := l_feature_options
			end
			l_feature_options.put_last (an_option)
		end

invariant

	class_name_not_void: class_name /= Void
	class_name_not_empty: class_name.count > 0
	options_not_void: options /= Void
	no_void_feature_option: attached feature_options as l_feature_options implies not l_feature_options.has_void

end
