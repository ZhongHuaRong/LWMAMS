import QtQuick 2.0
import QtCharts 2.2
import an.qt.ChartViewData 1.0
import an.qt.DataShowPara 1.0
import an.qt.DateData 1.0

ChartView {
    id:chart
    animationOptions:ChartView.AllAnimations
    theme:ChartView.ChartThemeBlueCerulean
    dropShadowEnabled:true

    property var tempSeries: 0
    property var phSeries: 0
    property var turSeries: 0
    property var data: 0

    function setData(updateFlag,type,chartType){
        if(updateFlag==-1)
            return;

//        if(!updateFlag){
//            chart.removeAllSeries();
//            tempSeries = 0;
//            phSeries = 0;
//            turSeries = 0;
//            addSeries(type,chartType);
//        }

        for(var n=0;n<data.rowCount();n++){
            if(updateFlag){
                //
            }
            else{
                if(tempSeries){
                    tempSeries.append(data.data(n,0),data.data(n,4));
                }
                if(phSeries)
                    phSeries.append(data.data(n,0),data.data(n,5));
                if(turSeries)
                    turSeries.append(data.data(n,0),data.data(n,6));
            }

        }
        chart.setAxisX(xAxis,tempSeries);
        chart.setAxisY(yAxis,tempSeries);

        chart.setAxisX(xAxis,phSeries);
        chart.setAxisY(yAxis,phSeries);

        chart.setAxisX(xAxis,turSeries);
        chart.setAxisY(yAxis,turSeries);

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
                    getSeriesType(ChartView.SeriesTypeLine),
                    "温度",
                    xAxis,
                    yAxis);
        phSeries= chart.createSeries(
                    getSeriesType(ChartView.SeriesTypeLine),
                    "酸碱度",
                    xAxis,
                    yAxis);
        turSeries= chart.createSeries(
                    getSeriesType(ChartView.SeriesTypeLine),
                    "浑浊度",
                    xAxis,
                    yAxis);
        setSeriesStyle(tempSeries,"#04DDFC")
        setSeriesStyle(phSeries,"#B707FC")
        setSeriesStyle(turSeries,"#FFB608")
    }

    function setSeriesStyle(series,color){
        series.color=color
        //series.hovered.connect(chart.hovered)
        var font = series.pointLabelsFont
        font.family ="微软雅黑"
        series.pointLabelsFont = font
        series.width = 4
        series.pointLabelsColor = "#ffffff";
        series.pointLabelsFormat = "@yPoint"
        series.pointLabelsVisible = true
        series.pointsVisible = true
    }

    Component.onCompleted: {
        addSeries()
    }

    DateTimeAxis{
        id:xAxis
        labelsVisible:true
        lineVisible:true
    }

    ValueAxis{
        id:yAxis
        labelsVisible:true
        lineVisible:true
    }

    DateData{
        id:date
    }

}
