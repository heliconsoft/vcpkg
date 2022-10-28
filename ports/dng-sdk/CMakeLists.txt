cmake_minimum_required(VERSION 3.24)
project(dng-sdk VERSION 1.6 LANGUAGES CXX) # sets PROJECT_NAME variable

# set(CMAKE_DEBUG_POSTFIX d)

option(DNG_USE_XMP_EXTERNAL "Use external XMP SDK toolkit" ON)
option(DNG_USE_JPEG "Use JPEG" ON)

message(STATUS "Build type: " ${CMAKE_BUILD_TYPE})

add_library(${PROJECT_NAME})
# add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

find_package(ZLIB REQUIRED) #required in dng_big_table.cpp
target_include_directories(${PROJECT_NAME} PRIVATE ${ZLIB_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} PRIVATE ${ZLIB_LIBRARY})

if (DNG_USE_JPEG)
	find_package(JPEG REQUIRED)
	target_include_directories(${PROJECT_NAME} PRIVATE ${JPEG_INCLUDE_DIR})
	target_link_libraries(${PROJECT_NAME} PRIVATE ${JPEG_LIBRARY})
	target_compile_definitions(${PROJECT_NAME} PUBLIC qDNGUseLibJPEG=1)
endif()

if (DNG_USE_XMP_EXTERNAL)
	find_package(xmp-sdk CONFIG REQUIRED)
	target_link_libraries(${PROJECT_NAME} PRIVATE xmp-sdk::xmp-sdk)
	target_compile_definitions(${PROJECT_NAME} PUBLIC qDNGUseXMP=1 qDNGXMPDocOps=0) #official XMP SDK toolkit doesn't have DocOps functionality as of June 2022
endif()

target_sources(${PROJECT_NAME} PRIVATE
	dng_sdk/source/dng_1d_function.cpp dng_sdk/source/dng_1d_table.cpp dng_sdk/source/dng_abort_sniffer.cpp dng_sdk/source/dng_area_task.cpp
	dng_sdk/source/dng_bad_pixels.cpp dng_sdk/source/dng_big_table.cpp dng_sdk/source/dng_bottlenecks.cpp dng_sdk/source/dng_camera_profile.cpp
	dng_sdk/source/dng_color_space.cpp dng_sdk/source/dng_color_spec.cpp dng_sdk/source/dng_date_time.cpp dng_sdk/source/dng_exceptions.cpp
	dng_sdk/source/dng_exif.cpp dng_sdk/source/dng_file_stream.cpp dng_sdk/source/dng_filter_task.cpp dng_sdk/source/dng_fingerprint.cpp
	dng_sdk/source/dng_gain_map.cpp dng_sdk/source/dng_globals.cpp dng_sdk/source/dng_host.cpp dng_sdk/source/dng_hue_sat_map.cpp
	dng_sdk/source/dng_ifd.cpp dng_sdk/source/dng_image.cpp dng_sdk/source/dng_image_writer.cpp dng_sdk/source/dng_info.cpp
	dng_sdk/source/dng_iptc.cpp dng_sdk/source/dng_jpeg_image.cpp dng_sdk/source/dng_jpeg_memory_source.cpp dng_sdk/source/dng_lens_correction.cpp
	dng_sdk/source/dng_linearization_info.cpp dng_sdk/source/dng_local_string.cpp dng_sdk/source/dng_lossless_jpeg.cpp dng_sdk/source/dng_lossless_jpeg_shared.cpp
	dng_sdk/source/dng_matrix.cpp dng_sdk/source/dng_memory.cpp dng_sdk/source/dng_memory_stream.cpp dng_sdk/source/dng_misc_opcodes.cpp
	dng_sdk/source/dng_mosaic_info.cpp dng_sdk/source/dng_mutex.cpp dng_sdk/source/dng_negative.cpp dng_sdk/source/dng_opcode_list.cpp
	dng_sdk/source/dng_opcodes.cpp dng_sdk/source/dng_orientation.cpp dng_sdk/source/dng_parse_utils.cpp dng_sdk/source/dng_pixel_buffer.cpp
	dng_sdk/source/dng_point.cpp dng_sdk/source/dng_preview.cpp dng_sdk/source/dng_pthread.cpp dng_sdk/source/dng_rational.cpp
	dng_sdk/source/dng_read_image.cpp dng_sdk/source/dng_rect.cpp dng_sdk/source/dng_ref_counted_block.cpp dng_sdk/source/dng_reference.cpp
	dng_sdk/source/dng_render.cpp dng_sdk/source/dng_resample.cpp dng_sdk/source/dng_safe_arithmetic.cpp dng_sdk/source/dng_shared.cpp
	dng_sdk/source/dng_simple_image.cpp dng_sdk/source/dng_spline.cpp dng_sdk/source/dng_stream.cpp dng_sdk/source/dng_string.cpp
	dng_sdk/source/dng_string_list.cpp dng_sdk/source/dng_tag_types.cpp dng_sdk/source/dng_temperature.cpp dng_sdk/source/dng_tile_iterator.cpp
	dng_sdk/source/dng_tone_curve.cpp dng_sdk/source/dng_update_meta.cpp dng_sdk/source/dng_utils.cpp dng_sdk/source/dng_validate.cpp
	dng_sdk/source/dng_xmp.cpp dng_sdk/source/dng_xmp_sdk.cpp dng_sdk/source/dng_xy_coord.cpp
)

set(HEADER_FILES
	dng_sdk/source/dng_1d_function.h dng_sdk/source/dng_1d_table.h dng_sdk/source/dng_abort_sniffer.h dng_sdk/source/dng_area_task.h
	dng_sdk/source/dng_assertions.h dng_sdk/source/dng_auto_ptr.h dng_sdk/source/dng_bad_pixels.h dng_sdk/source/dng_big_table.h
	dng_sdk/source/dng_bottlenecks.h dng_sdk/source/dng_camera_profile.h dng_sdk/source/dng_classes.h dng_sdk/source/dng_color_space.h
	dng_sdk/source/dng_color_spec.h dng_sdk/source/dng_date_time.h dng_sdk/source/dng_deprecated_flags.h dng_sdk/source/dng_errors.h
	dng_sdk/source/dng_exceptions.h dng_sdk/source/dng_exif.h dng_sdk/source/dng_fast_module.h dng_sdk/source/dng_file_stream.h
	dng_sdk/source/dng_filter_task.h dng_sdk/source/dng_fingerprint.h dng_sdk/source/dng_flags.h dng_sdk/source/dng_gain_map.h
	dng_sdk/source/dng_globals.h dng_sdk/source/dng_host.h dng_sdk/source/dng_hue_sat_map.h dng_sdk/source/dng_ifd.h dng_sdk/source/dng_image.h
	dng_sdk/source/dng_image_writer.h dng_sdk/source/dng_info.h dng_sdk/source/dng_iptc.h dng_sdk/source/dng_jpeg_image.h
	dng_sdk/source/dng_jpeg_memory_source.h dng_sdk/source/dng_jpeglib.h dng_sdk/source/dng_lens_correction.h dng_sdk/source/dng_linearization_info.h
	dng_sdk/source/dng_local_string.h dng_sdk/source/dng_lossless_jpeg.h dng_sdk/source/dng_matrix.h dng_sdk/source/dng_memory.h
	dng_sdk/source/dng_memory_stream.h dng_sdk/source/dng_misc_opcodes.h dng_sdk/source/dng_mosaic_info.h dng_sdk/source/dng_mutex.h
	dng_sdk/source/dng_negative.h dng_sdk/source/dng_opcode_list.h dng_sdk/source/dng_opcodes.h dng_sdk/source/dng_orientation.h
	dng_sdk/source/dng_parse_utils.h dng_sdk/source/dng_pixel_buffer.h dng_sdk/source/dng_point.h dng_sdk/source/dng_preview.h
	dng_sdk/source/dng_pthread.h dng_sdk/source/dng_rational.h dng_sdk/source/dng_read_image.h dng_sdk/source/dng_rect.h
	dng_sdk/source/dng_ref_counted_block.h dng_sdk/source/dng_reference.h dng_sdk/source/dng_render.h dng_sdk/source/dng_resample.h
	dng_sdk/source/dng_safe_arithmetic.h dng_sdk/source/dng_sdk_limits.h dng_sdk/source/dng_shared.h dng_sdk/source/dng_simd_type.h
	dng_sdk/source/dng_simple_image.h dng_sdk/source/dng_spline.h dng_sdk/source/dng_stream.h dng_sdk/source/dng_string.h
	dng_sdk/source/dng_string_list.h dng_sdk/source/dng_tag_codes.h dng_sdk/source/dng_tag_types.h dng_sdk/source/dng_tag_values.h
	dng_sdk/source/dng_temperature.h dng_sdk/source/dng_tile_iterator.h dng_sdk/source/dng_tone_curve.h dng_sdk/source/dng_types.h
	dng_sdk/source/dng_uncopyable.h dng_sdk/source/dng_update_meta.h dng_sdk/source/dng_utils.h dng_sdk/source/dng_xmp.h dng_sdk/source/dng_xmp_sdk.h
	dng_sdk/source/dng_xy_coord.h
)


if (WIN32)
	target_compile_definitions(${PROJECT_NAME} PUBLIC qWinOS=1)
endif()
if (APPLE)
	target_compile_definitions(${PROJECT_NAME} PUBLIC qMacOS=1)
endif()

if (MSVC)
	target_compile_definitions(${PROJECT_NAME} PUBLIC _CRT_SECURE_NO_WARNINGS)
endif()

#set qDNGDebug in debug builds?

install(TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}-targets
	RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

foreach (HEADER ${HEADER_FILES})
	get_filename_component(HEADER_DIR ${HEADER} DIRECTORY)
	install(
		FILES ${HEADER}
		CONFIGURATIONS Release
		DESTINATION include/dng-sdk
	)
endforeach()

set(INSTALL_CONFIG_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/dng-sdk")

install(
    EXPORT ${PROJECT_NAME}-targets
    FILE ${PROJECT_NAME}-targets.cmake
    DESTINATION "${INSTALL_CONFIG_DIR}"
)

# include(CMakePackageConfigHelpers)
# configure_package_config_file(
# )
# include(CPack)
