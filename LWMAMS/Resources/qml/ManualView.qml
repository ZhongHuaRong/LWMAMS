import QtQuick 2.0
import an.qt.Manual 1.0

Rectangle {
    id:manualView
    color:"#ffffff"
    property var manual: 0
    property var firstTitleObject: []

    Component.onCompleted: {
        manual = Qt.createQmlObject(
                    'import an.qt.Manual 1.0; Manual {}', manualView, "dynamicSnippet");
        manual.loadTextOnQML.connect(manualView.addText);
        manual.loadAll.connect(textView.appendAll);
        manual.loadFirstTitle.connect(manualView.addFirstTitle);
        manual.loadSecondTitle.connect(manualView.addSecondTitle);

        treeView.itemDoubleClicked.connect(manual.itemDoubleClicked)

        deleteAllTitle();
        manual.startFindDirectory("养鱼手册.txt");
    }

    function addFirstTitle(){
        var object;
        for(var a=0;a<manual.titleSize(Manual.FirstTitle);a++){
            object=treeView.addFirstTitle(manual.firstTitleData(a));
            firstTitleObject.push(object);
        }
    }

    function addSecondTitle(){

        for(var a=0;a<manual.titleSize(Manual.FirstTitle);a++)
            for(var b=0;b<manual.titleSize(Manual.SecondTitle,a);b++){
                treeView.addSecondTitle(manual.secondTitleData(b,a),firstTitleObject[a]);
            }
    }

    function deleteAllTitle(){
        treeView.deleteAll();
        while(firstTitleObject.length>0)
            firstTitleObject.pop();
    }

    function addText(list){
        manual.startLoadText();

        textView.clear();
        for(var a=0;a<list.length;a++){
            textView.append(list[a]);
        }

        manual.endLoadText();
    }

    ManualTreeView{
        id:treeView
        width: 400
        anchors.top: pageFilter.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    ManualTextView{
        id:textView
        anchors.left: treeView.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }

    PageFilter {
        id: pageFilter
        width: 400
        height:100
        isTextPage: true
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
}
