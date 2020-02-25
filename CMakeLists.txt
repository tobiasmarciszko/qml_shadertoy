cmake_minimum_required(VERSION 3.5)

project(qml_shaders LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

if(ANDROID)
    add_library(qml_shaders SHARED
      main.cpp
      qml.qrc
    )
else()
    add_executable(qml_shaders
      main.cpp
      qml.qrc
    )
endif()

target_compile_definitions(qml_shaders
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(qml_shaders
  PRIVATE Qt5::Core Qt5::Quick)
