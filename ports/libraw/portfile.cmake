vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO LibRaw/LibRaw
    REF 0.20.2
    SHA512 09af68f95249da37357877c6013db5082edd9fd40d0526c42bba22f16a19f41d8c008cf16823f2ed9a90c2dee9c8cd2968c91a9550bf24b3b2c089918ae56250
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH LIBRAW_CMAKE_SOURCE_PATH
    REPO LibRaw/LibRaw-cmake
    REF 6e26c9e73677dc04f9eb236a97c6a4dc225ba7e8
    SHA512 8ce13d37c2ace2fbc57f571052a5a5a847b707b3de1b3b9e0c1a46afaca86cabd42ee275600eeadc3127bc2a0d0a4f224caed0b07feffdafea32ad0f42e50379
    HEAD_REF master
    PATCHES
        CMakeLists.patch
)

file(COPY "${LIBRAW_CMAKE_SOURCE_PATH}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${LIBRAW_CMAKE_SOURCE_PATH}/cmake" DESTINATION "${SOURCE_PATH}")


vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        openmp ENABLE_OPENMP
        lcms ENABLE_LCMS
        jasper ENABLE_JASPER
        rawspeed ENABLE_RAWSPEED
        x3ftools ENABLE_X3FTOOLS
        6by9rpi ENABLE_6BY9RPI
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DENABLE_EXAMPLES=OFF
        -DENABLE_DCRAW_DEBUG=OFF
        -DLIBRAW_INSTALL=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets()
vcpkg_fixup_pkgconfig()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/libraw/libraw_types.h"
        "#ifdef LIBRAW_NODLL" "#if 1"
    )
else()
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/libraw/libraw_types.h"
        "#ifdef LIBRAW_NODLL" "#if 0"
    )
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/COPYRIGHT" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

