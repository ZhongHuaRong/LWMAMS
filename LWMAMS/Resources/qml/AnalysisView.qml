import QtQuick 2.0
import an.qt.DataShowPara 1.0

Item {
    id:analysisView

    property var para: 0

    onParaChanged: {
        if(para){
            pageFilter.para=para;
            analysisView.para.setNPageNum(0);
            analysisView.para.setBAutoUpdate(true);
        }
    }

    function setPageActivation(flag){
        para.setBActivation(flag)
    }

    Rectangle{
        id:leftParaView
        color:"#ffffff"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        width:400

        PageFilter {
            id: pageFilter
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
        }
    }

}
