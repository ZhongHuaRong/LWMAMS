import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import an.qt.ClientManagement 1.0

Window {
    id: window
    visible: true
    width: 1600+20
    height: 900+20
    flags:Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
          | Qt.WindowMinimizeButtonHint| Qt.Window
    color:"#00000000"
    //title: qsTr("Large-scale water monitoring and management system")

    property bool isFull: false
    property int previousX: 0
    property int previousY: 0
    property var loginDialog: 0
    property var isQuit: false

    function loginDialogClose(autoFlag){
        var value = window.loginDialog.getValue();
        if(!value){
            Qt.quit();
        }
        else {
            var n=loginDialog.returnValue;
            mainWindow.setUserName(loginDialog.userName);

            window.loginDialog.destroy();

            //关联信号
            client.chartData.connect(mainWindow.setChartData);
        }
    }

    Component.onCompleted: {
        //程序启动时运行
        loginDialog=Qt.createComponent("LoginDialog.qml").createObject(window,{"client":client});
        client.loginMessage.connect(loginDialog.onLoginMessage);
        loginDialog.closing.connect(window.loginDialogClose);
    }

    ClientManagement{
        id:client
        onAuthorizedSign:{
            if(result!=0)
                msgBox.showQuestion("授权登陆",message);
            else
                msgBox.showInformation("授权登陆",message)
        }
        onQuitApp: {
            isQuit = true
            msgBox.showInformation("登陆","账号于其他地方登陆，这里强制退出")
        }
        onAuthorizedResult:{
            if(result){
                window.loginDialog.destroy();

                //关联信号
                client.chartData.connect(mainWindow.setChartData);
            }
            else{
                msgBox.showInformation("授权登陆",message)
            }
        }
    }

    MsgBoxManagement{
        id:msgBox
        onGetReturnValue:{
            if(isQuit)
                Qt.quit();
            client.signup_authorizedResult(returnValue==msgBox.msgBox.yes?true:false)
        }
    }

    FileDialog{
        id:fileDialog
        title: "请选择一个文本"
        visible: false
        nameFilters: [ "Text files (*.txt )" ]
        //selectFolder:true
        selectMultiple:true
    }

    Rectangle {
        id:testRec
        width: parent.width - 20
        height: parent.height - 20
        color: "#00000000"
        anchors.centerIn: parent

        MainWindow{
            id:mainWindow
            anchors.fill:parent
            client:client
            onNarrow: window.showMinimized();
            onFullScreen:{
                window.isFull=flag
                if(flag){
                    window.showMaximized();
                }
                else{
                    window.showNormal();
                }
            }
            onFullDoubleClicked: {
                window.isFull = !window.isFull;
                if(window.isFull){
                    window.showMaximized();
                }
                else{
                    window.showNormal();
                }
            }

            onClose: Qt.quit();
            onStartMove:{
                window.previousX = x;
                window.previousY = y;
            }
            onMove:{
                window.setX(window.x + x - window.previousX);
                window.setY(window.y + y - window.previousY);
            }

            z:2
        }
    }

    DropShadow {
        anchors.fill: testRec
        horizontalOffset: -3
        verticalOffset: -3
        radius: 8.0
        samples: 16
        color: "#80000000"
        source: testRec
        smooth: true;
    }

    DropShadow {
        anchors.fill: testRec
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#80000000"
        source: testRec
        smooth: true;
    }
}
