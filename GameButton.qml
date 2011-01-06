import Qt 4.7

Rectangle {
    id: button

    width: 100
    height: 100
    anchors.leftMargin: 10
    border {
        width: 2
        color: "black"
    }
    smooth: true
    radius: 15
    opacity: 0.7

    property int index: 0
    property string text: ""
    signal clicked

    Text {
        color: "white"
        styleColor: "midnightblue"
        style: Text.Sunken
        font.family: "Consolas"
        font.pixelSize: 40
        anchors.centerIn: parent
        text: button.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (button.state != "dead") {
                screen.buttonClicked(button);
            }
        }
    }

    states: [
        State {
            name: "hilighted"
            PropertyChanges {
                target: button
                opacity: 1.0
                scale: 1.1
            }
        },

        State {
            name: "dead"
            PropertyChanges {
                target: button
                opacity: 1.0
                rotation: 0
                scale: 1.0
            }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation {
                properties: "opacity, scale"
                duration: 80
            }
        }
    ]
}
