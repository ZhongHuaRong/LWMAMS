import QtQuick 2.7
import an.qt.DataShowPara 1.0

CScrollView{
    id:view
    width:400
    height:600

    property var para: 0
    function setPara(para){
        view.para = para;
        view.para.setNPageNum(0);
        view.para.setBAutoUpdate(true);

        latitudeMaxTextEdit.setText(para.getSLatitudeMax());
        latitudeMinTextEdit.setText(para.getSLatitudeMin());
        longitudeMaxTextEdit.setText(para.getSLongitudeMax());
        longitudeMinTextEdit.setText(para.getSLongitudeMin());
        pageFilter.para =para;
    }

    Rectangle{
        color:"#ffffff"
        width:view.width
        height:1200

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
                    text: "纬度范围"
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
                        textMaxNum:15
                        onEditingFinished: {
                            if(view.para)
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
                        textMaxNum:15
                        onEditingFinished: {
                            if(view.para)
                                para.setSLatitudeMax(getText());
                        }
                    }
                }

                Text{
                    id: longitudeText
                    text: "经度范围"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: longitudeMinText
                        text: "较小值:"
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
                        textMaxNum:15
                        onEditingFinished: {
                            if(view.para)
                                para.setSLongitudeMin(getText());
                        }
                    }

                    Text{
                        id: longitudeMaxText
                        text: "较大值:"
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
                        textMaxNum:15
                        onEditingFinished: {
                            if(view.para)
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

        TelescopicRectangle{
            id:tipRect
            anchors.top: pageFilter.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:800
            headerText: "提示"

            Column{
                anchors.top: parent.top
                anchors.topMargin: tipRect.headerHeidht
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                Row{
                    spacing: 15

                    Rectangle{
                        color:"#0000ff"
                        height:30
                        width:80
                    }

                    Text{
                        text:"数值比最低值还低时显示"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                        height: 30
                        verticalAlignment:Text.AlignVCenter

                    }
                }

                Row{
                    spacing: 15
                    Rectangle{
                        color:"#00ccff"
                        height:30
                        width:80
                    }

                    Text{
                        text:"数值接近最低值时显示"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                        height: 30
                        verticalAlignment:Text.AlignVCenter

                    }
                }

                Row{
                    spacing: 15
                    Rectangle{
                        color:"#ffffcc"
                        height:30
                        width:80
                    }

                    Text{
                        text:"数值正常时显示"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                        height: 30
                        verticalAlignment:Text.AlignVCenter

                    }
                }

                Row{
                    spacing: 15
                    Rectangle{
                        color:"#ff3399"
                        height:30
                        width:80
                    }

                    Text{
                        text:"数值接近最高值时显示"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                        height: 30
                        verticalAlignment:Text.AlignVCenter

                    }
                }

                Row{
                    spacing: 15
                    Rectangle{
                        color:"#ff0033"
                        height:30
                        width:80
                    }

                    Text{
                        text:"数值超过最高值时显示"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                        height: 30
                        verticalAlignment:Text.AlignVCenter

                    }
                }

                Canvas{
                    id:paint
                    width: parent.width-60
                    height: paint.width
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.beginPath();
                        ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
                        ctx.arc(paint.width/2, paint.width/2, paint.width/2, -Math.PI/2, Math.PI/6);
                        ctx.lineTo(paint.width/2, paint.width/2);
                        ctx.fill();  //填充
                        ctx.stroke(); //描边

                        ctx.beginPath();
                        ctx.fillStyle = Qt.rgba(0, 1, 0, 1);
                        ctx.arc(paint.width/2, paint.width/2, paint.width/2, -Math.PI*7/6, -Math.PI/2);
                        ctx.lineTo(paint.width/2, paint.width/2);
                        ctx.fill();  //填充
                        ctx.stroke(); //描边

                        ctx.beginPath();
                        ctx.fillStyle = Qt.rgba(0, 0, 1, 1);
                        ctx.arc(paint.width/2, paint.width/2, paint.width/2, -Math.PI*11/6, -Math.PI*7/6);
                        ctx.lineTo(paint.width/2, paint.width/2);
                        ctx.fill();  //填充
                        ctx.stroke(); //描边

                        ctx.beginPath();
                        var gradient = ctx.createLinearGradient(0,0, width , height);
                        gradient.addColorStop( 0.0 , Qt.rgba(0 , 0.1 ,0.4 , 1));
                        gradient.addColorStop(1.0 , Qt.rgba(0.8,0, 0.5 , 1));

                        ctx.fillStyle = gradient;
                        ctx.font = "bold 25px sans-serif";
                        ctx.fillText("温度(T)", paint.width/2+30, paint.width/2-30);
                        ctx.fillText("酸碱度(PH)", 20, paint.width/2-30);
                        ctx.fillText("浑浊度(Tur)", paint.width/3, paint.width*3/4);
                    }
                }

            }
        }

    }
}
