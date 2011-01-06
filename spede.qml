import Qt 4.7
import "spede.js" as Spede

Rectangle {
    id: screen
    width: 500; height: 250

    focus: true
    Keys.onPressed: {
        // Map [z, x, c, v] into buttons with indices 0..3
        var buttonIndex = [90, 88, 67, 86].indexOf(event.key);
        if (buttonIndex >= 0) {
            Spede.handleClick(buttonIndex);
        }
    }

    Keys.onSpacePressed: {
        Spede.start();
    }

    Image {
        anchors.fill: parepjont
        source: "background.jpg"
        fillMode: Image.PreserveAspectCrop

        PropertyAnimation on rotation {
            to: 3
            duration: 5000
            loops: Animation.Infinite
            easing.type: Easing.SineCurve
        }

        PropertyAnimation on scale {
            to: 1.2
            duration: 20000
            loops: Animation.Infinite
            easing.type: Easing.CosineCurve
        }
    }

    Text {
        id: scoreDisplay
        text: "0"
        color: "mediumvioletred"
        font.bold: true
        smooth: true
        horizontalAlignment: Text.AlignCenter
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: screen.top
            topMargin: 20
        }
        font {
            family: "Consolas"
            pixelSize: 30
        }
    }

    Text {
        id: infoText
        text: ""
        smooth: true
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: screen.bottom
        anchors.bottomMargin: 20
        font.pixelSize: 16

        signal clicked

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                Spede.start();
            }
        }
    }

    GameButton {
        id: greenButton
        index: 0
        text: "z"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightgreen" }
            GradientStop { position: 1.0; color: "green" }
        }
        anchors.verticalCenter: parent.verticalCenter
        x: parent.width/2 - (2 * greenButton.width) - (blueButton.anchors.leftMargin * 1.5)
    }

    GameButton {
        id: blueButton
        index: 1
        text: "x"
        anchors { left: greenButton.right; top: greenButton.top }
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightblue" }
            GradientStop { position: 1.0; color: "blue" }
        }
    }

    GameButton {
        id: yellowButton
        index: 2
        text: "c"
        anchors { left: blueButton.right; top: blueButton.top }
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightyellow" }
            GradientStop { position: 1.0; color: "yellow" }
        }
    }

    GameButton {
        id: redButton
        index: 3
        text: "v"
        anchors { left: yellowButton.right; top: yellowButton.top }
        gradient: Gradient {
            GradientStop { position: 0.0; color: "pink" }
            GradientStop { position: 1.0; color: "red" }
        }
    }

    function buttonClicked(button) {
        Spede.handleClick(button);
    }

    Timer {
        interval: 500
        running: true
        repeat: false
        onTriggered: Spede.start()
    }

    Timer {
        id: gameTicker
        running: false
        repeat: true
        onTriggered: Spede.tick()
    }
}
