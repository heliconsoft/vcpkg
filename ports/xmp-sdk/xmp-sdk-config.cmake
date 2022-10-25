get_filename_component(ROOT "${CMAKE_CURRENT_LIST_FILE}" PATH)
# ../.. equivalent
get_filename_component(ROOT "${ROOT}" PATH)
get_filename_component(ROOT "${ROOT}" PATH)

add_library(xmp-sdk::xmp-sdk STATIC IMPORTED)
set_target_properties(xmp-sdk::xmp-sdk PROPERTIES
	IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
	IMPORTED_LOCATION_RELEASE "${ROOT}/lib/XMPCoreStatic.lib"
	IMPORTED_LOCATION_DEBUG "${ROOT}/debug/lib/XMPCoreStatic.lib"
	INTERFACE_INCLUDE_DIRECTORIES "${ROOT}/include/xmp"
)

#When target dependencies are specified using target_link_libraries(), CMake will read this property from all target dependencies to determine the build properties of the consumer. 
target_compile_definitions(xmp-sdk::xmp-sdk INTERFACE WIN_ENV)

set(xmp-sdk_FOUND 1)