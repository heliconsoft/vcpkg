include(CMakeFindDependencyMacro)

get_filename_component(ROOT "${CMAKE_CURRENT_LIST_FILE}" PATH)
# ../.. equivalent
get_filename_component(ROOT "${ROOT}" PATH)
get_filename_component(ROOT "${ROOT}" PATH)

find_dependency(expat CONFIG)

add_library(xmp-sdk::xmp-sdk-core STATIC IMPORTED)
set_target_properties(xmp-sdk::xmp-sdk-core PROPERTIES
    IMPORTED_LOCATION_DEBUG "${ROOT}/debug/lib/XMPCoreStatic.lib"
    IMPORTED_LOCATION "${ROOT}/lib/XMPCoreStatic.lib"
	IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
	INTERFACE_INCLUDE_DIRECTORIES "${ROOT}/include/xmp"
)
target_link_libraries(xmp-sdk::xmp-sdk-core INTERFACE expat::expat)

add_library(xmp-sdk::xmp-sdk-files STATIC IMPORTED)
set_target_properties(xmp-sdk::xmp-sdk-files PROPERTIES
    IMPORTED_LOCATION_DEBUG "${ROOT}/debug/lib/XMPFilesStatic.lib"
    IMPORTED_LOCATION "${ROOT}/lib/XMPFilesStatic.lib"
    IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
    INTERFACE_INCLUDE_DIRECTORIES "${ROOT}/include/xmp"
)
target_link_libraries(xmp-sdk::xmp-sdk-files INTERFACE expat::expat)

add_library(xmp-sdk::xmp-sdk INTERFACE IMPORTED)
#umbrella virtual target to link both core and files libraries
target_link_libraries(xmp-sdk::xmp-sdk INTERFACE xmp-sdk::xmp-sdk-core xmp-sdk::xmp-sdk-files)

#When target dependencies are specified using target_link_libraries(), CMake will read this property from all target dependencies to determine the build properties of the consumer. 
target_compile_definitions(xmp-sdk::xmp-sdk INTERFACE WIN_ENV)

set(xmp-sdk_FOUND 1)