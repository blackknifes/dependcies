project (stb C)
add_library(stb STATIC "${STB_ROOT}/stb.c")

file(WRITE "${STB_ROOT}/stb.c" 
        "#include \"stb_image.h\"\n#include \"stb_image_resize.h\"\n#include \"stb_image_write.h\"\n")
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

target_compile_definitions(stb PUBLIC ${STB_DEFINES})


install(TARGETS ${PROJECT_NAME}
PUBLIC_HEADER DESTINATION include
RUNTIME DESTINATION bin
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib)

install(FILES 
        "${STB_ROOT}/stb.h"
        "${STB_ROOT}/stb_image.h"
        "${STB_ROOT}/stb_image_resize.h"
        "${STB_ROOT}/stb_image_write.h" 
    DESTINATION ${INSTALL_INC_PREFIX})