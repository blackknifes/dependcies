set(JSON_URL "https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp")
set(JSON_MD5 "F31AE7FF09BE3B6F0F7D00EF4BB7512E")
DownloadHPPFile(${JSON_URL} "${CMAKE_CURRENT_SOURCE_DIR}/deps/json/json.hpp" ${JSON_MD5})