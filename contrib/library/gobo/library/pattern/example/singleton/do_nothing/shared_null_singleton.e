note

	description:

		"Shared singleton which does nothing"

	library: "Gobo Eiffel Pattern Library"
	copyright: "Copyright (c) 2003-2018, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2019-02-07 22:54:15 +0000 (Thu, 07 Feb 2019) $"
	revision: "$Revision: 102807 $"

class SHARED_NULL_SINGLETON

feature -- Access

	singleton: NULL_SINGLETON
			-- Singleton object
		do
			if attached singleton_cell.item as l_singleton then
				Result := l_singleton
			else
				create Result.make
				singleton_cell.put (Result)
			end
		ensure
			singleton_created: singleton_created
			singleton_not_void: Result /= Void
		end

feature -- Status report

	singleton_created: BOOLEAN
			-- Has singleton already been created?
		do
			Result := singleton_cell.item /= Void
		end

feature {NONE} -- Implementation

	singleton_cell: DS_CELL [detachable NULL_SINGLETON]
			-- Cell containing the singleton if already created
		once
			create Result.make (Void)
		ensure
			cell_not_void: Result /= Void
		end

end
