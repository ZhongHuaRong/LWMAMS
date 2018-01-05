import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

PushButton{
    id:rect
    border.width: 0
    radius:4
    width:100
    height:50
    pressedColor: "#00BFFF"
    enteredColor: "#4169E1"
    exitedColor: "#1E90FF"
    text:rect.text_save
    property bool isRunning: false
    property string text_save: ""

    function resetButton(){
        rect.isRunning =false;
    }

    onClicked:{
        if(rect.isRunning){
            rect.text = rect.text_save +"...";
        }
        else{
            rect.text = rect.text_save;
        }
        rect.isRunning = !rect.isRunning;
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
