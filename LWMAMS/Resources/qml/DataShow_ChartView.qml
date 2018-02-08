import QtQuick 2.0
import QtCharts 2.2
import QtQml 2.2
import an.qt.ChartViewData 1.0
import an.qt.DataShowPara 1.0
import an.qt.DateData 1.0

ChartView {
    id:chart
    animationOptions:ChartView.SeriesAnimations
    theme:ChartView.ChartThemeBlueCerulean
    animationDuration:700

    signal showTip(var x,var y,var width,var height,var xValue,var yValue)
    signal hideTip();

    property var tempSeries: 0
    property var phSeries: 0
    property var turSeries: 0
    property var data: 0
    property var dataType: DataShowPara.AllData
    property color tempColor: "#0090FC"
    property color phColor: "#3EF540"
    property color turColor: "#FCD53F"

    function setData(updateFlag,type,chartType){
        if(updateFlag==-1||data.rowCount()<=0){
            showSeries(type)
            return;
        }

        var x;
        var y;
        if(!updateFlag){
            while(tempSeries.count>0){
                tempSeries.remove(0)
                phSeries.remove(0)
                turSeries.remove(0)
            }
            for(var n=data.rowCount()-1;n>=0;n--){

                x = data.data(n,1);
                if(tempSeries){
                    tempSeries.append(x,data.data(n,4));
                }
                if(phSeries)
                    phSeries.append(x,data.data(n,5));
                if(turSeries)
                    turSeries.append(x,data.data(n,6));
            }

            xAxis.min = data.data(data.rowCount()-1,1)
            xAxis.max = data.data(0,1)
        }
        else{
            //代码这样子排列动画会比较科学一点，先加点然后移动坐标轴再移除第一点
            tempSeries.append(data.data(0,1),data.data(0,4));
            phSeries.append(data.data(0,1),data.data(0,5));
            turSeries.append(data.data(0,1),data.data(0,6));

            xAxis.min = data.data(data.rowCount()-1,1)
            xAxis.max = data.data(0,1)

            tempSeries.remove(0)
            phSeries.remove(0)
            turSeries.remove(0)

        }


        if(type==chart.dataType)
            return;
    }

    function getSeriesType(chartType){
        switch(chartType){
        case DataShowPara.LineSeriesChart:
            return ChartView.SeriesTypeLine;
        case DataShowPara.BarChart:
            return 0;
        case DataShowPara.PieChart:
            return 0;
        }
    }

    function updateDataType(type,chartType){
        //
    }

    function addSeries(){
        tempSeries = chart.createSeries(
                    ChartView.SeriesTypeSpline,
                    "温度",
                    xAxis,
                    yAxis);
        phSeries= chart.createSeries(
                    ChartView.SeriesTypeSpline,
                    "酸碱度",
                    xAxis,
                    yAxis);
        turSeries= chart.createSeries(
                    ChartView.SeriesTypeSpline,
                    "浑浊度",
                    xAxis,
                    yAxis);
        setSeriesStyle(tempSeries,tempColor)
        setSeriesStyle(phSeries,phColor)
        setSeriesStyle(turSeries,turColor)
    }

    function setSeriesStyle(series,color){
        series.color=color
        series.hovered.connect(chart.hovered)
        var font = series.pointLabelsFont
        font.family ="微软雅黑"
        series.pointLabelsFont = font
        series.width = 4
        series.pointLabelsColor = "#ffffff";
        series.pointLabelsFormat = "@yPoint"
        series.pointLabelsVisible = true
        series.pointsVisible = true
    }

    function showSeries(dataType){
        hideSeries(chart.dataType)

        chart.dataType = dataType

        switch(dataType){
        case DataShowPara.AllData:
        {
            tempSeries.visible = true
            phSeries.visible = true
            turSeries.visible = true
            yAxis.min = 0;
            yAxis.max = 180;
            break;
        }
        case DataShowPara.Temperature:
        {
            tempSeries.visible = true
            yAxis.min = 0;
            yAxis.max = 40;
            break;
        }
        case DataShowPara.PH:
        {
            phSeries.visible = true
            yAxis.min = 0;
            yAxis.max = 14;
            break;
        }
        case DataShowPara.Turbidity:
        {
            turSeries.visible = true
            yAxis.min = 0;
            yAxis.max = 180;
            break;
        }
        }
    }

    function hideSeries(dataType){
        switch(dataType){
        case DataShowPara.AllData:
        {
            tempSeries.visible = false
            phSeries.visible = false
            turSeries.visible = false
            break;
        }
        case DataShowPara.Temperature:
        {
            tempSeries.visible = false
            break;
        }
        case DataShowPara.PH:
        {
            phSeries.visible = false
            break;
        }
        case DataShowPara.Turbidity:
        {
            turSeries.visible = false
            break;
        }
        }
    }

    function hovered(point,state){
        var po = mapToPosition(point,tempSeries);
        var time = date.date2String(date.long2Date(point.x));
//        console.debug(point)
//        console.debug(time)
        if(state){
            chart.showTip(po.x,po.y,250,72,
                          time,
                          point.y)
        }
        else{
            chart.hideTip();
        }
    }

    Component.onCompleted: {
        addSeries()
    }

    DateTimeAxis{
        id:xAxis
        labelsVisible:true
        lineVisible:true
        min:Date.fromLocaleString(Qt.locale(), "2018-02-06 17:00:00", "yyyy-MM-dd hh:mm:ss")
        max:Date.fromLocaleString(Qt.locale(), "2018-02-06 17:00:25", "yyyy-MM-dd hh:mm:ss")
        format: "yy-MM-dd hh:mm:ss"
        tickCount:9
        labelsAngle:45
        color:"#04DDFC"
        gridLineColor:"#04DDFC"
        labelsColor:"#04DDFC"
        labelsFont.family: "微软雅黑"
        minorGridVisible:true
    }

    ValueAxis{
        id:yAxis
        labelsVisible:true
        lineVisible:true
        min:0
        max:100
        color:"#04DDFC"
        gridLineColor:"#04DDFC"
        labelsColor:"#04DDFC"
        labelsFont.family: "微软雅黑"
        minorGridVisible:true
        tickCount:7
    }

    DateData{
        id:date
    }
}
