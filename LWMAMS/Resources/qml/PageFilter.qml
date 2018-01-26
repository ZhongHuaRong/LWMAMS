import QtQuick 2.7

TelescopicRectangle{
    id:pageFilter
    headerText: "页面筛选"
    height:400

    property var para: 0
    property var isTextPage: false

    signal changedOnePage(bool isNext);
    signal changedAllPage(bool isLast);

    function setPageRowCount(text){
        onePageCountTextEdit.setText(text);
    }

    onParaChanged: {
        if(!para||isTextPage)
            return;
        pageNumText.text = para.getNPageNum() +1;
        pageMaxNum.text = para.getNPageMaxNum() +1;
        onePageCountTextEdit.setText(para.getNpageRowCount());

        para.pageNumChanged.connect(pageFilter.setPageNum);
        para.pageMaxNumChanged.connect(pageFilter.setMaxPage);
    }

    function setPageNum(index){
        pageNumText.text=index+1;
    }

    function setMaxPage(max){
        pageMaxNum.text = max+1;
    }

    function closeAutoUpdate(){
        updateButton.reset()
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
            }

            PushButton {
                id: onePageCountButton
                text:"设置"
                pixelSize: 16
                height:gotoPage.height
                onClicked: {
                    if(pageFilter.para)
                        para.setNpageRowCount(onePageCountTextEdit.getText())
                }
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
                    if(pageFilter.isTextPage)
                        pageFilter.changedAllPage(false);
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
                    if(pageFilter.isTextPage)
                        pageFilter.changedOnePage(false);
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
                    if(pageFilter.isTextPage)
                        pageFilter.changedOnePage(true);
                }
            }
            PushButton {
                id: nextTwoButton
                visible: pageFilter.isTextPage?false:true
                text:pageFilter.isTextPage?"结尾":"下两页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageNum()+2);
                    if(pageFilter.isTextPage)
                        pageFilter.changedPage(true);
                }
            }
            PushButton {
                id: lastPageButton
                text:"最后页"
                pixelSize: 12
                width:55
                height:35
                onClicked:{
                    if(pageFilter.para)
                        pageFilter.para.setNPageNum(pageFilter.para.getNPageMaxNum());
                    if(pageFilter.isTextPage)
                        pageFilter.changedAllPage(true);
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
                        if(gotoPageTextEdit.getText().length!==0)
                            pageFilter.para.setNPageNum(gotoPageTextEdit.getText()-1);
                }
            }
        }

        Row{
            spacing: 10
            visible: pageFilter.isTextPage?false:true
            PushButton{
                id:updateButton
                width: 120
                text:"动态更新"
                pixelSize: 16
                checkable: true
                checked: true
                state:"checked"
                onCheckedChanged: {
                    if(pageFilter.para)
                        pageFilter.para.setBAutoUpdate(updateButton.checked)
                }
            }

            Text{
                height: updateButton.height
                width:240
                text: "此功能激活时将自动更新图像,查找时默认关闭"
                font.pixelSize: 14
                color: "#445266"
                font.family: "微软雅黑"
                wrapMode:Text.Wrap
            }
        }

    }
}

