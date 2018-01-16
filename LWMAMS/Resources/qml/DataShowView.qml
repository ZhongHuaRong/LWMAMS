import QtQuick 2.0
import QtQuick.Controls 1.4
import an.qt.DataShowPara 1.0

Item {
    id: item1

    property var para: 0

    onParaChanged: {
        if(para)
          dataShow_ParaListView.setPara(para);
    }

    DataShow_ParaListView {
        id: dataShow_ParaListView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        width:400
    }
}
