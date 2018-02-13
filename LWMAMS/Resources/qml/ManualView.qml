import QtQuick 2.0
import an.qt.Manual 1.0

Rectangle {
    id:manualView
    color:"#ffffff"

    Component.onCompleted: {
        manual.loadTextOnQML.connect(manualView.addText);
        //manual.loadAll.connect(paraView.appendAll);
        manual.loadFirstTitle.connect(paraView.addFirstTitle);
        manual.loadSecondTitle.connect(paraView.addSecondTitle);
        manual.dirFinishRefresh.connect(paraView.refreshFinsh)

        paraView.textDirDeleteAll()
        manual.refreshDir();
    }

    function addText(list,isFirst){
        manual.startLoadText();

        if(isFirst)
            textView.clear();
        for(var a=0;a<list.length;a++){
            textView.append(list[a]);
            //textView.textCursorReset();
        }

        manual.endLoadText();
    }

    ManualParaListView{
        id:paraView
        width: 400
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onRefreshManualDir: manual.refreshDir();
    }

    ManualTextView{
        id:textView
        anchors.left: paraView.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }

    Manual{
        id:manual
    }
}
