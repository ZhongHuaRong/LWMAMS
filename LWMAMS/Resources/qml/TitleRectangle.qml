import QtQuick 2.7

Rectangle {
    id:title
    height:30
    width:1000
    color:"#ffffff"

    signal narrow();
    signal full(bool flag);
    signal close();

    property bool isFull: false

    function setFullButtonImage(){
        title.isFull =!title.isFull;
        if(!title.isFull)
            fullButton.imageUrl="qrc:/Resources/full.png";
        else
            fullButton.imageUrl="qrc:/Resources/full_close.png";
    }

    Image {
        id: image
        width: image.height
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        mipmap:true
        source: "qrc:/Resources/logo.jpg"
    }

    Text {
        id: text1
        text: qsTr("大型水域养殖管理系统")
        anchors.left: image.right
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 16
        font.family: "黑体"
    }

    TitleButton {
        id: narrowButton
        width:narrowButton.height*2
        anchors.right: fullButton.left
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        pressedColor: "#CACACB"
        enteredColor: "#E5E5E5"
        imageUrl: "qrc:/Resources/narrow.png"
        imageWidth: 20
        onClicked: title.narrow();
    }

    TitleButton {
        id: fullButton
        width:fullButton.height*2
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        anchors.right: closeButton.left
        anchors.rightMargin: 5
        pressedColor: "#CACACB"
        enteredColor: "#E5E5E5"
        imageUrl: "qrc:/Resources/full.png"
        onClicked: {
            title.setFullButtonImage();
            title.full(title.isFull);
        }
    }

    TitleButton {
        id: closeButton
        width:closeButton.height*2
        anchors.right: parent.right
        anchors.rightMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 3
        pressedColor: "#F1707A"
        enteredColor: "#E81123"
        imageUrl: "qrc:/Resources/close.png"
        onClicked: title.close();
    }


}
