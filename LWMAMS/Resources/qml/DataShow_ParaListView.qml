import QtQuick 2.7
import an.qt.DataShowPara 1.0

CScrollView{
    id:view
    clip:true
    width:390
    height:600

    signal dataTypeChanged(int index)
    signal chartTypeChanged(int index)

    CheckGroup{
        id:dataTypeGroup
        onCurrentChanged:{
            switch(current){
            case temperatureButton:
                view.dataTypeChanged(DataShowPara.Temperature);
                break;
            case phButton:
                view.dataTypeChanged(DataShowPara.PH);
                break;
            case turbidityButton:
                view.dataTypeChanged(DataShowPara.Turbidity);
                break;
            case allDataButton:
                view.dataTypeChanged(DataShowPara.AllData);
                break;
            }
        }
    }

    CheckGroup{
        id:chartTypeGroup
        onCurrentChanged:{
            switch(current){
            case tableButton:
                view.chartTypeChanged(DataShowPara.Table);
                break;
            case lineSeriesButton:
                view.chartTypeChanged(DataShowPara.LineSeriesChart);
                break;
            case barButton:
                view.chartTypeChanged(DataShowPara.BarChart);
                break;
            case pieButton:
                view.chartTypeChanged(DataShowPara.PieChart);
                break;
            }
        }
    }

    Rectangle {
        id:rect
        color:"#ffffff"
        width:390
        height:1100

        TelescopicRectangle{
            id:dataType
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:150
            headerText: "数据类型"

            Flow{
                anchors.top: parent.top
                anchors.topMargin: dataType.headerHeidht
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                PushButton {
                    id: allDataButton
                    text:"所有"
                    pixelSize: 16
                    checkable:true
                    group:dataTypeGroup

                }
                PushButton {
                    id: temperatureButton
                    text:"温度"
                    pixelSize: 16
                    checkable:true
                    group:dataTypeGroup
                }

                PushButton {
                    id: phButton
                    text:"酸碱度"
                    pixelSize: 16
                    checkable:true
                    group:dataTypeGroup

                }

                PushButton {
                    id: turbidityButton
                    text:"浑浊度"
                    pixelSize: 16
                    checkable:true
                    group:dataTypeGroup

                }
            }

        }

        TelescopicRectangle{
            id:chartType
            anchors.top: dataType.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:150
            headerText: "图像类型"

            Flow{
                anchors.top: parent.top
                anchors.topMargin: dataType.headerHeidht
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                PushButton {
                    id: tableButton
                    text:"表格"
                    pixelSize: 16
                    checkable:true
                    group:chartTypeGroup

                }
                PushButton {
                    id: lineSeriesButton
                    text:"曲线图"
                    pixelSize: 16
                    checkable:true
                    group:chartTypeGroup
                }

                PushButton {
                    id: barButton
                    text:"条形图"
                    pixelSize: 16
                    checkable:true
                    group:chartTypeGroup

                }

                PushButton {
                    id: pieButton
                    text:"圆饼图"
                    pixelSize: 16
                    checkable:true
                    group:chartTypeGroup

                }
            }
        }

        TelescopicRectangle{
            id:warningRange
            anchors.top: chartType.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:250
            headerText: "警告值取值范围"

            Column{
                anchors.top: parent.top
                anchors.topMargin: dataType.headerHeidht
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                Text{
                    id: temperatureText
                    text: "温度警告值范围"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: temperatureMinText
                        text: "最小值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:20
                    }

                    CTextEdit{
                        id:tempMinTextEdit
                        height:temperatureMinText.height
                        width:120
                        placeholderText:"低于此值将报警"
                        border.color: "#445266"
                    }

                    Text{
                        id: temperatureMaxText
                        text: "最大值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:temperatureMinText.height
                    }

                    CTextEdit{
                        id:tempMaxTextEdit
                        height:temperatureMinText.height
                        width:120
                        placeholderText:"高于此值将报警"
                        border.color: "#445266"
                    }
                }

                Text{
                    id: phText
                    text: "PH警告值范围"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: phMinText
                        text: "最小值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:20
                    }

                    CTextEdit{
                        id:phMinTextEdit
                        height:temperatureMinText.height
                        width:120
                        placeholderText:"低于此值将报警"
                        border.color: "#445266"
                    }

                    Text{
                        id: phMaxText
                        text: "最大值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:temperatureMinText.height
                    }

                    CTextEdit{
                        id:phMaxTextEdit
                        height:temperatureMinText.height
                        width:120
                        placeholderText:"高于此值将报警"
                        border.color: "#445266"
                    }
                }

                Text{
                    id: turbidityText
                    text: "浑浊度警告值范围"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: turbidityMinText
                        text: "最小值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:20
                    }

                    CTextEdit{
                        id:turbidityMinTextEdit
                        height:temperatureMinText.height
                        width:120
                        placeholderText:"低于此值将报警"
                        border.color: "#445266"
                    }

                    Text{
                        id: turbidityMaxText
                        text: "最大值:"
                        font.pixelSize: 12
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:temperatureMinText.height
                    }

                    CTextEdit{
                        id:turbidityMaxTextEdit
                        height:temperatureMinText.height
                        width:120
                        placeholderText:"高于此值将报警"
                        border.color: "#445266"
                    }
                }
            }
        }

        TelescopicRectangle{
            id:dataFilter
            anchors.top: warningRange.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:210
            headerText: "数据筛选"

            Column{
                height: 200
                anchors.top: parent.top
                anchors.topMargin: dataType.headerHeidht
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                Row{
                    spacing:15
                    CComboBox{
                        id:dataTypeComboBox
                        width:100
                        height:40
                        model:ListModel{
                            ListElement {
                                      text: "所有数据"
                            }
                            ListElement {
                                      text: "温度"
                            }
                            ListElement {
                                      text: "酸碱度"
                            }
                            ListElement {
                                      text: "浑浊度"
                            }
                        }
                    }

                    CComboBox{
                        id:compareComboBox
                        width:100
                        height:40
                        model:ListModel{
                            ListElement {
                                      text: "大于"
                            }
                            ListElement {
                                      text: "等于"
                            }
                            ListElement {
                                      text: "小于"
                            }
                        }
                    }

                    CTextEdit{
                        id:compareValueTextEdit
                        height:dataTypeComboBox.height
                        width:80
                        placeholderText:"数值"
                        border.color: "#445266"
                    }
                }

                PushButton{
                    id:filterButton
                    width: dataTypeComboBox.width
                    text:"查找"
                    pixelSize: 16
                }

                Row{
                    spacing: 10
                    PushButton{
                        id:updateButton
                        width: dataTypeComboBox.width
                        text:"动态更新"
                        pixelSize: 16
                        checkable: true
                        checked: true
                        state:"checked"
                    }

                    Text{
                        height: updateButton.height
                        width:240
                        text: "此功能激活时将自动更新图像,否则图像不更新(查找时最好将该功能关闭)"
                        font.pixelSize: 14
                        color: "#445266"
                        font.family: "微软雅黑"
                        wrapMode:Text.Wrap
                    }
                }
            }
        }

        TelescopicRectangle{
            id:pageFilter
            anchors.top: dataFilter.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height:270
            headerText: "页面筛选"

            Column{
                anchors.top: parent.top
                anchors.topMargin: dataType.headerHeidht
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                spacing:15
                padding:10

                Text{
                    id: pageText
                    text: "当前页码:"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: onePageCount
                        text: "每页的数据行数:"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                    }

                    CTextEdit{
                        id:onePageCountTextEdit
                        height:onePageCount.height
                        width:80
                        placeholderText:"行数"
                        border.color: "#445266"
                    }

                    PushButton {
                        id: onePageCountButton
                        text:"设置"
                        pixelSize: 16
                        height:gotoPage.height
                    }
                }

                Text{
                    text: "固定跳转页数"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 8
                    PushButton {
                        id: firstPageButton
                        text:"第一页"
                        pixelSize: 12
                        width:55
                        height:35
                    }
                    PushButton {
                        id: previousTwoButton
                        text:"上两页"
                        pixelSize: 12
                        width:55
                        height:35
                    }
                    PushButton {
                        id: previousOneButton
                        text:"上一页"
                        pixelSize: 12
                        width:55
                        height:35
                    }
                    PushButton {
                        id: nextOneButton
                        text:"下一页"
                        pixelSize: 12
                        width:55
                        height:35
                    }
                    PushButton {
                        id: nextTwoButton
                        text:"下两页"
                        pixelSize: 12
                        width:55
                        height:35
                    }
                    PushButton {
                        id: lastPageButton
                        text:"最后页"
                        pixelSize: 12
                        width:55
                        height:35
                    }
                }

                Text{
                    text: "随机跳转页数"
                    font.pixelSize: 16
                    color: "#445266"
                    font.family: "微软雅黑"
                }

                Row{
                    spacing: 10
                    Text{
                        id: gotoPage
                        text: "跳转页码:"
                        font.pixelSize: 16
                        color: "#445266"
                        font.family: "微软雅黑"
                    }

                    CTextEdit{
                        id:gotoPageTextEdit
                        height:onePageCount.height
                        width:80
                        placeholderText:"页数"
                        border.color: "#445266"
                    }

                    PushButton {
                        id: gotoPageButton
                        text:"跳转"
                        pixelSize: 16
                        height:gotoPage.height
                    }
                }
            }
        }
    }
}
