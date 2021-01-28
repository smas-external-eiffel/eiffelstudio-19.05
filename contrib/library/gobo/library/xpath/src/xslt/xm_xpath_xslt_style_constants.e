note

	description:

		"Constants for element nodes in an XSLT stylesheet"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2011, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2016-05-06 19:15:38 +0000 (Fri, 06 May 2016) $"
	revision: "$Revision: 98678 $"

class XM_XPATH_XSLT_STYLE_CONSTANTS

feature -- Attribute names

	Default_collation_attribute: STRING = "default-collation"
	Exclude_result_prefixes_attribute: STRING = "exclude-result-prefixes"
	Extension_element_prefixes_attribute: STRING = "extension-element-prefixes"
	Inherit_namespaces_attribute: STRING = "inherit-namespaces"
	Use_when_attribute: STRING = "use-when"
	Version_attribute: STRING = "version"
	Xpath_default_namespace_attribute: STRING = "xpath-default-namespace"

end

