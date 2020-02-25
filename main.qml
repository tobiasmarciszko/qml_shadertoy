import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 320
    height: 240
    title: qsTr("Hello Shader!")

    ShaderEffect {
        id: shader
        anchors.fill: parent
        fragmentShader: "qrc:/shader"

        // properties for GLSL uniforms
        property size  u_resolution: Qt.size(width, height)
        property point u_mouse: Qt.point(mouseArea.mouseX, height - mouseArea.mouseY)
        property real  u_time: 0.0

        // simulate time (seconds since shader started)
        Timer {
            interval: 10;
            running: true;
            repeat: true
            onTriggered: {
                shader.u_time = shader.u_time + 0.01;
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
