vcpkg_download_distfile(ARCHIVE
	# URLS https://www.adobe.com/go/dng_sdk
	URLS https://download.adobe.com/pub/adobe/dng/dng_sdk_1_6.zip #direct link
	FILENAME "dng-sdk-1.6.zip"
	SHA512 d7754f7e65ee90ea03fda4b20ac15cfe183d4d82b7d7667054a6a319f35f18ca6223e37191e8e08c8243ab09e5ee87222e6055ee7c57787b0d04a74c1b31fca4
)

vcpkg_extract_source_archive(
	SOURCE_PATH
	ARCHIVE "${ARCHIVE}"
)

file(REMOVE_RECURSE "${SOURCE_PATH}/libjpeg/" "${SOURCE_PATH}/xmp/")
file(REMOVE "${SOURCE_PATH}/JPEG_ReadMe.txt" "${SOURCE_PATH}/XMP_ReadMe.txt")

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

#TODO: check and pass optional features
#if("jpeg" IN_LIST FEATURES)
#if("xmp" IN_LIST FEATURES)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
