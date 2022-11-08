#header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cos-public/yopt
    REF 0.9
    SHA512 58c83636032f7ff55ca7b63b67b85570e844c110d6c11ffba5f35febabac2f906001f9f54a63ec89a97bea9be973baf40616b8254bbd4b2b228b0a51989b3f19
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
