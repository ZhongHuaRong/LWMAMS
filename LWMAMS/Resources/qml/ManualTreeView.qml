import QtQuick 2.0
import QtQuick.Controls 1.4
import an.qt.TreeModel 1.0

Item {

    signal itemDoubleClicked(var row,var parentRow);

    function addFirstTitle(data){
        return model.appendChild(data,-1);
    }

    function addSecondTitle(data,parent){
        return model.appendChild(data,parent);
    }

    function deleteAll(){
        model.deleteAll();
    }

    function update(){
        model.resetModel()
    }

    TreeModel{
        id:model
    }

    TreeView {
        id:view
        anchors.fill:parent

        TableViewColumn {
            title: "章节"
            role: "num"
            width:90
        }
        TableViewColumn {
            title: "标题"
            role: "name"
            width:260
        }
        TableViewColumn {
            title: "行数"
            role: "page"
        }
        model: model
        itemDelegate: Item {
            Text {
                anchors.fill:parent
                color: styleData.selected?"#ffffff":"#445266"
                font.pixelSize: 20
                font.family: "微软雅黑"
                verticalAlignment: Text.AlignVCenter
                elide: styleData.elideMode
                text: styleData.value
            }
        }
        rowDelegate:Component{
            Rectangle{
                color:styleData.selected?"#0078D7":"#ffffff"
                height:30
            }
        }
        headerDelegate:Component{
            Rectangle{
                color:"#F5F5F5"
                height:30
                width:300
                border.width: 1
                border.color: "#E5E5E5"
                clip:true

                Text {
                    anchors.fill:parent
                    anchors.leftMargin: 5
                    color: "#445266"
                    font.pixelSize: 20
                    font.family: "微软雅黑"
                    verticalAlignment: Text.AlignVCenter
                    text: styleData.value
                }
            }
        }
        onDoubleClicked: {
            itemDoubleClicked(model.itemRow(index),model.itemRow(model.parent(index)));
        }
    }
}
