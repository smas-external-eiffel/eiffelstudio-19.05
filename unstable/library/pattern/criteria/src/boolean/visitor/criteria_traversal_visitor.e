note
	description: "Summary description for {CRITERIA_TRAVERSAL_VISITOR}."
	author: ""
	date: "$Date: 2013-12-18 21:33:00 +0000 (Wed, 18 Dec 2013) $"
	revision: "$Revision: 93761 $"

class
	CRITERIA_TRAVERSAL_VISITOR [G]

inherit
	CRITERIA_NULL_VISITOR [G]
		redefine
			visit_and, visit_or, visit_not
		end

feature -- Visitor

	visit_and (obj: CRITERIA_AND [G])
		do
			obj.criteria.accept (Current)
			obj.other_criteria.accept (Current)
		end

	visit_or (obj: CRITERIA_OR [G])
		do
			obj.criteria.accept (Current)
			obj.other_criteria.accept (Current)
		end

	visit_not (obj: CRITERIA_NOT [G])
		do
			obj.criteria.accept (Current)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
