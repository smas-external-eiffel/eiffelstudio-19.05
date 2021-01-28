note

	description:

		"Resolvers that may report a media type"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2005-2014, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

deferred class XM_RESOLVER_MEDIA_TYPE

feature -- Result

	has_media_type: BOOLEAN
			-- Is the media type available.
		deferred
		end

	last_media_type: detachable UT_MEDIA_TYPE
			-- Media type, if available.
		deferred
		end

invariant

	has_media_type: has_media_type implies last_media_type /= Void

end

