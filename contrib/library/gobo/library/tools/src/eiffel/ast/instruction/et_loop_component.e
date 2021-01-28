note

	description:

		"Eiffel loop components (either loop instructions or across instructions)"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2012-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class ET_LOOP_COMPONENT

inherit

	ET_AST_NODE

feature -- Access

	from_compound: detachable ET_COMPOUND
			-- From compound
		deferred
		end

	invariant_part: detachable ET_LOOP_INVARIANTS
			-- Invariant part
		deferred
		end

	variant_part: detachable ET_VARIANT
			-- Variant part
		deferred
		end

	until_conditional: detachable ET_CONDITIONAL
			-- Until conditional
		deferred
		end

	loop_compound: detachable ET_COMPOUND
			-- Loop compound
		deferred
		end

end
