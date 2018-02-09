import QtQuick 2.0
import QtQuick.Controls 1.4
import an.qt.DataShowPara 1.0
import an.qt.ChartViewData 1.0
import an.qt.TipMsgChart 1.0

Item {
    id: item

    property var para: 0

    onParaChanged: {
        if(para)
          dataShow_ParaListView.setPara(para);
        setTableCaveatValue();
        para.caveatValueChanged.connect(item.setTableCaveatValue)
    }

    function setPageActivation(flag){
        if(para)
            para.setBActivation(flag)
    }

    function setData(list){
        var updateFlag=data.setData(list);
        console.debug(updateFlag)
        if(para.getEChartType() ==DataShowPara.Table){
            //添加表格数据
            tableView.setData(updateFlag,data)
        }
        else//添加图表
            chartView.setData(updateFlag,para.getEDataType())
    }

    function changeViewType(type,chartType){
        //rconsole.debug(type,chartType)
        if(chartType ==DataShowPara.Table){
            chartView.visible = false;
            tableView.visible = true;
        }
        else if(chartType!=-1){
            chartView.visible = true;
            tableView.visible = false;
            chartView.setData(0,para.getEDataType())
        }

        if(type!=-1){
            chartView.setData(-1,para.getEDataType())
        }
    }

    function setTableCaveatValue(){
        tableView.temMin = para.getTempMinValue()
        tableView.temMax = para.getTempMaxValue()
        tableView.phMin = para.getPHMinValue()
        tableView.phMax = para.getPHMaxValue()
        tableView.turMin = para.getTurMinValue()
        tableView.turMax = para.getTurMaxValue()
        tableView.latMin = para.getSLatitudeMin()
        tableView.latMax = para.getSLatitudeMax()
        tableView.lonMin = para.getSLongitudeMin()
        tableView.lonMax = para.getSLongitudeMax()
    }

    DataShow_ParaListView {
        id: dataShow_ParaListView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        width:400
        onTypeChanged: item.changeViewType(type,chartType)
    }

    ChartViewData{
        id:data
    }

    DataShow_ChartView{
        id:chartView
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.left: dataShow_ParaListView.right
        anchors.leftMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 1
        data:data
        visible: false
        onShowTip: tip.showMsg(x+chartView.x,y+chartView.y,width,height,xValue,yValue)
        onHideTip: tip.hideMsg()
    }

    //这个放在ChartView同一层会无法显示(paint函数没有调用)
    //所以放在ChartView的上一层，然后将point映射(xy各加chartView的xy)到chartView的位置
    TipMsgChart{
        id:tip
        parent:item
    }

    DataShowTableView{
        id:tableView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: dataShow_ParaListView.right
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        visible: true
    }
}
