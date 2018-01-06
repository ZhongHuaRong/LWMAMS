import QtQuick 2.7

Rectangle {
    id:rect
    color:"#D4D4D5"

    signal currentIndexChanged(int index)
    CheckGroup{
        id:group
        onCurrentChanged:{
            switch(current){
            case home:
                rect.currentIndexChanged(0);
                break;
            case data:
                rect.currentIndexChanged(1);
                break;
            case route:
                rect.currentIndexChanged(2);
                break;
            case manual:
                rect.currentIndexChanged(3);
                break;
            case control:
                rect.currentIndexChanged(4);
                break;
            case video:
                rect.currentIndexChanged(5);
                break;
            case analysis:
                rect.currentIndexChanged(6);
                break;
            case feeding:
                rect.currentIndexChanged(7);
                break;
            }
        }
    }

    Flow{
        spacing:30
        padding:10
        ToolButton{
            id:home
            text:"主页"
            imageUrl:"qrc:/Resources/home.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:data
            text:"数据显示"
            imageUrl:"qrc:/Resources/dataShow.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:route
            text:"投料路线"
            imageUrl:"qrc:/Resources/route.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:manual
            text:"手册"
            imageUrl:"qrc:/Resources/manual.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:control
            text:"控制"
            imageUrl:"qrc:/Resources/control.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:video
            text:"视频"
            imageUrl:"qrc:/Resources/video.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:analysis
            text:"异常分析"
            imageUrl:"qrc:/Resources/analysis.png"
            checkable:true
            group:group
        }
        ToolButton{
            id:feeding
            text:"显示"
            checkable:true
            group:group
        }
    }
}
