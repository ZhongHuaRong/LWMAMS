import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.2

Window {
    id: dialog
    visible: true
    width: 710 +20
    height: 480 + 20 + dialog.width/3
    flags:Qt.FramelessWindowHint
    modality : Qt.ApplicationModal
    color: "#00000000"

    property int returnValue: 0
    property int previousX: 0
    property int previousY: 0

    function getValue(){
        return dialog.returnValue;
    }

    function registered(){
        //
    }

    Rectangle {
        id:testRec
        width: parent.width - 20
        height: parent.height - 20 - dialog.width/3
        color: "#00000000"
        anchors.centerIn: parent

        MouseMoveArea {
            id: mouseArea
            anchors.fill: parent

            onStartMove:{
                dialog.previousX = x;
                dialog.previousY = y;
            }

            onMove:{
                dialog.setX(dialog.x + x - dialog.previousX);
                dialog.setY(dialog.y + y - dialog.previousY);
            }
        }

        Flipable{
            id: flipable
            z:9

            property bool flipped: false
            anchors.fill: parent
            front:LoginDialogFront{
                id:front
                anchors.fill: parent
                onCloseButtonClicked: dialog.close();
                onFindPW: {
                    back.type = 0;
                    back.changeCode();
                    flipable.flipped=!flipable.flipped;
                }
                onRegistered: {
                    back.type = 1;
                    back.changeCode();
                    flipable.flipped=!flipable.flipped;
                }
                onSignUp: {
                    dialog.returnValue =1;
                    dialog.close();
                }
            }

            back:LoginDialogBack{
                id:back
                anchors.fill: parent
                onCloseButtonClicked: dialog.close();
                onExit:flipable.flipped=!flipable.flipped;
                onRegistered: {
                    //
                }

                onCheckAccountNumber:{
                    //
                    back.setAccountNumber(1);
                }

                onCheckAppId: {
                    //
                    back.setAppID(1);
                }

                onCheckAll: {
                    //以下代码其实是在tcp类回调函数里的，先写在这里
                    if(!back.isRegistered)
                        return;
                    back.setAccountNumber(1);
                    back.setAppID(1);
                    if(back.canRegistered()){
                        //
                        flipable.flipped=!flipable.flipped;
                    }
                    else{
                        back.registerError();
                        //
                    }
                }
            }

            transform: Rotation{
                id: rotation
                origin.x: flipable.width/2
                origin.y: flipable.height/2
                axis.x: 0;
                axis.y: 1;
                axis.z: 0    // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states:State{
                PropertyChanges {
                    target: rotation
                    angle:180
                }
                when:flipable.flipped
            }

            transitions: Transition{
                NumberAnimation{
                    target:rotation
                    properties: "angle"
                    duration:1000
                }
            }
        }

    }

}


