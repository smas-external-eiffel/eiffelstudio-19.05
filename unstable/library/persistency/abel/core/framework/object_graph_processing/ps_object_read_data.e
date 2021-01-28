note
	description: "Read-specific object data."
	author: "Roman Schmocker"
	date: "$Date: 2014-01-03 00:45:59 +0000 (Fri, 03 Jan 2014) $"
	revision: "$Revision: 93876 $"

class
	PS_OBJECT_READ_DATA

inherit
	PS_OBJECT_DATA

create
	make_with_primary_key

feature {NONE} -- Initialization

	make_with_primary_key (idx: INTEGER; a_primary_key: INTEGER; a_type: PS_TYPE_METADATA; a_level: INTEGER)
			-- Initialization for `Current'
		do
			index := idx
			type := a_type
			level := a_level
			primary_key := a_primary_key
			set_object (Current)
			reflector := Current
		end

feature -- Recycling

	reset (idx: INTEGER; a_primary_key: INTEGER; a_type: PS_TYPE_METADATA; a_level: INTEGER)
			-- Reset `Current'
		do
			index := idx
			type := a_type
			level := a_level
			primary_key := a_primary_key
			set_object (Current)
			reflector := Current

			backend_representation := Void
			identifier := 0
			internal_handler := Void
			is_ignored := False
			is_persistent := False
			last_referer := 0
			referer_count := 0
		end
end
