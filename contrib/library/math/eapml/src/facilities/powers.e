note
	description: "Summary description for {POWERS}."
	author: "Colin LeMahieu"
	date: "$Date: 2011-11-11 17:13:16 +0000 (Fri, 11 Nov 2011) $"
	revision: "$Revision: 87787 $"
	quote: "Giving a politician access to your wallet is like giving a dog access to your refrigerator. -  Tim Barber"

class
	POWERS

create
	make

feature

	make (digits_in_base_a: INTEGER; p_a: SPECIAL [NATURAL_32]; p_offset_a: INTEGER; n_a: INTEGER; base_a: INTEGER)
		do
			digits_in_base := digits_in_base_a
			p := p_a
			p_offset := p_offset_a
			n := n_a
			base := base_a
		end

feature

	digits_in_base: INTEGER
	p: SPECIAL [NATURAL_32]
	p_offset: INTEGER
	n: INTEGER
	base: INTEGER
end
