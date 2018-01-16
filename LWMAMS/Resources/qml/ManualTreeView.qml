import QtQuick 2.0
import QtQuick.Controls 1.4
import an.qt.TreeModel 1.0
import an.qt.TreeItem 1.0

Item {

    signal itemDoubleClicked(var row,var parentRow);

    function addFirstTitle(data){
        return model.appendChild(data);
    }

    function addSecondTitle(data,parent){
        return model.appendChild(data,parent);
    }

    function deleteAll(){
        model.deleteAll();
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
            console.debug("index:",index)
            console.debug("vaild",model.itemIsVaild(index))
            itemDoubleClicked(model.itemRow(index),model.itemRow(model.parent(index)));
        }

//        property bool isCollapse: true
//        onDoubleClicked: {
//            console.log("onClicked:", index)
//            console.log("isExpanded:",isExpanded(index))
//            if (isCollapse)
//            {
//                console.log("expand")
//                emit: view.expand(index);
//                isCollapse = false;
//            }
//            else
//            {
//                console.log("collapse")
//                emit: view.collapse(index);
//                isCollapse = true;
//            }
//            /*if (isExpanded(index))
//            {
//                collapse(index);
//            }
//            else
//            {
//                expand(index);
//            }*/
//        }
    }
}
