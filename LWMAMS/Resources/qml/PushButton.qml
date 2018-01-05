import QtQuick 2.0

Rectangle {
    id: button
    color: button.exitedColor
    height: 150
    width: 120

    border.width: 1
    border.color: button.exitedBorderColor

    property color pressedColor: "#CCE4F7"
    property color pressedBorderColor: "#00559B"
    property color enteredColor: "#E5F1FB"
    property color enteredBorderColor: "#0078D7"
    property color exitedColor: "#E1E1E1"
    property color exitedBorderColor: "#ADADAD"
    property bool isPressed: false
    property string text: "按钮"

    signal clicked();

    states :
        [
        State {
            name: "entered"
            PropertyChanges {
                target: button;
                color:button.enteredColor
                border.color: button.enteredBorderColor
            }
        },
        State{
            name:"pressed";
            PropertyChanges {
                target: button;
                color:button.pressedColor
                border.color: button.pressedBorderColor
            }
        },
        State{
            name:"exited";
        },
        State{
            name:"released";
            PropertyChanges {
                target: button;
                color:{
                    if(mouseArea.containsMouse)
                        button.enteredColor;
                    else
                        button.exitedColor;
                }
                border.color: {
                    if(mouseArea.containsMouse)
                        button.enteredBorderColor;
                    else
                        button.exitedBorderColor;
                }
            }
        }

    ]

    transitions: Transition{
        ColorAnimation{
                target: button
                property: "color"
                duration: 250
        }

        ColorAnimation{
            target:button.border
            property: "color"
            duration:250
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            button.state="entered";
        }

        onExited:{
            if(!button.isPressed)
                button.state="exited";
        }

        onPressed: {
            button.state="pressed";
            isPressed = true;
        }

        onReleased: {
            button.state="released";
            isPressed = false;
        }

        onClicked: {
            button.clicked();
        }

        Text {
            id: text1
            text: button.text
            anchors.fill:parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 16
            font.family: "黑体"
        }
    }
}
