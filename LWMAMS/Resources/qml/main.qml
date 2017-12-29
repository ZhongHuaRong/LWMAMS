import QtQuick 2.8
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 1280
    height: 720
    //title: qsTr("Large-scale water monitoring and management system")

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


}
