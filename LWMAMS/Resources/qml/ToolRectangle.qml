import QtQuick 2.7

Rectangle {
    id:rect
    color:"#D4D4D5"

    ToolButtonGroup{
        id:group
    }

    Component.onCompleted: {
        home.clicked.connect(group.clickObject);
        data.clicked.connect(group.clickObject);
        route.clicked.connect(group.clickObject);
        manual.clicked.connect(group.clickObject);
        control.clicked.connect(group.clickObject);
        video.clicked.connect(group.clickObject);
        analysis.clicked.connect(group.clickObject);
        feeding.clicked.connect(group.clickObject);

        group.resetButton.connect(home.resetWithObject);
        group.resetButton.connect(data.resetWithObject);
        group.resetButton.connect(route.resetWithObject);
        group.resetButton.connect(manual.resetWithObject);
        group.resetButton.connect(control.resetWithObject);
        group.resetButton.connect(video.resetWithObject);
        group.resetButton.connect(analysis.resetWithObject);
        group.resetButton.connect(feeding.resetWithObject);
    }

    Flow{
        spacing:30
        padding:10
        ToolButton{
            id:home
            text:"主页"
            imageUrl:"qrc:/Resources/home.png"
            checkable:true
            checked: true
            state:"checked"
            group:true
        }
        ToolButton{
            id:data
            text:"数据显示"
            imageUrl:"qrc:/Resources/dataShow.png"
            checkable:true
            group:true
        }
        ToolButton{
            id:route
            text:"投料路线"
            imageUrl:"qrc:/Resources/route.png"
            checkable:true
            group:true
        }
        ToolButton{
            id:manual
            text:"手册"
            imageUrl:"qrc:/Resources/manual.png"
            checkable:true
            group:true
        }
        ToolButton{
            id:control
            text:"控制"
            imageUrl:"qrc:/Resources/control.png"
            checkable:true
            group:true
        }
        ToolButton{
            id:video
            text:"视频"
            imageUrl:"qrc:/Resources/video.png"
            checkable:true
            group:true
        }
        ToolButton{
            id:analysis
            text:"异常分析"
            imageUrl:"qrc:/Resources/analysis.png"
            checkable:true
            group:true
        }
        ToolButton{
            id:feeding
            text:"显示"
            checkable:true
        }
    }
}
