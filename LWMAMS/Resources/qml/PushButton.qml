import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

Rectangle{
    id:rect
    color:"#00000000"
    width:100
    height:50

    signal clicked();

    property string text: "str"

    Button {
        id: button
        anchors.fill: parent
        onClicked:{
            rect.clicked();
        }
        style:ButtonStyle{
            background :Rectangle{
                    border.width: 0
                    radius: 5
                    color: {
                        if(button.enabled===false)
                            "#DCDCDC"
                        else if(button.pressed===true)
                            "#00BFFF"
                        else if(button.hovered===true)
                            "#4169E1"
                        else
                            "#1E90FF"
                    }
            }
            label:Text{
                color: "#ffffff"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text:rect.text
                font.pixelSize: 16
                font.family: "黑体"
            }
        }
    }

    Rectangle {
        id:testRec
        width: parent.width
        height: parent.height
        color: "#ffffff"
        anchors.centerIn: parent
        border.width: 0
        radius: 6
        z:-1
    }

    DropShadow {
        anchors.fill: parent
        horizontalOffset: 6
        verticalOffset: 6
        radius: 8
        samples: 17
        color: "#40000000"
        source: testRec
        z:-1
    }
}
