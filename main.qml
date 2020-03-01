import QtQuick.Window 2.14
import QtQuick 2.14

import QtQuick3D 1.14
import QtQuick3D.Materials 1.14

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
            x: root.width/2
            width: root.width/2
            height: root.height

            environment: SceneEnvironment {
                clearColor: "skyblue"
                backgroundMode: SceneEnvironment.Color
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
                    // shaderKey: ShaderInfo.Glossy
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
                position: Qt.vector3d(0, 200, -300)
                rotation: Qt.vector3d(30, 0, 0)
            }

            DirectionalLight {
                rotation: Qt.vector3d(30, 70, 0)
            }

            Model {
                position: Qt.vector3d(0, -200, 0)
                source: "#Cylinder"
                scale: Qt.vector3d(2, 0.2, 1)
                materials: [ DefaultMaterial {
                        diffuseColor: "red"
                    }
                ]
            }

            Model {
                position: Qt.vector3d(0, 150, 0)

                source: "#Cube"

                materials: material


                SequentialAnimation on rotation {
                          loops: Animation.Infinite
                          PropertyAnimation {
                              duration: 5000
                              to: Qt.vector3d(0, 360, 0)
                              from: Qt.vector3d(0, 0, 0)
                          }
                      }

                SequentialAnimation on y {
                    loops: Animation.Infinite
                    NumberAnimation {
                        duration: 3000
                        to: -150
                        from: 150
                        easing.type:Easing.InQuad
                    }
                    NumberAnimation {
                        duration: 3000
                        to: 150
                        from: -150
                        easing.type:Easing.OutQuad
                    }
                }
            }
        }

}
