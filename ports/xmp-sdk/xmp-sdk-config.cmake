add_library(xmp-sdk::xmp-sdk STATIC IMPORTED)
set_target_properties(xmp-sdk::xmp-sdk PROPERTIES
	IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
	IMPORTED_LOCATION_RELEASE "/lib/XMPCoreStatic.lib"
	IMPORTED_LOCATION_DEBUG "/debug/lib/XMPCoreStatic.lib"
	INTERFACE_INCLUDE_DIRECTORIES "/include/xmp"
)

set(xmp-sdk_FOUND 1)