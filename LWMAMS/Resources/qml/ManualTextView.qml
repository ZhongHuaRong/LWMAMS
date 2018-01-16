import QtQuick 2.7
import QtQuick.Controls 1.4

Rectangle {
    id:textView
    color:"#ffffff"

    function append(text){
        textEdit.append(text);
    }

    function appendAll(list){

        for(var a=0;a<list.length;a++){
            textEdit.append(list[a]);
        }
    }

    function clear(){
        textEdit.remove(0,textEdit.length)
    }

    TextArea{
        id:textEdit
        anchors.fill:parent
        readOnly:true
        textFormat: TextEdit.RichText
        font.family: "Helvetica"
        font.pointSize: 20
        textColor: "#445266"
        highlightOnFocus: true
        wrapMode: TextEdit.Wrap
    }
}
