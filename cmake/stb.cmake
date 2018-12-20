project (stb C)

FILE(WRITE "${STB_ROOT}/stb.c" "#include \"stb_image.h\"\r\n#include \"stb_image_resize.h\"\r\n#include \"stb_image_write.h\"\r\n")
option (STB_IMPLEMENTATION "stb base module" on)
option (STB_IMAGE_IMPLEMENTATION "stb image module" on)
option (STB_IMAGE_WRITE_IMPLEMENTATION "stb image write module" on)
option (STB_IMAGE_RESIZE_IMPLEMENTATION "stb image resize module" on)

set(STB_DEFINES -DSTB_IMAGE_STATIC)
if (STB_IMAGE_STATIC)
    list(APPEND STB_DEFINES -DSTB_IMAGE_STATIC)
endif()
if (STB_IMAGE_IMPLEMENTATION)
    list(APPEND STB_DEFINES -DSTB_IMAGE_IMPLEMENTATION)
endif()
if (STB_IMAGE_WRITE_IMPLEMENTATION)
    list(APPEND STB_DEFINES -DSTB_IMAGE_WRITE_IMPLEMENTATION)
endif()
if (STB_IMAGE_RESIZE_IMPLEMENTATION)
    list(APPEND STB_DEFINES -DSTB_IMAGE_RESIZE_IMPLEMENTATION)
endif()


IF (MSVC)
    option (STB_STATIC_RUNTIME "static runtime library" on)
	IF (STB_STATIC_RUNTIME)
		# CMAKE_CONFIGURATION_TYPES is empty on non-IDE generators (Ninja, NMake)
		# and that's why we also use CMAKE_BUILD_TYPE to cover for those generators.
		# For IDE generators, CMAKE_BUILD_TYPE is usually empty
		FOREACH (config_type ${CMAKE_CONFIGURATION_TYPES} ${CMAKE_BUILD_TYPE})
			STRING (TOUPPER ${config_type} upper_config_type)
			SET (flag_var "CMAKE_C_FLAGS_${upper_config_type}")
			IF (${flag_var} MATCHES "/MD")
				STRING (REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
			ENDIF ()
		ENDFOREACH ()

		# clean up
		SET (upper_config_type)
		SET (config_type)
		SET (flag_var)
	ENDIF ()
ENDIF ()

add_library(stb STATIC "${STB_ROOT}/stb.c")
target_compile_definitions(stb PUBLIC ${STB_DEFINES})