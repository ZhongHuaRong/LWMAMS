import QtQuick 2.7
import an.qt.DataShowPara 1.0

CScrollView{
    id:view
    clip:true
    width:390
    height:600

    property var para: 0

    function setPara(para){
        view.para = para;
        view.para.setNPageNum(0);
        view.para.setBAutoUpdate(true);

        tempMinTextEdit.setText(para.getTempMinValue());
        tempMaxTextEdit.setText(para.getTempMaxValue());
        phMinTextEdit.setText(para.getPHMinValue());
        phMaxTextEdit.setText(para.getPHMaxValue());
        turbidityMinTextEdit.setText(para.getTurMinValue());
        turbidityMaxTextEdit.setText(para.getTurMaxValue());
    }

    function setPageMaxNum(index){
        pageMaxNum.text =index;
    }

    CheckGroup{
        id:dataTypeGroup
        onCurrentChanged:{
            if(!para)
                return;
            switch(current){
            case temperatureButton:
                para.setDataType(DataShowPara.Temperature)
                break;
            case phButton:
                para.setDataType(DataShowPara.PH)
                break;
            case turbidityButton:
                para.setDataType(DataShowPara.Turbidity)
                break;
            case allDataButton:
                para.setDataType(DataShowPara.AllData)
                break;
            }
        }
    }

    CheckGroup{
        id:chartTypeGroup
        onCurrentChanged:{
            if(!para)
                return;
            switch(current){
            case tableButton:
                para.setChartType(DataShowPara.Temperature);
                break;
            case lineSeriesButton:
                para.setChartType(DataShowPara.LineSeriesChart);
                break;
            case barButton:
                para.setChartType(DataShowPara.BarChart);
                break;
            case pieButton:
                para.setChartType(DataShowPara.PieChart);
                break;
            }
        }
    }

    Rectangle {
        id:rect
        color:"#ffffff"
        width:view.width
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
                        onEditingFinished: {
                            if(view.para)
                                para.setTempMinValue(tempMinTextEdit.getText());
                        }
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
                        onEditingFinished: {
                            if(view.para)
                                para.setTempMaxValue(tempMaxTextEdit.getText());
                        }
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
                        onEditingFinished: {
                            if(view.para)
                                para.setPHMinValue(phMinTextEdit.getText());
                        }
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
                        onEditingFinished: {
                            if(view.para)
                                para.setPHMaxValue(phMaxTextEdit.getText());
                        }
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
                        onEditingFinished: {
                            if(view.para)
                                para.getTurMinValue(turbidityMinTextEdit.getText());
                        }
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
                        onEditingFinished: {
                            if(view.para)
                                para.getTurMaxValue(turbidityMaxTextEdit.getText());
                        }
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
            height:150
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
                        onCurrentIndexChanged: {
                            if(view.para)
                                para.setEDataFilter_DataType(dataTypeComboBox.currentIndex+1);
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
                        onCurrentIndexChanged: {
                            if(view.para)
                                para.setEDatafilterCompare(compareComboBox.currentIndex+1);
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
                    onClicked: {
                        if(view.para)
                        {
                            if(compareValueTextEdit.getText().length===0)
                                return;
                            if(view.para)
                                para.setSCompareValue(compareValueTextEdit.getText());
                            para.checkButtonClick();
                            pageFilter.closeAutoUpdate();
                        }
                    }
                }

           }
        }

        PageFilter{
            id:pageFilter
            anchors.top: dataFilter.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            para:view.para
        }
    }
}
