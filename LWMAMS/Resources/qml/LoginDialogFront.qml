import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id:front
    width:710
    height:480

    signal closeButtonClicked();
    signal registered();
    signal findPW();
    signal signUp();

    Rectangle{
        id:testRec
        anchors.fill:parent
        color:"#ffffff"

        Image {
            id: image
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            source: "qrc:/Resources/LoginBackground.jpg"
        }

        ShadowText {
            id: text1
            x: 27
            y: 17
            width: 173
            height: 68
            text: qsTr("Sign Up")
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
                front.closeButtonClicked();
            }
            z:5
        }

        CTextEdit {
            id: textEdit_userName
            y: 104
            height:40
            width:332
            x:pushButton_sign.x
            imageUrl: "../username@3x.png"
            placeholderText:"请输入你的账号"
            isPW: false
        }

        CTextEdit {
            id: textEdit_pw
            y: 185
            width: 332
            height: 40
            x:pushButton_sign.x
            imageUrl: "../passport@3x.png"
            placeholderText:"请输入你的密码"
            isPW: true
        }

        DoubleStateButton {
            id: pushButton_sign
            y: 264
            width: 282
            height: 40
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("登       陆")
            onClicked: {
                front.signUp();
            }
        }

        HighlightButton {
            id: pushButton_registered
            x: 214
            y: 331
            width:80
            height: 20
            text:qsTr("注册账号")
            onClicked: {
                front.registered();
            }
        }

        HighlightButton {
            id: pushButton_findPW
            x: 416
            y: 331
            width:80
            height: 20
            text:qsTr("找回密码")
            onClicked: {
                front.findPW();
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
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            pixelSize: 13
            textColor: "#8ce5a9"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
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
