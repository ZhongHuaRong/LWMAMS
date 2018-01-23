import QtQuick 2.0
import an.qt.MsgBox 1.0

Item {
    id:item
    property var msgBox: 0
    property int returnValue: 0


    function showMsgBox(title,msg,msgType,button){
        msgBox=Qt.createComponent("MsgBox.qml").createObject(item,{
                                                                 "titleT":title,
                                                                "informationT":msg,
                                                             "imageType":msgType});
        msgBox.setButton(button)
        msgBox.closing.connect(msgBoxClose);
    }

    function msgBoxClose(){
        returnValue = msgBox.value;
        msgBox.destroy();
    }

    function showInformation(title,msg){
        showMsgBox(title,msg,MsgBox.MT_INFORMATION,MsgBox.Cancel)
    }

    function showWarning(title,msg){
        showMsgBox(title,msg,MsgBox.MT_WARNING,MsgBox.Cancel)
    }

    function showQuestion(title,msg){
        showMsgBox(title,msg,MsgBox.MT_QUESTION,MsgBox.Cancel)
    }


}
