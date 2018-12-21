project(libiconv C)
set(LIBICONV_URL "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz")
set(LIBICONV_VERSION "1.15")

DownloadLibraryTarGZip("libiconv" ${LIBICONV_URL} "libiconv-${LIBICONV_VERSION}")

add_library(libiconv STATIC 
    ${LIBICONV_ROOT}/lib/iconv.c
    ${LIBICONV_ROOT}/libcharset/lib/localcharset.c
)

target_include_directories(libiconv PUBLIC 
    ${LIBICONV_ROOT}/include
    ${LIBICONV_ROOT}/lib
    ${LIBICONV_ROOT}/libcharset/include
    ${TEMP_PATH}/iconv
    )

target_compile_definitions(libiconv PUBLIC -DLIBDIR)

set(EILSEQ 42)
set(USE_MBSTATE_T "USE_MBSTATE_T")
set(BROKEN_WCHAR_H "0")
set(HAVE_WCHAR_T "HAVE_WCHAR_T")
set(ICONV_CONST "const")
set(HAVE_ICONV "1")
configure_file(${LIBICONV_ROOT}/include/iconv.h.in ${TEMP_PATH}/iconv/iconv.h @ONLY)

file(READ ${LIBICONV_ROOT}/lib/config.h.in ICONV_FILE)

string(REPLACE "#undef HAVE_ICONV" "#define HAVE_ICONV 1" ICONV_FILE ${ICONV_FILE})
string(REPLACE "#define ICONV_CONST" "#define ICONV_CONST const" ICONV_FILE ${ICONV_FILE})
string(REPLACE "#undef HAVE_STRING_H" "#define HAVE_STRING_H 1" ICONV_FILE ${ICONV_FILE})
string(REPLACE "#undef HAVE_STDLIB_H" "#define HAVE_STDLIB_H 1" ICONV_FILE ${ICONV_FILE})
string(REPLACE "#undef HAVE_STDDEF_H" "#define HAVE_STDDEF_H 1" ICONV_FILE ${ICONV_FILE})
file(WRITE ${TEMP_PATH}/iconv/config.h ${ICONV_FILE})
set(ICONV_FILE)
set(EILSEQ)
set(USE_MBSTATE_T)
set(BROKEN_WCHAR_H)
set(HAVE_WCHAR_T)
set(ICONV_CONST)
set(HAVE_ICONV)

configure_file(${LIBICONV_ROOT}/libcharset/include/libcharset.h.in ${TEMP_PATH}/iconv/libcharset.h @ONLY)
configure_file(${LIBICONV_ROOT}/libcharset/include/localcharset.h.in ${TEMP_PATH}/iconv/localcharset.h @ONLY)


install(TARGETS ${PROJECT_NAME}
PUBLIC_HEADER DESTINATION include
RUNTIME DESTINATION bin
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib)

install(FILES 
    ${TEMP_PATH}/iconv/iconv.h
    ${TEMP_PATH}/iconv/libcharset.h
    ${TEMP_PATH}/iconv/localcharset.h
    DESTINATION "${CMAKE_INSTALL_PREFIX}/include")