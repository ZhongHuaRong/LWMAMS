import QtQuick 2.0
import QtQuick.Controls 2.2
import an.qt.DataShowPara 1.0
import an.qt.ClientManagement 1.0
import an.qt.TcpClient 1.0

Item {
    id:page
    width:1280
    height:720
    property var client: 0
    property int currentPage: 0

    function changePage(index){
        switch(currentPage){
        case 1:
            page_one.setPageActivation(false);
            break;
        case 2:
            page_two.setPageActivation(false);
            break;
        case 4:
            page_four.setPageActivation(false);
            break;
        case 6:
            page_six.setPageActivation(false);
            break;
        }

        switch(index){
        case 0:
            stack.replace(view);
            break;
        case 1:
            stack.replace(page_one);
            page_one.setPageActivation(true);
            break;
        case 2:
            stack.replace(page_two);
            page_two.setPageActivation(true);
            break;
        case 3:
            stack.replace(page_three);
            break;
        case 4:
            stack.replace(page_four);
            page_four.setPageActivation(true);
            break;
        case 5:
            stack.replace(page_five);
            break;
        case 6:
            stack.replace(page_six);
            page_six.setPageActivation(true);
            break;
        case 7:
            stack.replace(page_seven);
            break;

        }
        currentPage = index;
    }

    DataShowPara{
        id:paraDataShow
        onParaData:{
            if(client)
                client.getServerData(TcpClient.CT_DATASHOW,
                                     pageNum,pageRow,isCheck,dataType,compare,value);
        }
    }

    DataShowPara{
        id:paraRoute
        onParaData:{
            if(client)
                client.getServerData(TcpClient.CT_ROUTE,
                                     pageNum,pageRow,isCheck,dataType,compare,value);
        }
    }

    DataShowPara{
        id:paraControl
        onParaData:{
            if(client)
                client.getServerData(TcpClient.CT_CONTROL,
                                     pageNum,pageRow,isCheck,dataType,compare,value);
        }
    }

    DataShowPara{
        id:paraAnalysis
        onParaData:{
            if(client)
                client.getServerData(TcpClient.CT_ANALYSIS,
                                     pageNum,pageRow,isCheck,dataType,compare,value);
        }
    }

    StackView{
        id: stack
        anchors.fill: parent

        Component{
            id: view
            Image{
                source:"qrc:/Resources/homeBackground.jpg"

                Text{
                    text:"大型水域养殖管理系统";
                    x:100
                    y:200
                    width:1000
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 80
                    font.family: "微软雅黑"
                    color: "#445266"
                }
            }

        }


        DataShowView{
            id:page_one
            para:paraDataShow
        }

        RouteView{
            id:page_two
            para:paraRoute

        }

        ManualView{
            id:page_three

        }

        ControlView{
            id:page_four
            para:paraControl
        }

        VideoView{
            id:page_five

        }

        AnalysisView{
            id:page_six
            para:paraAnalysis
        }

        Component{
            id:page_seven
            ShadowText{
                text:"大型水域";
                x:100
                y:200
                width:1000
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                pixelSize: 80
            }
        }
    }
}
