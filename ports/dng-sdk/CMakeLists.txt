cmake_minimum_required(VERSION 3.12)
project(dng-sdk CXX) # sets PROJECT_NAME variable

set(CMAKE_DEBUG_POSTFIX d)
set(CMAKE_CXX_STANDARD 14)

add_library(${PROJECT_NAME} STATIC ${SOURCE_FILES})
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

find_package(zlib REQUIRED) #required in dng_big_table.cpp
find_package(jpeg REQUIRED)
find_package(xmp-sdk REQUIRED)

set(SOURCE_DIR dng_sdk/source/)

set(HEADER_FILES dng_1d_function.h
dng_1d_table.h
dng_abort_sniffer.h
dng_area_task.h
dng_assertions.h
dng_auto_ptr.h
dng_bad_pixels.h
dng_big_table.h
dng_bottlenecks.h
dng_camera_profile.h
dng_classes.h
dng_color_space.h
dng_color_spec.h
dng_date_time.h
dng_deprecated_flags.h
dng_errors.h
dng_exceptions.h
dng_exif.h
dng_fast_module.h
dng_file_stream.h
dng_filter_task.h
dng_fingerprint.h
dng_flags.h
dng_gain_map.h
dng_globals.h
dng_host.h
dng_hue_sat_map.h
dng_ifd.h
dng_image.h
dng_image_writer.h
dng_info.h
dng_iptc.h
dng_jpeg_image.h
dng_jpeg_memory_source.h
dng_jpeglib.h
dng_lens_correction.h
dng_linearization_info.h
dng_local_string.h
dng_lossless_jpeg.h
dng_matrix.h
dng_memory.h
dng_memory_stream.h
dng_misc_opcodes.h
dng_mosaic_info.h
dng_mutex.h
dng_negative.h
dng_opcode_list.h
dng_opcodes.h
dng_orientation.h
dng_parse_utils.h
dng_pixel_buffer.h
dng_point.h
dng_preview.h
dng_pthread.h
dng_rational.h
dng_read_image.h
dng_rect.h
dng_ref_counted_block.h
dng_reference.h
dng_render.h
dng_resample.h
dng_safe_arithmetic.h
dng_sdk_limits.h
dng_shared.h
dng_simd_type.h
dng_simple_image.h
dng_spline.h
dng_stream.h
dng_string.h
dng_string_list.h
dng_tag_codes.h
dng_tag_types.h
dng_tag_values.h
dng_temperature.h
dng_tile_iterator.h
dng_tone_curve.h
dng_types.h
dng_uncopyable.h
dng_update_meta.h
dng_utils.h
dng_xmp.h
dng_xmp_sdk.h
dng_xy_coord.h)

set(SOURCE_FILES dng_1d_function.cpp
dng_1d_table.cpp
dng_abort_sniffer.cpp
dng_area_task.cpp
dng_bad_pixels.cpp
dng_big_table.cpp
dng_bottlenecks.cpp
dng_camera_profile.cpp
dng_color_space.cpp
dng_color_spec.cpp
dng_date_time.cpp
dng_exceptions.cpp
dng_exif.cpp
dng_file_stream.cpp
dng_filter_task.cpp
dng_fingerprint.cpp
dng_gain_map.cpp
dng_globals.cpp
dng_host.cpp
dng_hue_sat_map.cpp
dng_ifd.cpp
dng_image.cpp
dng_image_writer.cpp
dng_info.cpp
dng_iptc.cpp
dng_jpeg_image.cpp
dng_jpeg_memory_source.cpp
dng_lens_correction.cpp
dng_linearization_info.cpp
dng_local_string.cpp
dng_lossless_jpeg.cpp
dng_lossless_jpeg_shared.cpp
dng_matrix.cpp
dng_memory.cpp
dng_memory_stream.cpp
dng_misc_opcodes.cpp
dng_mosaic_info.cpp
dng_mutex.cpp
dng_negative.cpp
dng_opcode_list.cpp
dng_opcodes.cpp
dng_orientation.cpp
dng_parse_utils.cpp
dng_pixel_buffer.cpp
dng_point.cpp
dng_preview.cpp
dng_pthread.cpp
dng_rational.cpp
dng_read_image.cpp
dng_rect.cpp
dng_ref_counted_block.cpp
dng_reference.cpp
dng_render.cpp
dng_resample.cpp
dng_safe_arithmetic.cpp
dng_shared.cpp
dng_simple_image.cpp
dng_spline.cpp
dng_stream.cpp
dng_string.cpp
dng_string_list.cpp
dng_tag_types.cpp
dng_temperature.cpp
dng_tile_iterator.cpp
dng_tone_curve.cpp
dng_update_meta.cpp
dng_utils.cpp
dng_validate.cpp
dng_xmp.cpp
dng_xmp_sdk.cpp
dng_xy_coord.cpp)

list(TRANSFORM HEADER_FILES PREPEND ${SOURCE_DIR})
list(TRANSFORM SOURCE_FILES PREPEND ${SOURCE_DIR})

source_group("Headers" FILES ${HEADER_FILES} )
source_group("Sources" FILES ${SOURCE_FILES} )

if (WIN32)
	target_compile_definitions(dng-sdk PUBLIC qWinOS=1)
endif()
if (APPLE)
	target_compile_definitions(dng-sdk PUBLIC qMacOS=1)
endif()

target_include_directories(dng-sdk PRIVATE ${ZLIB_INCLUDE_DIR})

if (JPEG_INCLUDE_DIR)
	target_include_directories(dng-sdk PUBLIC ${JPEG_INCLUDE_DIR})
	target_compile_definitions(dng-sdk PUBLIC qDNGUseLibJPEG=1)
endif()

if (MSVC)
	target_compile_definitions(dng-sdk PUBLIC _CRT_SECURE_NO_WARNINGS)
endif()

#use xmp and jpeg unconditionally for now
target_compile_definitions(dng-sdk PUBLIC qDNGUseXMP=1)
target_compile_definitions(dng-sdk PUBLIC qDNGUseLibJPEG=1)

#set qDNGDebug in debug builds?

install(FILES ${HEADER_FILES}
    DESTINATION include
)

install(TARGETS dng-sdk
	RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)
