import QtQuick 2.0

Item {
    id:analysisView

    property var para: 0

    onParaChanged: {
        if(para)
          pageFilter.para=para;
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
