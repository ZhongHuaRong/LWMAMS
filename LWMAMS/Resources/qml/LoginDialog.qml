import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import an.qt.ClientManagement 1.0
import an.qt.TcpClient 1.0

Window {
    id: dialog
    visible: true
    width: 710 +20
    height: 480 + 20 + dialog.width/3
    flags:Qt.FramelessWindowHint
    modality : Qt.ApplicationModal
    color: "#00000000"

    property int previousX: 0
    property int previousY: 0
    property var client: 0
    //返回值位0：直接退出 1：登陆退出 2:自动登录退出
    property int returnValue: 0

    function getValue(){
        return dialog.returnValue;
    }

    function onLoginMessage(ct,result,message){
        switch(ct){
        case TcpClient.CT_SIGNUP:
        case TcpClient.CT_SIGNUPAUTO:
        {
            if(result){
                dialog.returnValue = 1;
                dialog.close();
            }
            else{
                msgBox.showWarning("登陆",message);
                //到时候加上msgbox
                front.resetButton();
            }
            break;
        }

        case TcpClient.CT_PARACHECKACCOUNTNUMBER:
        {
            back.setAccountNumber(result?1:-1);
            break;
        }
        case TcpClient.CT_REGISTERED:
        {
            if(result){
                client.signup(back.getAccountNumber(),back.getTextEdit_pw(),true);
            }
            else{
                msgBox.showWarning("registered",message);
                back.registerError();
            }
            break;
        }
        }
    }

    MsgBoxManagement{
        id:msgBox
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
                    client.signup(name,pw);
                }
            }

            back:LoginDialogBack{
                id:back
                anchors.fill: parent
                onCloseButtonClicked: dialog.close();
                onExit:flipable.flipped=!flipable.flipped;
                onRegistered: {
                    client.registered(back.getAccountNumber(),
                                      back.getTextEdit_pw(),
                                      back.getTextEdit_userName());
                }

                onCheckAccountNumber:{
                    if(accountNumber.length==0)
                        back.setAccountNumber(-1);
                    else
                        client.checkAccountNumber(accountNumber)
                }

                onCheckAppId: {
                    //
                    back.setAppID(1);
                }

                onCheckAll: {
                    //以下代码其实是在tcp类回调函数里的，先写在这里
                    if(!back.isRegistered)
                        return;
                    //back.setAccountNumber(1);
                    //back.setAppID(1);
                    if(back.canRegistered()){
                        //
                        back.registered();
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
                    duration:800
                    //easing.type: Easing.OutBack
                }
            }
        }

    }

}


