import QtQuick 2.7
import QtWebEngine 1.1
import an.qt.DataShowPara 1.0

Item {
    id:videoView

    property var para: 0

    onParaChanged: {
        if(para)
            ipTextEdit.setText(para.getSVideoIP())
        webView.url = ipTextEdit.getText()
    }

    CScrollView{
        id:paraView
        clip:true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        width:400

        Rectangle {
            id:rect
            color:"#ffffff"
            width:paraView.width
            height:1100

            TelescopicRectangle{
                id:ipRect
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                height:150
                headerText: "远程IP"

                Flow{
                    anchors.top: parent.top
                    anchors.topMargin: ipRect.headerHeidht
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    spacing:15
                    padding:10

                    Text{
                        text: "以下设置谨慎修改，可能会导致功能异常，默认是192.168.0.103"
                        font.pixelSize: 20
                        color: "#445266"
                        font.family: "微软雅黑"
                        height:60
                        width:parent.width-10
                        wrapMode:Text.Wrap
                    }

                    CTextEdit{
                        id:ipTextEdit
                        width:170
                        textMaxNum: 50
                        border.color: "#445266"
                    }

                    PushButton {
                        id: ipButton
                        text:"设置"
                        pixelSize: 16
                        height:ipTextEdit.height
                        onClicked: {
                            if(videoView.para)
                                videoView.para.setSVideoIP(ipTextEdit.getText())
                            webView.url = ipTextEdit.getText()
                        }
                    }
                }
            }
        }
    }

    WebEngineView {
        id:webView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: paraView.right
        anchors.right: parent.right
        anchors.rightMargin: 0
        url: ""
    }


}
