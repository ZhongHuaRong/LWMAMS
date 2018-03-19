import QtQuick 2.0

Rectangle {
    id:mainWindow
    width: 1280
    height: 720
    color:"#123456"
    property var client: 0

    signal narrow();
    signal fullScreen(bool flag);
    signal close();
    signal startMove(int x,int y);
    signal move(int x,int y);
    signal fullDoubleClicked();

    Component.onCompleted: {
        title.narrow.connect(mainWindow.narrow);
        title.full.connect(mainWindow.fullScreen);
        title.close.connect(mainWindow.close);
        mouseArea.startMove.connect(mainWindow.startMove);
        mouseArea.move.connect(mainWindow.move);
        mouseArea.doubleClicked.connect(mainWindow.fullDoubleClicked);
        mouseArea.doubleClicked.connect(title.setFullButtonImage);
    }

    function setChartData(ct,list,maxCount){
        page.analyzeDataType(ct,list,maxCount);
    }

    function setUserName(name){
        page.setParaUserName(name)
    }

    TitleRectangle{
        id:title
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        z:2
    }

    MouseMoveArea {
        id: mouseArea
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        height:title.height
        z:1
    }

    ToolRectangle{
        id:tool
        height: 140
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: title.bottom
        anchors.topMargin: 0
        onCurrentIndexChanged:{
            page.changePage(index);
        }
    }

    MainPages{
        id:page
        anchors.top: tool.bottom
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        client:mainWindow.client
    }
}
