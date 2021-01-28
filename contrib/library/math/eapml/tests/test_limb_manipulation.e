note
	description: "Summary description for {TEST_LIMB_MANIPULATION}."
	author: ""
	date: "$Date: 2011-11-11 17:13:16 +0000 (Fri, 11 Nov 2011) $"
	revision: "$Revision: 87787 $"

class
	TEST_LIMB_MANIPULATION

inherit
	EQA_TEST_SET
	LIMB_MANIPULATION
		undefine
			default_create
		end

feature
	test_modlimb_inverse_1
		local
			inverse: NATURAL_32
		do
			inverse := modlimb_invert (0x7fffffff)
			assert ("test limb inverse 1", inverse = 0x7fffffff)
		end

	test_extract_limb_left_1
		local
			one: NATURAL_32
			two: NATURAL_32
			val: NATURAL_32
		do
			one := 0x13579bdf
			two := 0x2468ace0
			val := extract_limb (8, one, two)
			assert ("test exctact limb left 1", val = 0x579bdf24)
		end
end
