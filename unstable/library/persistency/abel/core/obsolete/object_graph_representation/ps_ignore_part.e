note
	description: "An object graph part that can be completely ignored, including the references pointing to it."
	author: "Roman Schmocker"
	date: "$Date: 2013-11-13 22:09:48 +0000 (Wed, 13 Nov 2013) $"
	revision: "$Revision: 93357 $"

class
	PS_IGNORE_PART

inherit

	PS_SIMPLE_PART

create
	default_make

feature {PS_ABEL_EXPORT} -- Status report

	is_representing_object: BOOLEAN = False
			-- Is `Current' representing an existing object?

end
