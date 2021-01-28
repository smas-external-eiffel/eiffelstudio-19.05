note
	description: "Summary description for {WSF_ROUTER_ITERATOR}."
	author: ""
	date: "$Date: 2013-05-20 13:34:55 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92549 $"

class
	WSF_ROUTER_ITERATOR

inherit
	WSF_ROUTER_VISITOR

feature -- Visitor

	process_router (r: WSF_ROUTER)
		do
			across
				r as c
			loop
				process_item (c.item)
			end
		end

	process_item (i: WSF_ROUTER_ITEM)
		do
			process_mapping (i.mapping)
		end

	process_mapping (m: WSF_ROUTER_MAPPING)
		do
			process_handler (m.handler)
		end

	process_handler (h: WSF_HANDLER)
		do
			if attached {WSF_ROUTING_HANDLER} h as r then
				process_router (r.router)
			end
		end

end
