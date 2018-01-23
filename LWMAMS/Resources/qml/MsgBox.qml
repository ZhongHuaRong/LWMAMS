import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import an.qt.MsgBox 1.0

Window {
    id: messageBox
    visible: true
    width: 340
    height: 260
    color:"#00000000"
    flags:Qt.FramelessWindowHint
    modality : Qt.ApplicationModal

    property int previousX: 0
    property int previousY: 0
    property int value: 0

    property int yes: 0
    property int no: 0
    property int cancel: 0

    property string titleT: ""
    property string informationT: ""
    property int imageType: 0

    function returnValue(value){
        messageBox.value = value;
        messageBox.close();
    }


    function setTitle(string){
        titleT = string;

    }

    function setInfromation(string){
        informationT = string;
    }

    function setImage(url){
        imageType = url;
    }

    function setButton(state){
        if(state & MsgBox.Cancel){
            cancel_button.visible = true;
            if(state === MsgBox.Cancel)
                cancel_button.text = "OK";
        }
        if(state & MsgBox.Yes){
            ok_button.visible = true;
            messageBox.yes = MsgBox.Yes;
        }
        if(state & MsgBox.No){
            no_button.visible = true;
            messageBox.no = MsgBox.No;
        }
        if(state & MsgBox.Open){
            ok_button.visible = true;
            ok_button.text = "Open";
             messageBox.yes = MsgBox.Open;
        }
        if(state & MsgBox.Save){
            ok_button.visible = true;
            ok_button.text = "Save";
             messageBox.yes = MsgBox.Save;
        }
    }

    MsgBox{

    }

    Rectangle{
        id:rect
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent
        color:"#ffffff"
        Text {
            id: titleText
            height: 30
            text: titleT
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.right: closeButton.left
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 10
            font.pixelSize: 14
            font.family: "微软雅黑"
            color: "#ffffff"
            z:2
        }

        CToolButton {
            id: closeButton
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 3
            height:20
            radius: closeButton.width/2
            width: closeButton.height
            imageUrl:"../wrong_black.png"
            //pressedColor:"#CD5C5C"
            //enteredColor:"#F08080"
            //releasedColor:"#F08080"
            exitColor: "#00000000"
            onClicked: {
                messageBox.returnValue(0);
            }
            z:5
        }

        Rectangle {
            id: rectangle
            height: 40
            color: "#4c677c"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            z:1
        }

        MouseMoveArea {
            id: mouseArea
            height: rectangle.height
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            z:2
            onStartMove:{
                messageBox.previousX = x;
                messageBox.previousY = y;
            }

            onMove:{
                messageBox.setX(messageBox.x + x - messageBox.previousX);
                messageBox.setY(messageBox.y + y - messageBox.previousY);
            }
        }

        Image {
            id: image
            width: 80
            height: 80
            anchors.top: rectangle.bottom
            anchors.topMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 30
            source:{
                switch(imageType){
                case MsgBox.MT_NOT:
                    "";
                    break;
                case MsgBox.MT_INFORMATION:
                    "../information.png";
                    break;
                case MsgBox.MT_QUESTION:
                    "../question.png";
                    break;
                case MsgBox.MT_WARNING:
                    "../warning.png";
                    break;
                default:
                    "";
                }
            }
        }

        Text {
            id: information
            height: 95
            text: informationT
            verticalAlignment: Text.AlignVCenter
            anchors.left: image.right
            anchors.leftMargin: 15
            anchors.top: rectangle.bottom
            anchors.topMargin: 35
            anchors.right: parent.right
            anchors.rightMargin: 30
            font.pixelSize: 14
            font.family: "微软雅黑"
            color: "#445266"
            wrapMode:Text.Wrap
        }

        PushButton {
            id: ok_button
            width: 74
            height: 24
            text: "Yes"
            anchors.top: image.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 30
            visible: false
            onClicked:{
                messageBox.returnValue(messageBox.yes);
            }
        }

        PushButton {
            id: no_button
            width: 78
            height: 24
            text: "No"
            anchors.top: image.bottom
            anchors.topMargin: 30
            anchors.left: ok_button.right
            anchors.leftMargin: 10
            visible: false
            onClicked:{
                messageBox.returnValue(messageBox.no);
            }
        }

        PushButton {
            id: cancel_button
            width: 67
            height: 24
            text: "Cancel"
            anchors.top: image.bottom
            anchors.topMargin: 30
            anchors.left: no_button.right
            anchors.leftMargin: 20
            visible: false
            onClicked:{
                messageBox.returnValue(messageBox.cancel);
            }
        }
    }

    //阴影必须在所有组件之后才会在最底层
    DropShadow {
        anchors.fill: rect
        horizontalOffset: 5
        verticalOffset: 5
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rect
        smooth: true;
        z:0
    }

    DropShadow {
        anchors.fill: rect
        horizontalOffset: -5
        verticalOffset: -5
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rect
        smooth: true;
        z:0
    }

}


