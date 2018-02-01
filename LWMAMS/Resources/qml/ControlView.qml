import QtQuick 2.0
import an.qt.DataShowPara 1.0
import an.qt.TableData 1.0

Item {
    id:controlView

    property var para: 0

    onParaChanged: {
        leftParaView.setPara(para)
    }

    function setPageActivation(flag){
        para.setBActivation(flag)
    }

    function setData(list){
        data.setData(list);
        leftParaView.setButtonState(data.varData(0,0),data.varData(0,1))
        tableViwe.showData();
    }

    TableData{
        id:data
    }

    ControlParaListView{
        id:leftParaView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        onWaterButtonClick: {
            data.buttonStateChanged(enabled?1:3,ip);
        }
        onOxygenButtonClick: {
            data.buttonStateChanged(enabled?2:4,ip);
        }
    }

    Item{
        id:rightItem
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: leftParaView.right
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        ControlTableView{
            id:tableViwe
            anchors.fill:parent
            data:data
        }

    }

}
