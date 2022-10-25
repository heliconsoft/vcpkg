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

# vcpkg_cmake_install(), vcpkg_install_msbuild() do not work because XMP's custom CMakeLists do not provide install target

# ${SOURCE_PATH}/XMPToolkitSDK.sln - points to a clean source tree
vcpkg_build_msbuild(
    PROJECT_PATH XMPToolkitSDK.sln
    # TARGET ALL_BUILD
    USE_VCPKG_INTEGRATION
)

vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/public/include/" DESTINATION "${CURRENT_PACKAGES_DIR}/include/xmp")
file(INSTALL "${SOURCE_PATH}/public/libraries/windows_x64/Debug/" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
file(INSTALL "${SOURCE_PATH}/public/libraries/windows_x64/Release/" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")