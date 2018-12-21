add_library(libiconv STATIC 
    ${LIBICONV_ROOT}/src/iconv.c
    ${LIBICONV_ROOT}/libcharset/src/localcharset.c
)

target_include_directories(libiconv ${LIBICONV_ROOT}/include)
target_include_directories(libiconv ${LIBICONV_ROOT}/libcharset/include)
target_include_directories(libiconv ${LIBICONV_ROOT}/lib)

file(STRINGS ${LIBICONV_ROOT}/include/iconv.h.in ICONV_FILE)
string(REGEX REPLACE "@DLL_VARIABLE@" "" ICONV_FILE ${ICONV_FILE})
string(REGEX REPLACE "@EILSEQ@" "42" ICONV_FILE ${ICONV_FILE})
string(REGEX REPLACE "@" "" ICONV_FILE ${ICONV_FILE})
file(WRITE ${LIBICONV_ROOT}/include/iconv.h ${ICONV_FILE})
set(ICONV_FILE)

file(COPY ${LIBICONV_ROOT}/libcharset/include/libcharset.h.in DESTINATION ${LIBICONV_ROOT}/libcharset/include/libcharset.h)
file(COPY ${LIBICONV_ROOT}/libcharset/include/localcharset.h.in DESTINATION ${LIBICONV_ROOT}/libcharset/include/localcharset.h)

file(COPY ${LIBICONV_ROOT}/lib/config.h.in DESTINATION ${LIBICONV_ROOT}/lib/config.h)