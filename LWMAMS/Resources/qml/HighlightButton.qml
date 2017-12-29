import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: button
    height: 84
    width: 84
    color: "#00000000"

    property color pressedColor: "#00BFFF"
    property color enteredColor: "#4169E1"
    property color exitColor: "#1E90FF"
    property color enabledColor: "#DCDCDC"
    property bool isClicked: false
    property string text: "text"

    signal clicked();

    Rectangle{
        id:testRec
        anchors.fill:parent
        color:"#00000000"

        Text {
            id: text
            text: button.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 14
            color: button.exitColor
            font.family: "黑体"
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                button.state="entered";
            }

            onExited:{
                button.state="exited";
            }

            onPressed: {
                button.state="pressed";
            }

            onReleased: {
                button.state="released";
            }

            onClicked: {
                button.clicked();
            }
        }

    }

    states :
        [
        State {
            name: "entered"
            PropertyChanges {
                target: text;
                color:button.enteredColor

            }
        },
        State{
            name:"pressed";
            PropertyChanges {
                target: text;
                color:button.pressedColor
            }
        },
        State{
            name:"exited";
        },
        State{
            name:"released";
            PropertyChanges {
                target: text;
                color:mouseArea.containsMouse===true?button.enteredColor:button.exitColor;
            }
        }

    ]

    DropShadow {
        anchors.fill: testRec
        horizontalOffset: 5
        verticalOffset: 5
        radius: 8.0
        samples: 20
        color: "#A0000000"
        source: testRec
        z:0
    }
}

