import QtQuick.Window 2.14
import QtQuick 2.14

import QtQuick3D 1.14
import QtQuick3D.Materials 1.14
import QtQuick3D.Helpers 1.14

Window {
    id: root
    visible: true
    width: 640
    height: 320
    title: qsTr("Hello Shader!")

    Timer {
        id: timer
        interval: 10;
        running: true;
        repeat: true
        onTriggered: {
            material.u_time = material.u_time + 0.01;
        }
    }

//    ShaderEffect {
//        id: shader
//        width: root.width/2
//        height: root.height
//        // fragmentShader: "qrc:/shader"

//        // properties for GLSL uniforms
//        property size  u_resolution: Qt.size(width, height)
//        property point u_mouse: Qt.point(mouseArea.mouseX, height - mouseArea.mouseY)
//        property real  u_time: 0.0

//        // simulate time (seconds since shader started)
//        Timer {
//            id: timer
//            interval: 10;
//            running: true;
//            repeat: true
//            onTriggered: {
//                shader.u_time = shader.u_time + 0.01;
//            }
//        }

//        MouseArea {
//            id: mouseArea
//            anchors.fill: parent
//            hoverEnabled: true
//        }
//    }

    View3D {
            id: view
            anchors.fill: parent
            environment: SceneEnvironment {
                clearColor: "black"
                backgroundMode: SceneEnvironment.Color
                multisampleAAMode: SceneEnvironment.X4
            }

            AxisHelper {
            }

            CustomMaterial {
                id: material

                property real u_width: root.width/2
                property real u_height: root.height
                property real u_time: 0.0

                // simulate time (seconds since shader started)

                shaderInfo: ShaderInfo {
                    version: "330"
                    type: "GLSL"
                    shaderKey: ShaderInfo.Glossy
                }

                Shader {
                    id: vertShader
                    stage: Shader.Vertex
                    shader: "qrc:/vertexshader"
                }


                Shader {
                    id: fragShader
                    stage: Shader.Fragment
                    shader: "qrc:/shader"
                }

                passes: [ Pass {
                              shaders: [vertShader, fragShader]
                          }
                      ]


            }

            PerspectiveCamera {
                id: camera
                position: Qt.vector3d(0, 200, -250)
                rotation: Qt.vector3d(30, 0, 0)

            }

            DirectionalLight {
                rotation: Qt.vector3d(30, 70, 0)
            }

            Model {
                id: cubeModel
                position: Qt.vector3d(0, 110, -50)
                source: "#Cube"
                materials: material
            }

            WasdController {
                anchors.fill: parent
                controlledObject: camera
            }
//            MouseArea {
//                id: mouseArea
//                anchors.fill: parent

//                property real initialMouseX: 0
//                property real initialMouseY: 0

//                onMouseXChanged: {
//                    let delta = initialMouseX - mouse.x
//                    cubeModel.rotation.y += delta
//                    initialMouseX = mouse.x
//                }

//                onMouseYChanged: {
//                    let delta = initialMouseY - mouse.y
//                    cubeModel.rotation.x -= delta
//                    initialMouseY = mouse.y
//                }

//            }
        }

}

/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
