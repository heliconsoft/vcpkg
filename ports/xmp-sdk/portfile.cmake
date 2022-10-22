vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO adobe/XMP-Toolkit-SDK
    REF v2022.06
    SHA512 c151e9de1c292f99eb8eeee83edbaf47d762afd5cf5c564cebc2201d852db93d2dbde111acdf597df2858bb98500ad827da902350d9267d9d41092315edfba20
    HEAD_REF master
    PATCHES 
        fix-third-party.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" XMP_BUILD_STATIC)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" XMP_BUILD_SHARED)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/build"
    WINDOWS_USE_MSBUILD
    OPTIONS
    	-DXMP_BUILD_WARNING_AS_ERROR=On
    	-DXMP_BUILD_STATIC=${XMP_BUILD_STATIC}
)

# vcpkg_cmake_install()
vcpkg_install_msbuild(
    SOURCE_PATH ${SOURCE_PATH}
    PROJECT_SUBPATH XMPToolkitSDK.sln
)
    # INCLUDES_SUBPATH public/include
    # LICENSE_SUBPATH COPYING
    #PLATFORM "x64"
    #RELEASE_CONFIGURATION ${LIBFABRIC_RELEASE_CONFIGURATION}
    #DEBUG_CONFIGURATION ${LIBFABRIC_RELEASE_CONFIGURATION}
    # USE_VCPKG_INTEGRATION
    #ALLOW_ROOT_INCLUDES
    #OPTIONS
      #/p:SolutionDir=${SOURCE_PATH}
      #/p:AdditionalIncludeDirectories="${CURRENT_INSTALLED_DIR}/include"
# )

#vcpkg_copy_pdbs()

#vcpkg_cmake_config_fixup(CONFIG_PATH "lib/share/${PORT}")
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/share" "${CURRENT_PACKAGES_DIR}/lib/share")