import QtQuick 2.7
import an.qt.DataShowPara 1.0
import an.qt.RouteManage 1.0

Item {
    id:routeView

    property var para: 0

    onParaChanged: {
        if(para){
            pageFilter.para=para;
            routeView.para.setEPageType(DataShowPara.Route)
            routeView.para.setNPageNum(0);
            routeView.para.setBAutoUpdate(true);

            latitudeMaxTextEdit.setText(para.getSLatitudeMax());
            latitudeMinTextEdit.setText(para.getSLatitudeMin());
            longitudeMaxTextEdit.setText(para.getSLongitudeMax());
            longitudeMinTextEdit.setText(para.getSLongitudeMin());
            pageFilter.para =para;
        }
    }

    function setPageActivation(flag){
        para.setBActivation(flag)
    }

    function setData(list){
        manage.addNode(list);
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

        TelescopicRectangle{
            id:latitudeAndLongitude
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:200
            headerText: "经纬度取值范围"

            Column{
                anchors.top: parent.top
                anchors.topMargin: latitudeAndLongitude.headerHeidht
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                Text{
                    id: latitudeText
                    text: "经度范围"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: latitudeMinText
                        text: "较小值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:20
                    }

                    CTextEdit{
                        id:latitudeMinTextEdit
                        height:latitudeMinText.height
                        width:120
                        border.color: "#445266"
                        onEditingFinished: {
                            if(routeView.para)
                                para.setSLatitudeMin(getText());
                        }
                    }

                    Text{
                        id: latitudeMaxText
                        text: "较大值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:latitudeMinText.height
                    }

                    CTextEdit{
                        id:latitudeMaxTextEdit
                        height:latitudeMinText.height
                        width:120
                        border.color: "#445266"
                        onEditingFinished: {
                            if(routeView.para)
                                para.setSLatitudeMax(getText());
                        }
                    }
                }

                Text{
                    id: longitudeText
                    text: "纬度范围"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: longitudeMinText
                        text: "最小值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:20
                    }

                    CTextEdit{
                        id:longitudeMinTextEdit
                        height:longitudeMinText.height
                        width:120
                        border.color: "#445266"
                        onEditingFinished: {
                            if(routeView.para)
                                para.setSLongitudeMin(getText());
                        }
                    }

                    Text{
                        id: longitudeMaxText
                        text: "最大值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:longitudeMinText.height
                    }

                    CTextEdit{
                        id:longitudeMaxTextEdit
                        height:longitudeMinText.height
                        width:120
                        border.color: "#445266"
                        onEditingFinished: {
                            if(routeView.para)
                                para.setSLongitudeMax(getText());
                        }
                    }
                }
            }
        }

        PageFilter {
            id: pageFilter
            anchors.top: latitudeAndLongitude.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
        }
    }

    CScrollView{
        id:rightRect
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: leftParaView.right
        anchors.leftMargin: 3
        anchors.right: parent.right
        anchors.rightMargin: 0

        RouteManage{
            id:manage
            width:rightRect.width
            height:rightRect.height
        }
    }

}
