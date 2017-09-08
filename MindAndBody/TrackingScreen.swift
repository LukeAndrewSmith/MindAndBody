//
//  TrackingScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 03.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts



//
// Tracking Screen Class --------------------------------------------------------------------------------------------------------
//
class TrackingScreen: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    @IBOutlet weak var backgroundImage: UIImageView!
    //
    let backgroundBlur = UIVisualEffectView()
    
    
    
    fileprivate var chart: Chart?
    
    
    // Time Scale Action Sheet
    let actionSheet = UIView()
    let timeScalePickerView = UIPickerView()
    let okButton = UIButton()
    let backgroundViewExpanded = UIButton()
    
    let timeScaleArray: [String] = ["1week", "1month", "3months", "6months", "1year", "all"]
    
    var selectedTimeScale = 0
    
    
    //
    var timeScaleButton2 = UIButton()
    
    // Variables
    var currentMondayDate = Int()
    var currentMonth = Int()
    var currentYear = Int()
    
    // Objects
    var swipeGestureView = UIView()

    
//
// View Will Appear ---------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // TimeScale Button2
        timeScaleButton2.frame = CGRect(x: 0, y: view.frame.maxY - 49, width: view.bounds.width, height: 49)
        timeScaleButton2.backgroundColor = .clear
        timeScaleButton2.addTarget(self, action: #selector(timeScaleButton(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow?.insertSubview(timeScaleButton2, aboveSubview: view)
        
    }
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tests !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        updateWeekTracking()
//        updateTracking()
//        updateMonthTracking()

        
        //
        // Time Scale Elements
        actionSheet.backgroundColor = colour1
        actionSheet.layer.cornerRadius = 15
        actionSheet.clipsToBounds = true
        
        //
        // Picker
        timeScalePickerView.backgroundColor = colour2
        timeScalePickerView.delegate = self
        timeScalePickerView.dataSource = self
        timeScalePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 147)
        
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        okButton.frame = CGRect(x: 0, y: 147, width: self.view.frame.size.width - 20, height: 49)
        
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)

        //
        actionSheet.addSubview(timeScalePickerView)
        actionSheet.addSubview(okButton)
        
        
        //
        // Navigation Controller
        self.navigationController?.navigationBar.barTintColor = colour2
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 23)!]
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
        
        
        //
        // Background Image
        backgroundImage.frame = view.bounds
        
        // Background Index
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        //
        // Background Image/Colour
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        }
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImage.bounds
        //
        if backgroundIndex > backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        setDates()
        
        if weekTrackingDictionary.count != 0 {
            drawGraph()
        } else {
            let warningLabel = UILabel()
            warningLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
            warningLabel.text = NSLocalizedString("trackingWarning", comment: "")
            warningLabel.textAlignment = .center
            warningLabel.textColor = colour1
            warningLabel.sizeToFit()
            warningLabel.center = CGPoint(x: backgroundImage.center.x, y: backgroundImage.center.y - 44)
            view.addSubview(warningLabel)
            view.bringSubview(toFront: warningLabel)
        }
        
        //
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGestureRight))
        
        swipeGestureView.backgroundColor = .clear
        swipeGestureView.bounds = view.bounds
        swipeGestureView.addGestureRecognizer(rightSwipe)
        swipeGestureView.isUserInteractionEnabled = true
        
//        view.addSubview(swipeGestureView)
//        view.bringSubview(toFront: swipeGestureView)
    }

    //
    // Set Dates
    func setDates() {
        // Format Monday
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd"
        // Get Monday
        var mondaysDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        currentMondayDate = Int(dfDay.string(from: mondaysDate))!
        
        // Format Month
        let dfMonth = DateFormatter()
        dfMonth.dateFormat = "MM"
        // Get Month
        var monthsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        currentMonth = Int(dfMonth.string(from: monthsDate))!
        
        // Format Year
        let dfYear = DateFormatter()
        dfYear.dateFormat = "yyyy"
        // Get Year
        var yearsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        currentYear = Int(dfYear.string(from: yearsDate))!
    }
    
    
//
// Graphs ------------------------------------------------------------------------------------------------------------------------
//
    //
    var currentPositionLabels: [UILabel] = []

    //
    func drawGraph() {
        //
        // Axis Label Settings
        var titleLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 17)!)
        titleLabelSettings.fontColor = colour1
        //
        var axisLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 14)!)
        axisLabelSettings.fontColor = colour1
        
        //
        // Generators
        // X generator for numbers
        let generator = returnChartAxisGeneratorMultiplier()
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        //
        let labelsGenerator = ChartAxisLabelsGeneratorNumber(labelSettings: axisLabelSettings, formatter: formatter)
        
        // Y generator
        let labelsGenerator2 = ChartAxisLabelsGeneratorFunc {scalar in
            return ChartAxisLabel(text: "", settings: axisLabelSettings)
        }
       
        //
        // Get data -- returns data based upon selectedTimeScale
        let chartPoints = returnChartPoints()
        let xValues = returnAxisValues(chartPoints: chartPoints)
        let xAxisTitle = returnAxisTitle(xValues: xValues)
        let xModel = returnXAxisModel(xAxisValues: xValues, titleLabelSettings: titleLabelSettings, axisLabelSettings: axisLabelSettings, xAxisTitle: xAxisTitle, generator: generator)
        
        let yValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.y}
        let yModel = ChartAxisModel(lineColor: colour1, firstModelValue: 0, lastModelValue: 125, axisValuesGenerator: generator, labelsGenerator: labelsGenerator2)
        
        //
        // Chart Settings
        let height = returnChartHeight()
        let chartFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: height)
        //
        var chartSettings = ChartSettings()
        chartSettings.leading = 8.25
        chartSettings.top = 24.5
        chartSettings.trailing = 12.25
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 0
        chartSettings.labelsToAxisSpacingY = 0
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.5
        chartSettings.spacingBetweenAxesX = 6.125
        chartSettings.spacingBetweenAxesY = 0
        chartSettings.labelsSpacing = 0
        chartSettings.zoomPan.panEnabled = true
        
        // generate axes layers and calculate chart inner frame, based on the axis models
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        //
        // Target
        let guideLinesHighlightLayerSettings = ChartGuideLinesLayerSettings(linesColor: colour3, linesWidth: 0.5)
        let guideLinesHighlightLayer = ChartGuideLinesForValuesLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, settings: guideLinesHighlightLayerSettings, axisValuesX: [], axisValuesY: [ChartAxisValueDouble(100)])
        
        //
        // Line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: colour4, animDuration: 1.0, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], useView: false)
        
        // view generator - this is a function that creates a view for each chartpoint
        // would be better to not call at all
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let label = UILabel()
            return label
        }
        
        // create layer that uses viewGenerator to display chartpoints
        let chartPointsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator, mode: .translate)
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 12.25)
            circleView.animDuration = 1.0
            circleView.fillColor = colour4
            return circleView
        }
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05, mode: .translate)
     
        
        //
        // Extra detail touch tracker layer
        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: 50, thumbBorderWidth: 2)
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings, selectNearest: true)
        
        // Current position labels array out of func so okbuttonaction can clear them
        
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints], lineColor: colour2, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
            
            self.currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.sizeToFit()
                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                
                label.backgroundColor = colour2
                label.textColor = colour1
                
                self.currentPositionLabels.append(label)
                self.view.addSubview(label)
            }
        }

        //
        // Finalise ----------------------------
        //
        //
        // Create array of layers
        var layersArray = [
            xAxisLayer,
            yAxisLayer,
            guideLinesHighlightLayer,
            chartPointsLayer,
            chartPointsLineLayer,
            chartPointsCircleLayer,
            chartPointsTrackerLayer
            ] as [ChartLayer]
        //
        // Add new layer for x dividers if selected time scale == 3 months or greater
        if selectedTimeScale > 1 {
            //
            var length = CGFloat()
            switch selectedTimeScale {
            case 2,3,5:
                length = 30
            case 4:
                length = 15
            default: break
            }
            //
            let dividersSettings =  ChartDividersLayerSettings(linesColor: colour1, linesWidth: 0.5, start: length, end: 0)
            let dividersLayer = ChartDividersLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: .x, settings: dividersSettings)
            //
            layersArray.append(dividersLayer)
        }
        //
        // Create chart instance with frame and layers
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: layersArray

        )
        //
        view.addSubview(chart.view)
        self.chart = chart
        
        //
//        view.bringSubview(toFront: swipeGestureView)
    }
    
    //
    // drawGraph() Helper Functions --------------------------------------------------------------------------------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------------
    // Get Chart Points
    func returnChartPoints() -> [ChartPoint] {
        switch selectedTimeScale {
        // Week
        case 0:
            let chartDataOld = weekTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            
            var chartData: [(key: Date, value: Int)] = []
            // Format Date
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            // Create dates from the keys and add to new array
            for i in 0...(chartDataOld.count - 1) {
                let key = chartDataOld[i].key
                var date = Date()
                // 2 months
                if (chartDataOld.first?.key)! != currentMondayDate {
                    // Last month
                    if key >= currentMondayDate {
                        var year = Int()
                        switch currentMonth {
                        // Month is january, last month is in last year
                        case 1: year = currentYear - 1
                        default: year = currentYear
                        }
                        let dateString = String(chartDataOld[i].key) + "." + String(currentMonth - 1) + "." + String(year)
                        date = df.date(from: dateString)!
                    // This month
                    } else {
                        let dateString = String(chartDataOld[i].key) + "." + String(currentMonth) + "." + String(currentYear)
                        date = df.date(from: dateString)!

                    }
                // 1 month
                } else {
                    date = df.date(from: String(chartDataOld[i].key) + "." + String(currentMonth) + "." + String(currentYear))!
                }
                let valueToAdd = chartDataOld[i].value
                let toAdd = (key: date, value: valueToAdd)
                chartData.append(toAdd)
            }
            // sort
            chartData = chartData.sorted(by: { $0.0.key < $0.1.key })

            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        // Month
        case 1:
            let chartData = trackingDictionary[currentYear]?[currentMonth]?.sorted(by: { $0.0.key < $0.1.key })
            let chartPoints: [ChartPoint] = (chartData?.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))})!
            return chartPoints
            
        // 3 Months, 6 Months
        case 2,3:
            //
            var monthsInt = Int()
            switch selectedTimeScale {
            case 2:
                monthsInt = 2
            case 3:
                monthsInt = 5
            default: break
            }
            //
            //Chart Points
            var chartPoints: [ChartPoint] = []
            
            //
            // All months in same year
            if currentMonth > monthsInt {
                // Find last month filled in
                var lastInt = Int()
                for t in (0...monthsInt).reversed() {
                    if trackingDictionary[currentYear]?[currentMonth - t] != nil {
                        lastInt = t
                        break
                    }
                }
                //
                chartPoints = returnChartPointsArray(chartPoints: chartPoints, year: currentYear, month: currentMonth, intToGoTo: lastInt)
                
            // Not all months in same year
            } else {
                // Last Year
                // overlapInt = int to take away from 12 to get first month of the previous year possible (might not contain any data, if user started less than x (3,6) months ago)
                    // Monthsint + 1 = number of months
                let overLapIntFull = abs((monthsInt + 1) - currentMonth) - 1
                // lastInt = int to take away from 12 to find last month of previous year that contains data
                var overLapInt = Int()
                for t in (0...overLapIntFull).reversed() {
                    if trackingDictionary[currentYear - 1]?[12 - t] != nil {
                        overLapInt = t
                        break
                    }
                }
                // Complete and append chartpoints last year
                chartPoints = returnChartPointsArray(chartPoints: chartPoints, year: currentYear - 1, month: 12, intToGoTo: overLapInt)
                
                // This Year
                // overLapInt is the number to take away from 12 to get the first month to use of the previous year
                let nonOverLapInt = currentMonth - 1
                // Complete and append chartpoints this year
                chartPoints = returnChartPointsArray(chartPoints: chartPoints, year: currentYear, month: currentMonth, intToGoTo: nonOverLapInt)
            }
            
            return chartPoints
            
        // Last year
        case 4:
            //
            //Chart Points
            var chartPoints: [ChartPoint] = []
            
            //
            // All months in same year
            if currentMonth == 12 {
                //
                chartPoints = returnChartPointsArray2(chartPoints: chartPoints, year: currentYear, month: currentMonth, intToGoTo: 11)
                
            // Not all months in same year
            } else {
                // Last Year
                // overlapInt = int to take away from 12 to get first month of the previous year possible (might not contain any data, if user started less than (3,6,12) months ago)
                let overLapIntFull = abs(12 - currentMonth) - 1
                // lastInt = int to take away from 12 to find last month of previous year that contains data
                var overLapInt = Int()
                for t in (0...overLapIntFull).reversed() {
                    if monthTrackingDictionary[currentYear - 1]?[12 - t] != nil {
                        overLapInt = t
                        break
                    }
                }
                // Complete and append chartpoints last year
                if overLapInt != 0 {
                    chartPoints = returnChartPointsArray2(chartPoints: chartPoints, year: currentYear - 1, month: 12, intToGoTo: overLapInt)
                }
                
                // This Year
                // overLapInt is the number to take away from 12 to get the first month to use of the previous year
                let nonOverLapInt = currentMonth - 1
                // Complete and append chartpoints this year
                chartPoints = returnChartPointsArray2(chartPoints: chartPoints, year: currentYear, month: currentMonth, intToGoTo: nonOverLapInt)
            }
            
            return chartPoints
        
        // All
        case 5:
            //
            //Chart Points
            var chartPoints: [ChartPoint] = []
            
            //
            // All months in same year
            if monthTrackingDictionary.count == 1 {
                //
                chartPoints = returnChartPointsArray2(chartPoints: chartPoints, year: currentYear, month: currentMonth, intToGoTo: currentMonth - 1)
                
            // Not all months in same year
            } else {
                
                // Loop all years, starting from the first
                for i in (1...monthTrackingDictionary.count - 1).reversed() {
                    var overLapInt = Int()
                    for t in (0...12).reversed() {
                        if monthTrackingDictionary[currentYear - i]?[12 - t] != nil {
                        overLapInt = t
                            break
                        }
                    }
                    
                    // Complete and append chartpoints last year
                    chartPoints = returnChartPointsArray2(chartPoints: chartPoints, year: currentYear - i, month: 12, intToGoTo: overLapInt)
                }
                
                // This Year
                let nonOverLapInt = currentMonth - 1
                // Complete and append chartpoints this year
                chartPoints = returnChartPointsArray2(chartPoints: chartPoints, year: currentYear, month: currentMonth, intToGoTo: nonOverLapInt)
            }
            
            return chartPoints
        //
        default:
            //
            let chartData = weekTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        }
    }
    //
    // Return chart points func, 3 months, 6 months (uses trackingDictionary)
    func returnChartPointsArray(chartPoints: [ChartPoint], year: Int, month: Int, intToGoTo: Int) -> [ChartPoint] {
        // Test
        let dfConvert = DateFormatter()
        dfConvert.dateFormat = "dd.MM.yyyy"
        //
        var chartPointsUpdated = chartPoints
        //test
        //
        for i in (0...intToGoTo).reversed() {
            for j in 0...(trackingDictionary[year]?[month - i]?.count)! - 1 {
                // Get array of dates sorted
                var toConvertArray = trackingDictionary[year]?[month - i]?.sorted(by: { $0.0.key < $0.1.key })
                var toAddValue = toConvertArray?[j].value
                
                // Get array of month keys sorted
                var toConvertKeys = trackingDictionary[year]?[month - i]?.keys.sorted()
                // Get month as string + .
                let toAddMonth = "." + String(month - i)
                // Get year as string + .
                let toAddYear = "." + String(year)
                // Get day as string
                let toConvertString = toConvertKeys?[j]
                let toAddDayString: String = String(toConvertString!)
                // Format date as "dd.MM"
                let toAddDateString = toAddDayString + toAddMonth + toAddYear
                let toAddDate = dfConvert.date(from: toAddDateString)!
                // Create Chart Point and add to chartPoints + make x axis values labels clear
                let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!, fontColor: .clear)
                let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: toAddDate, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(toAddValue!))
                chartPointsUpdated.append(chartPointToAdd)
            }
            
        }
        return chartPointsUpdated
    }
    //
    // Return chart points func, 12 months, All (uses monthTrackingDictionary) (month has different use this time, it determines what value to take away intogoto from (current month - 1 if current year, 11 if last year
    func returnChartPointsArray2(chartPoints: [ChartPoint], year: Int, month: Int, intToGoTo: Int) -> [ChartPoint] {
        // Test
        let dfConvert = DateFormatter()
        dfConvert.dateFormat = "MM.yyyy"
        //
        var chartPointsUpdated = chartPoints
        //test
        //
        // If no points in year
        for i in (0...intToGoTo).reversed() {
            // Get array of dates sorted
            let toAddValue = monthTrackingDictionary[year]?[month - i]

            // Get month as string
            let toAddMonth: String = String(month - i)
            // Get year as string + .
            let toAddYear = "." + String(year)
            // Format date as "MM.yyyy"
            let toAddDateString = toAddMonth + toAddYear
            let toAddDate = dfConvert.date(from: toAddDateString)!
            // Create Chart Point and add to chartPoints + make x axis values labels clear
            let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 14)!, fontColor: .clear)
            let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: toAddDate, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(toAddValue!))
            chartPointsUpdated.append(chartPointToAdd)
        }
        return chartPointsUpdated
    }

    
    // --------------------------------------------------------------------------------------
    // Get Generator, only used for week and month
    func returnChartAxisGeneratorMultiplier() -> ChartAxisGeneratorMultiplier {
        switch selectedTimeScale {
        case 0:
            return ChartAxisGeneratorMultiplier(1)
        case 1:
            return ChartAxisGeneratorMultiplier(7)
        default:
            return ChartAxisGeneratorMultiplier(0)
        }
    }
    
    // --------------------------------------------------------------------------------------
    // Get Axis Values
    func returnAxisValues(chartPoints: [ChartPoint]) -> [ChartAxisValue] {
        // Parameters
        //
        var axisLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 14)!)
        axisLabelSettings.fontColor = colour1
        
        // Values
        switch selectedTimeScale {
        // Week
        case 0:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            // Fill in empty values
            if xValues.count != 7 {
                let numberToAdd = 7 - xValues.count
                let valueToConvert = xValues.last!
                let dateString: String = String(describing: valueToConvert)
                let lastDate = df.date(from: dateString)
                for i in 1...numberToAdd {
                    let dateToAdd = Calendar.current.date(byAdding: .day, value: i, to: lastDate!)
                    let valueToAdd = ChartAxisValueDate(date: dateToAdd!, formatter: df)
                    xValues.append(valueToAdd)
                }
            }
            
            return xValues

        // 1 month doesn't use axis values
            
        // 3 Months
        case 2:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            //
            //
            // All months in same year
            if currentMonth > 2 {
                //
                xValues = completeChartAxisValues(xValues: xValues, year: currentYear, month: currentMonth, intToGoTo: 2)
                
                // Not all months in same year
            } else {
                // overLapInt is the number to take away from 12 to get the first month to use of the previous year
                let overLapInt = abs(3 - currentMonth) - 1
                // int to take away from current month to find first month of year (january)
                let nonOverLapInt = 1 - overLapInt
                // Complete chartAxisValues this year
                xValues = completeChartAxisValues(xValues: xValues, year: currentYear, month: currentMonth, intToGoTo: nonOverLapInt)
                // Complete chartAxisValues last year
                xValues = completeChartAxisValues(xValues: xValues, year: currentYear - 1, month: 12, intToGoTo: overLapInt)
            }
            
            
            return xValues
            
            
        // 6 Months
        case 3:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            //
            //
            // All months in same year
            if currentMonth > 5 {
                //
                xValues = completeChartAxisValues(xValues: xValues, year: currentYear, month: currentMonth, intToGoTo: 5)
                
            // Not all months in same year
            } else {
                // overLapInt is the number to take away from 12 to get the first month to use of the previous year
                let overLapInt = abs(6 - currentMonth) - 1
                // int to take away from current month to find first month of year (january)
                let nonOverLapInt = 4 - overLapInt
                // Complete chartAxisValues this year
                xValues = completeChartAxisValues(xValues: xValues, year: currentYear, month: currentMonth, intToGoTo: nonOverLapInt)
                // Complete chartAxisValues last year
                xValues = completeChartAxisValues(xValues: xValues, year: currentYear - 1, month: 12, intToGoTo: overLapInt)
            }
            
            
            return xValues

            
        // 12 Months
        case 4:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            //
            // All months in same year
            if currentMonth == 12 {
                //
                xValues = completeChartAxisValues2(xValues: xValues, year: currentYear, intToGoTo: 11, month: currentMonth - 1)
                
                // Not all months in same year
            } else {
                // overLapInt is the number to take away from 12 to get the first month to use of the previous year
                let overLapInt = abs(12 - currentMonth) - 1
                // int to take away from current month to find first month of year (january)
                let nonOverLapInt = 10 - overLapInt
                // Complete chartAxisValues this year (month: is either current month - 1 or 11)
                xValues = completeChartAxisValues2(xValues: xValues, year: currentYear, intToGoTo: nonOverLapInt, month: currentMonth)
                
                // lastMonth = last month with values contained in the dic, it is the value to take away from the current month to find the last month
                var lastMonth = Int()
                for t in (0...12).reversed() {
                    if monthTrackingDictionary[currentYear - 1]?[12 - t] != nil {
                        lastMonth = t
                        break
                    }
                }
                // Complete chartAxisValues last year
                xValues = completeChartAxisValues2(xValues: xValues, year: currentYear - 1, intToGoTo: overLapInt, month: 12)
            }
            
            
            return xValues
            
        // All
        case 5:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            //
            // All months in same year
            if monthTrackingDictionary.count == 1 {
                //
                xValues = completeChartAxisValues2(xValues: xValues, year: currentYear, intToGoTo: 11, month: currentMonth - 1)
                
                // Not all months in same year
            } else {
                // overLapInt is the number to take away from 12 to get the first month to use of the previous year
                let overLapInt = abs(12 - currentMonth) - 1
                // int to take away from current month to find first month of year (january)
                let nonOverLapInt = 10 - overLapInt
                // Complete chartAxisValues this year (month: is either current month - 1 or 11)
                xValues = completeChartAxisValues2(xValues: xValues, year: currentYear, intToGoTo: nonOverLapInt, month: currentMonth)
                
                
                // Loop all years, starting from the current - 1
                for i in 1...monthTrackingDictionary.count - 1 {
                // lastMonth = last month with values contained in the dic, it is the value to take away from the current month to find the last month
                var lastMonth = Int()
                for t in (0...12).reversed() {
                    if monthTrackingDictionary[currentYear - i]?[12 - t] != nil {
                        lastMonth = t
                        break
                    }
                }
                // Complete chartAxisValues last year
                xValues = completeChartAxisValues2(xValues: xValues, year: currentYear - 1, intToGoTo: lastMonth, month: 12)
                }
            }
            
            
            return xValues
        //
        default:
            let first = weekTrackingDictionary.keys.sorted().first!
            let xValues = [
                ChartAxisValueString(NSLocalizedString("mondayChar", comment: ""), order: first, labelSettings: axisLabelSettings),
                ChartAxisValueString(NSLocalizedString("tuesdayChar", comment: ""), order: first + 1, labelSettings: axisLabelSettings),
                ChartAxisValueString(NSLocalizedString("wednesdayChar", comment: ""), order: first + 2, labelSettings: axisLabelSettings),
                ChartAxisValueString(NSLocalizedString("thursdayChar", comment: ""), order: first + 3, labelSettings: axisLabelSettings),
                ChartAxisValueString(NSLocalizedString("fridayChar", comment: ""), order: first + 4, labelSettings: axisLabelSettings),
                ChartAxisValueString(NSLocalizedString("saturdayChar", comment: ""), order: first + 5, labelSettings: axisLabelSettings),
                ChartAxisValueString(NSLocalizedString("sundayChar", comment: ""), order: first + 6, labelSettings: axisLabelSettings),
                ]
            return xValues
        }
    }
    //
    //
    // Complete chart axis values func (inToGoTo represent to cycle through 0...something, depends if year is current or previous year (i.e, months = 11.12|1.2.3.4, intToGoTo would be 3 for this year and 1 for last year, it is the number to take from the current month (for current year) to find january and the number to take from 12 (previous year) to find the first month), 3 Months - 6 Months
    func completeChartAxisValues(xValues: [ChartAxisValue], year: Int, month: Int, intToGoTo: Int) -> [ChartAxisValue] {
        //
        var xValuesUpdated = xValues
        // Date Formatter
        let dfConvert = DateFormatter()
        dfConvert.dateFormat = "dd.MM.yyyy"
        
        //
        let mondayKeys = trackingDictionary[year]?[month]?.keys.sorted()
        
        // Add empty months mondays at the begging (if any empty months) -- this is a check incase the user's first value tracked was sooner than the desired display time (i.e in month 2 of the 3 months to be displayed)
        // Find last month filled in
        // lastMonth = last month with values contained in the dic, it is the value to take away from the current month to find the last month
        var lastMonth = Int()
        for t in (0...intToGoTo).reversed() {
            if trackingDictionary[year]?[month - t] != nil {
                lastMonth = t
                break
            }
        }
        // Get new values to add as chart points so labelsettings clear font can be applied to the points
        var chartPoints3: [ChartPoint] = []
        
        // Add months
        // intToGoTo - (lastMonth - 1) = the value to take away from month to find the last empty month|| doens't work if there is no last empty month so check lastMonth isn;t equal to the intToGoTo first
        if lastMonth != intToGoTo {
            for i in ((intToGoTo - (lastMonth + 1))...intToGoTo).reversed() {
                let numberOfMondays = numberOfMondaysInMonth(month - i, forYear: year)
                let firstMonday = firstMondayInMonth(month - i, forYear: year)
                for j in 0...(numberOfMondays! - 1){
                    // Get Month as string ".MM"
                    let toAddMonth = "." + String(month - i)
                    // Get year as string + .
                    let toAddYear = "." + String(year)
                    // Get Monday
                    let mondayToConvert = firstMonday! + (7 * j)
                    let mondayString: String = String(mondayToConvert)
                    let dateToConvert = mondayString + toAddMonth + toAddYear
                    let mondayDate = dfConvert.date(from: dateToConvert)
                    // Create chart point with clear label settings
                    let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!, fontColor: .clear)
                    let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: mondayDate!, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(0))
                    chartPoints3.append(chartPointToAdd)
                }
                
            }
        }
        
        // Make sure last month has all values, i.e didn't start mid way through the month
        let numberOfMondaysLast = numberOfMondaysInMonth(month - lastMonth, forYear: year)
        if (trackingDictionary[year]?[month - lastMonth]?.count)! < numberOfMondaysLast! {
            //
            let toAdd = numberOfMondaysLast! - (trackingDictionary[year]?[month - lastMonth]?.count)!
            let lastMonday = trackingDictionary[year]?[month - lastMonth]?.keys.sorted().last
            // Create array of chart points to add
            for i in 1...toAdd {
                // Get Month as string ".MM"
                let toAddMonth = "." + String(month - lastMonth)
                // Get year as string + .
                let toAddYear = "." + String(year)
                // Get Monday
                let mondayToConvert = lastMonday! + (7 * i)
                let mondayString: String = String(mondayToConvert)
                let dateToConvert = mondayString + toAddMonth + toAddYear
                let mondayDate = dfConvert.date(from: dateToConvert)
                // Create chart point with clear label settings
                let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!, fontColor: .clear)
                let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: mondayDate!, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(0))
                chartPoints3.append(chartPointToAdd)
            }
        }
        
        // Get array of xValues
        let xValuesToAdd: [ChartAxisValue] = (NSOrderedSet(array: chartPoints3).array as! [ChartPoint]).map{$0.x}
        
        // Append new array to xValues array if there are new values to append
        if xValuesToAdd.count != 0 {
            for i in (0...xValuesToAdd.count - 1).reversed() {
                xValuesUpdated.insert(xValuesToAdd[i], at: 0)
            }
        }
        
        // Check last month has all keys even if no value pair is associated with it, if not fill in necessary mondays (Add current months empty months if there are any)
        let numberOfMondays = numberOfMondaysInMonth(month, forYear: year)
        if (mondayKeys?.count)! < numberOfMondays! {
            // Date Formatter
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            //
            let toAdd = numberOfMondays! - (mondayKeys?.count)!
            let lastMonday = mondayKeys?.last
            // Create array of chart points to add
            var chartPoints2: [ChartPoint] = []
            for i in 1...toAdd {
                // Get Month as string ".MM"
                let toAddMonth = "." + String(month)
                // Get year as string + .
                let toAddYear = "." + String(year)
                // Get Monday
                let mondayToConvert = lastMonday! + (7 * i)
                let mondayString: String = String(mondayToConvert)
                let dateToConvert = mondayString + toAddMonth + toAddYear
                let mondayDate = dfConvert.date(from: dateToConvert)
                // Create chart point with clear label settings
                let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!, fontColor: .clear)
                let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: mondayDate!, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(0))
                chartPoints2.append(chartPointToAdd)
            }
            
            // Get array of xValues
            let xValuesToAdd: [ChartAxisValue] = (NSOrderedSet(array: chartPoints2).array as! [ChartPoint]).map{$0.x}
            
            // Append new array to xValues array
            for i in 0...xValuesToAdd.count - 1 {
                xValuesUpdated.append(xValuesToAdd[i])
            }
        }
        //
        return xValuesUpdated
    }

    // ----
    // Complete chart axis values func 2, 12Months - All
    func completeChartAxisValues2(xValues: [ChartAxisValue], year: Int, intToGoTo: Int, month: Int) -> [ChartAxisValue] {
        var xValuesUpdated = xValues
        //
        // Date Formatter
        let dfConvert = DateFormatter()
        dfConvert.dateFormat = "MM.yyyy"
        
        //
        // lastMonth = last month with values contained in the dic, it is the value to take away from the current month to find the last month
        var lastMonth = Int()
        for t in (0...intToGoTo).reversed() {
            if monthTrackingDictionary[year]?[12 - t] != nil {
                lastMonth = t
                break
            }
        }
        
        // Get new values to add as chart points so labelsettings clear font can be applied to the points
        var chartPoints2: [ChartPoint] = []
        // Add empty months if any exist
        if lastMonth != intToGoTo {
            for i in (0...intToGoTo).reversed() {
                // Get month as string
                var toAddMonth: String = String(month - i)
                // Get year as string + .
                let toAddYear = "." + String(year)
                // Format date as "MM.yyyy"
                let toAddDateString = toAddMonth + toAddYear
                let toAddDate = dfConvert.date(from: toAddDateString)!
                // Create Chart Point and add to chartPoints + make x axis values labels clear
                let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!, fontColor: .clear)
                let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: toAddDate, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(0))
                chartPoints2.append(chartPointToAdd)
            }
        }
        
        // Get array of xValues
        let xValuesToAdd: [ChartAxisValue] = (NSOrderedSet(array: chartPoints2).array as! [ChartPoint]).map{$0.x}
        
        // Append new array to xValues array if there are new values to append
        if xValuesToAdd.count != 0 {
            for i in (0...xValuesToAdd.count - 1).reversed() {
                xValuesUpdated.insert(xValuesToAdd[i], at: 0)
            }
        }
        //
        return xValuesUpdated
    }

    
    // --------------------------------------------------------------------------------------
    // Get xAxis Model
    func returnXAxisModel(xAxisValues: [ChartAxisValue], titleLabelSettings: ChartLabelSettings, axisLabelSettings: ChartLabelSettings, xAxisTitle: String, generator: ChartAxisGeneratorMultiplier) -> ChartAxisModel {
        // Parameters
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        //
        let labelsGenerator = ChartAxisLabelsGeneratorNumber(labelSettings: axisLabelSettings, formatter: formatter)
        //
        let xEmptyLabelsGenerator = ChartAxisLabelsGeneratorFunc {value in return
            ChartAxisLabel(text: "", settings: axisLabelSettings)
        }
        
        //
        switch selectedTimeScale {
        // Week
        case 0:
//            let xModel = ChartAxisModel(axisValues: xAxisValues, lineColor: colour1, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            
            let df = DateFormatter()
            df.dateFormat = "EEE"
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: axisLabelSettings, formatter: df)
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .day, preferredDividers: 6, minSpace: 0, maxTextSize: 12)
            
            //
            let firstDateString: String = String(describing: xAxisValues.first!)
            let firstDate = dfConvert.date(from: firstDateString)
            let lastDateString: String = String(describing: xAxisValues.last!)
            let lastDate = dfConvert.date(from: lastDateString)
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
            
        // Month
        case 1:
            //
            let firstModelValuex = Double((trackingDictionary[currentYear]?[currentMonth]?.keys.sorted().first)!)
            //
            let numberOfMondaysToAdd = numberOfMondaysInMonth(currentMonth, forYear: currentYear)! - 1
            let lastModelValuex = firstModelValuex + Double(numberOfMondaysToAdd * 7)
            //
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: firstModelValuex, lastModelValue: lastModelValuex, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: generator, labelsGenerator: labelsGenerator, leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
           
        // 3 Month
        case 2:
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            
            let df2 = DateFormatter()
            df2.dateFormat = " MMMM"
            
            // Generators
            var titleLabelSettings2 = titleLabelSettings
            titleLabelSettings2.textAlignment = .right
            titleLabelSettings2.rotation = 0.1
            titleLabelSettings2.rotationKeep = .top
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: titleLabelSettings2, formatter: df2)
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .month, preferredDividers: 2, minSpace: 0, maxTextSize: 12)
            
            //
            let firstDateString: String = String(describing: xAxisValues.first!)
            let firstDate = dfConvert.date(from: firstDateString)
            let lastDateString: String = String(describing: xAxisValues.last!)
            let lastDate = dfConvert.date(from: lastDateString)
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator)
            
            return xModel

        // 6 Months
        case 3:
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            
            let df2 = DateFormatter()
            df2.dateFormat = " MMM"
            
            // Generators
            var titleLabelSettings2 = titleLabelSettings
            titleLabelSettings2.textAlignment = .right
            titleLabelSettings2.rotation = 0.1
            titleLabelSettings2.rotationKeep = .top
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: titleLabelSettings2, formatter: df2)
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .month, preferredDividers: 5, minSpace: 0, maxTextSize: 12)
            
            //
            let firstDateString: String = String(describing: xAxisValues.first!)
            let firstDate = dfConvert.date(from: firstDateString)
            let lastDateString: String = String(describing: xAxisValues.last!)
            let lastDate = dfConvert.date(from: lastDateString)
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator)
            
            return xModel
            
        // 12 Months
        case 4:
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "MM.yyyy"
            
            let df2 = DateFormatter()
            // Note: spaces shouldn't be used for spacing
            df2.dateFormat = "     MMMMM"
            
            // Generators
            var titleLabelSettings2 = titleLabelSettings
            titleLabelSettings2.textAlignment = .right
            titleLabelSettings2.rotation = 0.1
            titleLabelSettings2.rotationKeep = .top
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: axisLabelSettings, formatter: df2)
            //
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .month, preferredDividers: 11, minSpace: 0, maxTextSize: 12)
                
            
            //
            let firstDateString: String = String(describing: xAxisValues.first!)
            let firstDate = dfConvert.date(from: firstDateString)
            let lastDateString: String = String(describing: xAxisValues.last!)
            let lastDate = dfConvert.date(from: lastDateString)
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, trailingPadding: ChartAxisPadding.label)
            
            return xModel
            
        // All
        case 5:
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "MM.yyyy"
            
            let df2 = DateFormatter()
            // Note: spaces shouldn't be used for spacing
            df2.dateFormat = " yyyy"
            
            // Generators
            var titleLabelSettings2 = titleLabelSettings
            titleLabelSettings2.textAlignment = .right
            titleLabelSettings2.rotation = 0.1
            titleLabelSettings2.rotationKeep = .top
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: titleLabelSettings2, formatter: df2)
            //
            let numberOfDividers = monthTrackingDictionary.count
            //
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .quarter, preferredDividers: 4, minSpace: 0, maxTextSize: 12)
            
            
            //
            let firstDateString: String = String(describing: xAxisValues.first!)
            let firstDate = dfConvert.date(from: firstDateString)
            let lastDateString: String = String(describing: xAxisValues.last!)
            let lastDate = dfConvert.date(from: lastDateString)
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, trailingPadding: ChartAxisPadding.label)
            
            return xModel
            
        //
        default:
            let xModel = ChartAxisModel(axisValues: xAxisValues, lineColor: colour1, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
        }
    }
    
    // --------------------------------------------------------------------------------------
    // Get xAxis Title
    func returnAxisTitle(xValues : [ChartAxisValue]) -> String {
        //
        let monthArray = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
        // x axis title
        switch selectedTimeScale {
        // 1 Week
        case 0:
            return NSLocalizedString("currentWeek", comment: "")
        // 1 Month
        case 1:
            // -1 because array starts at 0
            let month = NSLocalizedString(monthArray[currentMonth - 1], comment: "")
            return month
        // 1 year
        case 4,5:
            //
            let df = DateFormatter()
            df.dateFormat = "MMM - yyyy"
            let firstDate = xValues.first
            let firstString: String = String(describing: firstDate!)
            let lastDate = xValues.last
            let lastString: String = String(describing: lastDate!)
            return firstString + " - " + lastString
            
        //
        default: return ""
        }
    }

    // --------------------------------------------------------------------------------------
    // Return chart height
    var firstTimeOpened = true
    func returnChartHeight() -> CGFloat {
        if firstTimeOpened == true {
            firstTimeOpened = false
            return self.view.bounds.height - 64
        } else {
            return self.view.bounds.height
        }
    }

    
    //
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeScaleArray.count
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let timeLabel = UILabel()
        timeLabel.text = NSLocalizedString(timeScaleArray[row], comment: "")
        timeLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
        timeLabel.textColor = colour1
        //
        timeLabel.textAlignment = .center
        return timeLabel
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        
    }

    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        // If data is available
        if weekTrackingDictionary.count != 0 {
            //
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            //
            selectedTimeScale = timeScalePickerView.selectedRow(inComponent: 0)
            //
            animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
            //
            chart?.view.removeFromSuperview()
            drawGraph()
        // No data to display
        } else {
            selectedTimeScale = timeScalePickerView.selectedRow(inComponent: 0)
            animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
        }
        
    }

    //
    @IBAction func timeScaleButton(_ sender: Any) {
        //
        timeScalePickerView.selectRow(selectedTimeScale, inComponent: 0, animated: true)
        //
        UIApplication.shared.keyWindow?.insertSubview(actionSheet, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: actionSheet)
        //
        animateActionSheetUp(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
    }
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
    }
    
    
    
    
    //
    // Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    
    // Elements
    //
    @IBAction func swipeGestureRight(sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    @IBAction func swipeGesture(sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            //
            UIApplication.shared.statusBarStyle = .default
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
        } else {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    //
    // View will dissappear
    //
    override func viewDidDisappear(_ animated: Bool) {
        timeScaleButton2.removeFromSuperview()
    }
        
    
//
}


//
// Slide Menu Extension
extension TrackingScreen: UIViewControllerTransitioningDelegate {
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}



class TrackingNavigation: UINavigationController {
    
}
