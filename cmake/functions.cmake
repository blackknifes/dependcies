set(TEMP_PATH "${CMAKE_CURRENT_SOURCE_DIR}/temp")
set(UNZIP_EXE "${CMAKE_CURRENT_SOURCE_DIR}/tool/unzip.exe")
set(BSDTAR_EXE "${CMAKE_CURRENT_SOURCE_DIR}/tool/bsdtar.exe")

function (DownloadLibraryZip name url internelName md5)
    file(GLOB CheckExists "${TEMP_PATH}/${internelName}.zip")
    if(NOT CheckExists)
        message(STATUS "download ${internelName} from ${url} .......")
        file(DOWNLOAD ${url} "${TEMP_PATH}/${internelName}.zip" INACTIVITY_TIMEOUT 5 TIMEOUT 120 TLS_VERIFY OFF SHOW_PROGRESS EXPECTED_MD5 ${md5})
    endif()
    set(CheckExists)

    file(GLOB CheckExists "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    if(CheckExists)
        return()
    endif()

    message(STATUS "unzip ${internelName}.zip ..............")    
    file(REMOVE_RECURSE "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    execute_process(COMMAND ${UNZIP_EXE} "${TEMP_PATH}/${internelName}.zip" -d "${CMAKE_CURRENT_SOURCE_DIR}/deps" OUTPUT_QUIET)
    file(RENAME "${CMAKE_CURRENT_SOURCE_DIR}/deps/${internelName}" "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    message(STATUS "get ${internelName} success.")
endfunction()

function (DownloadLibraryTarGZip name url internelName md5)
    file(GLOB CheckExists "${TEMP_PATH}/${internelName}.tar.gz")
    if(NOT CheckExists)
        message(STATUS "download ${internelName} from ${url} .......")
        file(DOWNLOAD ${url} "${TEMP_PATH}/${internelName}.tar.gz" INACTIVITY_TIMEOUT 5 TIMEOUT 120 TLS_VERIFY OFF SHOW_PROGRESS EXPECTED_MD5 ${md5})
    endif()
    set(CheckExists)

    file(GLOB CheckExists "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    if(CheckExists)
        return()
    endif()

    message(STATUS "unzip ${internelName}.tar.gz ..............")    
    message(${BSDTAR_EXE} "-xvf" "${TEMP_PATH}/${internelName}.tar.gz" "-C" "${CMAKE_CURRENT_SOURCE_DIR}/deps")
    file(REMOVE_RECURSE "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    execute_process(COMMAND ${BSDTAR_EXE} "-xvf" "${TEMP_PATH}/${internelName}.tar.gz" "-C" "${CMAKE_CURRENT_SOURCE_DIR}/deps" OUTPUT_QUIET)
    file(RENAME "${CMAKE_CURRENT_SOURCE_DIR}/deps/${internelName}" "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    message(STATUS "get ${internelName} success.")
endfunction()

function (DownloadHPPFile url savepath md5)
    file(GLOB CheckExists "${savepath}")
    if(CheckExists)
        set(CheckExists)
        return()
    endif()
    message(STATUS "download ${savepath} from ${url}")
    file(DOWNLOAD ${url} ${savepath} INACTIVITY_TIMEOUT 5 TIMEOUT 120 TLS_VERIFY OFF SHOW_PROGRESS EXPECTED_MD5 ${md5})
    message(STATUS "download ${savepath} success.")
endfunction()

function (CheckRuntime)
    IF (MSVC)
        option(STATIC_RUNTIME "c/c++ static runtime library" ON)
        IF (STATIC_RUNTIME)
            # CMAKE_CONFIGURATION_TYPES is empty on non-IDE generators (Ninja, NMake)
            # and that's why we also use CMAKE_BUILD_TYPE to cover for those generators.
            # For IDE generators, CMAKE_BUILD_TYPE is usually empty
            FOREACH (config_type ${CMAKE_CONFIGURATION_TYPES} ${CMAKE_BUILD_TYPE})
                STRING (TOUPPER ${config_type} upper_config_type)
                SET (flag_var "CMAKE_C_FLAGS_${upper_config_type}")
                set(TMP_VAL "${${flag_var}}")
                IF (${flag_var} MATCHES "/MD")
                    STRING (REGEX REPLACE "/MD" "/MT" TMP_VAL "${${flag_var}}")
                ENDIF ()
                set(${flag_var} ${TMP_VAL} CACHE STRING "..." FORCE)

                SET (flag_var "CMAKE_CXX_FLAGS_${upper_config_type}")
                set(TMP_VAL "${${flag_var}}")
                IF (${flag_var} MATCHES "/MD")
                    STRING (REGEX REPLACE "/MD" "/MT" TMP_VAL "${${flag_var}}")
                ENDIF ()
                set(${flag_var} ${TMP_VAL} CACHE STRING "..." FORCE)
            ENDFOREACH ()

            # clean up
            SET (upper_config_type)
            SET (config_type)
            SET (flag_var)
            set (TMP_VAL)
        ENDIF ()
    ENDIF ()
endfunction()

function (SupportMultiThreadBuild)
    string(REGEX MATCH "/MP" TMP_VAL ${CMAKE_C_FLAGS})
    if(!TMP_VAL)
        set(CMAKE_C_FLAGS "/MP ${CMAKE_C_FLAGS}" CACHE PATH "..." FORCE)
    endif()
    string(REGEX MATCH "/MP" TMP_VAL ${CMAKE_CXX_FLAGS})
    if(!TMP_VAL)
        set(CMAKE_CXX_FLAGS "/MP ${CMAKE_C_FLAGS}" CACHE PATH "..." FORCE)
    endif()
endfunction()