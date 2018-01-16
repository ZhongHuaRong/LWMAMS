import QtQuick 2.7

TelescopicRectangle{
    id:pageFilter
    headerText: "页面筛选"
    height:300

    property var para: 0
    property var isTextPage: false

    function setPageRowCount(text){
        onePageCountTextEdit.setText(text);
    }

    onParaChanged: {
        if(!para)
            return;
        pageNumText.text = para.getNPageNum() +1;
        pageMaxNum.text = para.getNPageMaxNum() +1;
        onePageCountTextEdit.setText(para.getNpageRowCount());

        para.pageNumChanged.connect(pageFilter.setPageNum);
    }

    function setPageNum(index){
        pageNumText.text=index+1;
    }

    Column{
        anchors.top: parent.top
        anchors.topMargin: pageFilter.headerHeidht
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        spacing:15
        padding:10

        Row{
            visible: pageFilter.isTextPage?false:true
            spacing: 15
            Text{
                id: pageText
                text: "当前页码:"
                font.pixelSize: 16
                color: "#445266"
                font.family: "微软雅黑"
            }

            Text{
                id: pageNumText
                text: "0"
                font.pixelSize: 16
                color: "#445266"
                font.family: "微软雅黑"
            }
        }

        Row{
            visible: pageFilter.isTextPage?false:true
            spacing: 15
            Text{
                text: "最大页码:"
                font.pixelSize: 16
                color: "#445266"
                font.family: "微软雅黑"
            }

            Text{
                id: pageMaxNum
                text: "0"
                font.pixelSize: 16
                color: "#445266"
                font.family: "微软雅黑"
            }
        }

        Row{
            spacing: 10
            visible: pageFilter.isTextPage?false:true
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
                onEditingFinished: {
                    if(pageFilter.para)
                        para.setNpageRowCount(onePageCountTextEdit.getText())
                }
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
            visible: pageFilter.isTextPage?false:true
            font.pixelSize: 16
            color: "#445266"
            font.family: "微软雅黑"
        }

        Row{
            spacing: 8
            PushButton {
                id: firstPageButton
                text:pageFilter.isTextPage?"首页":"第一页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(0);
                }
            }
            PushButton {
                id: previousTwoButton
                visible: pageFilter.isTextPage?false:true
                text:"上两页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageNum()-2);
                }
            }
            PushButton {
                id: previousOneButton
                text:pageFilter.isTextPage?"上一节":"上一页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageNum()-1);
                }
            }
            PushButton {
                id: nextOneButton
                text:pageFilter.isTextPage?"下一节":"下一页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageNum()+1);
                }
            }
            PushButton {
                id: nextTwoButton
                visible: pageFilter.isTextPage?false:true
                text:"下两页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageNum()+2);
                }
            }
            PushButton {
                id: lastPageButton
                visible: pageFilter.isTextPage?false:true
                text:"最后页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageMaxNum());
                }
            }
        }

        Text{
            visible: pageFilter.isTextPage?false:true
            text: "随机跳转页数"
            font.pixelSize: 16
            color: "#445266"
            font.family: "微软雅黑"
        }

        Row{
            visible: pageFilter.isTextPage?false:true
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
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(gotoPageTextEdit.getText()-1);
                }
            }
        }
    }
}

