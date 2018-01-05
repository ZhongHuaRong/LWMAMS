import QtQuick 2.8
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

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

    function loginDialogClose(){
        var value = window.loginDialog.getValue();
        if(!value){
            Qt.quit();
        }
        else {
            window.loginDialog.destroy();
        }
    }

    Component.onCompleted: {
        //程序启动时运行
        loginDialog=Qt.createComponent("LoginDialog.qml").createObject(window);
        loginDialog.closing.connect(window.loginDialogClose);
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
