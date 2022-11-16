#header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cos-public/yopt
    REF v0.9
    SHA512 a7470281b9a87e4537cef43b80a4a85dbf3e8f00c719c8f5924ad379c35493167b8c029c87ab166fb3831b699b83a8ee2f04bb865b3e32747c7bf31c556a0e8d
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH share/${PORT}/cmake)
vcpkg_fixup_pkgconfig()

# Put the licence file where vcpkg expects it
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
