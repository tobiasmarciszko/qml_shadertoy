cmake_minimum_required(VERSION 3.5)

project(qml_shaders LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core Quick Quick3D REQUIRED)

# Access to private APIs for QtQuick3D
include_directories(/home/tobias/Qt/5.14.1/gcc_64/include/QtQuick3DRender/5.14.1/)
include_directories(/home/tobias/Qt/5.14.1/gcc_64/include/QtQuick3DUtils/5.14.1/)
include_directories(/home/tobias/Qt/5.14.1/gcc_64/include/QtQuick3DRuntimeRender/5.14.1/)
include_directories(/home/tobias/Qt/5.14.1/gcc_64/include/QtQuick3D/5.14.1/)
include_directories(/home/tobias/Qt/5.14.1/gcc_64/include/QtQuick3D/5.14.1/QtQuick3D/private/)

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
  PRIVATE Qt5::Core Qt5::Quick Qt5::Quick3D)
