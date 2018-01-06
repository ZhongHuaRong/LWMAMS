import QtQuick 2.0
import QtGraphicalEffects 1.0
import an.qt.CodeArea 1.0

Item {
    id:back
    width:710
    height:480

    property int type: 1
    property bool isRegistered: false
    property string textEdit_accountNumber_text:    "请输入新的账号"
    property string textEdit_userName_text:         "请输入你的名字"
    property string textEdit_pw_text:               "请输入你的密码"
    property string textEdit_againPw_text:          "请确认你的密码"
    property string textEdit_appID_text:            "请输入你的ID号(可不填)"
    property string textEdit_Code_text:             "请输入验证码"

    signal closeButtonClicked();
    signal exit();
    signal registered();
    signal checkAccountNumber(string accountNumber);
    signal checkAppId(string appId);
    signal checkAll(string account,string appId);

    function changeCode(){
        codeArea.replaceCodePic();
        textEdit_Code.imageType =0;
    }

    function getAccountNumber(){
        return textEdit_accountNumber.getText();
    }

    function getTextEdit_userName(){
        return textEdit_userName.getText();
    }

    function getTextEdit_pw(){
        return textEdit_pw.getText();
    }

    function getTextEdit_appID(){
        return textEdit_appID.getText();
    }

    function checkCode(){
        textEdit_Code.imageType = codeArea.checkCode(textEdit_Code.getText())?-1:1;
    }

    function setAccountNumber(flag){
        textEdit_accountNumber.imageType=flag;
    }

    function setAppID(flag){
        textEdit_appID.imageType=flag;
    }

    function canRegistered(){
        //
        if(textEdit_accountNumber.imageType==1&&
                textEdit_Code.imageType==1&&
                textEdit_againPw.imageType==1&&
                textEdit_appID.imageType!=-1&&
                textEdit_pw.imageType==1&&
                textEdit_userName.imageType==1)
            return true;
        else
            return false;
    }

    function registerError(){
        pushButton_sign.resetButton();
        back.isRegistered =false;
    }

    Rectangle{
        id:testRec
        anchors.fill:parent
        color:"#00000000"

        Image {
            id: image
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            sourceSize.width: back.width
            sourceSize.height: back.height
            fillMode :Image.PreserveAspectCrop
            source: back.type?"qrc:/Resources/LoginBackground_Registered.jpg"
                             :"qrc:/Resources/LoginBackground_Registered.jpg"
        }

        ShadowText {
            id: text1
            x: 8
            y: 8
            width: 139
            height: 68
            text: qsTr(back.type?"注册用户":"找回密码")
            italic: true
            bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            pixelSize: 28
            textColor: "#445266"
        }

        CToolButton {
            id: closeButton
            x: 600
            y: 5
            width: 25
            height: 25
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            imageUrl:"../wrong_black.png"
            exitColor: "#00000000"
            onClicked: {
                back.closeButtonClicked();
            }
            z:5
        }

        TextEditWithShadow {
            id: textEdit_accountNumber
            x: 27
            y: 78
            height:40
            width:282
            imageUrl: "../username@3x.png"
            placeholderText:back.textEdit_accountNumber_text
            isPW: false
            textMaxNum:16
            onEditingFinished: back.checkAccountNumber(textEdit_accountNumber.getText());
        }

        TextEditWithShadow {
            id: textEdit_userName
            x: 371
            y: 78
            height:40
            width:282
            imageUrl: "../username@3x.png"
            placeholderText:back.textEdit_userName_text
            isPW: false
            textMaxNum:16
            imageType: {
                if(textEdit_userName.getText().length==0)
                    0
                else
                    textEdit_userName.getText().length>0?1:-1;
            }
        }

        TextEditWithShadow {
            id: textEdit_pw
            x: 27
            y: 149
            height:40
            width:282
            imageUrl: "../passport@3x.png"
            placeholderText:back.textEdit_pw_text
            isPW: true
            visible: back.type
            textMaxNum:16
            imageType:{
                if(textEdit_pw.getText().length==0)
                    0
                else
                    textEdit_pw.getText().length>0?1:-1;
            }
        }

        TextEditWithShadow {
            id: textEdit_againPw
            x: 371
            y: 149
            height:40
            width:282
            imageUrl: "../passport@3x.png"
            placeholderText:back.textEdit_againPw_text
            isPW: true
            visible: back.type
            textMaxNum:16
            imageType:{
                 if(textEdit_againPw.getText().length>6)
                     textEdit_againPw.getText()===textEdit_pw.getText()?1:-1;
                 else
                     textEdit_againPw.getText().length==0?0:-1;
            }
        }

        TextEditWithShadow {
            id: textEdit_appID
            x: 27
            y: 220
            height:40
            width:657
            placeholderText:back.textEdit_appID_text
            isPW: false
            textMaxNum:64
            onEditingFinished: back.checkAppId(textEdit_appID.getText());
        }

        TextEditWithShadow {
            id: textEdit_Code
            x: 27
            y: 302
            height:40
            width:246
            placeholderText:back.textEdit_Code_text
            isPW: false
            textMaxNum:6
            onEditingFinished: back.checkCode();
        }


        DoubleStateButton {
            id: pushButton_sign
            x: 104
            y: 397
            width: 196
            height: 40
            text_save: qsTr("申       请")
            onClicked: {
                if(back.isRegistered){
                    back.isRegistered = false;
                }
                else {
                    back.isRegistered = true;
                    back.checkCode();
                    back.checkAll(textEdit_accountNumber.getText(),
                                  back.checkAppId(textEdit_appID.getText()));
                }
            }
        }

        PushButton {
            id: pushButton_comeBack
            x: 371
            y: 397
            width: 196
            height: 40
            border.width: 0
            radius:4
            pressedColor: "#00BFFF"
            enteredColor: "#4169E1"
            exitedColor: "#1E90FF"
            text: qsTr("返       回")
            onClicked: {
                back.exit();
            }
        }

        ShadowText {
            id: text2
            x: 686
            y: 468
            width: 150
            height: 40
            text: qsTr("~ZM出品~必属精品~")
            italic: true
            bold: true
            pixelSize: 13
            textColor: "#8ce5a9"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
        }

        CodeArea{
            id:codeArea

            x: 253
            y: 285
            width: 160
            height: 80

            MouseArea{
                anchors.fill:parent
                onClicked: back.changeCode();
            }
        }
    }

    //阴影必须在所有组件之后才会在最底层
    DropShadow {
        anchors.fill: testRec
        horizontalOffset: 5
        verticalOffset: 5
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: testRec
        z:0
    }
}
