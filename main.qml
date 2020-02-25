import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    visible: true
    width: 640
    height: 480
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
            interval: 1000;
            running: true;
            repeat: true
            onTriggered: {
                shader.u_time = shader.u_time + 1.0;
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
