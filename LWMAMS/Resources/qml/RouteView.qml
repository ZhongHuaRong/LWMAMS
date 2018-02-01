import QtQuick 2.7
import an.qt.DataShowPara 1.0
import an.qt.RouteManage 1.0

Item {
    id:routeView

    property var para: 0

    onParaChanged: {
        if(para){
            paraView.setPara(para)
        }
    }

    function setPageActivation(flag){
        para.setBActivation(flag)
    }

    function setData(list){
        manage.addNode(list,
                       para.getTempMinValue(),para.getTempMaxValue(),
                       para.getPHMinValue(),para.getPHMaxValue(),
                       para.getTurMinValue(),para.getTurMaxValue(),
                       para.getSLatitudeMin(),para.getSLatitudeMax(),
                       para.getSLongitudeMin(),para.getSLongitudeMax());
    }

    RouteParaListView{
        id:paraView
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        width:400
    }

    CScrollView{
        id:rightRect
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: paraView.right
        anchors.leftMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 0

        RouteManage{
            id:manage
            width:rightRect.width-1
            height:rightRect.height-1

        }
    }
}
