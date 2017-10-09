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
        updateTracking()
        updateMonthTracking()
        
        // Present walkthrough 2
        let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
        if walkthroughs[6] == false {
            walkthroughTracking()
        }

        
        
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
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
        
        
        //
        // Background Image
        backgroundImage.frame = view.bounds
        
        // Background Index
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
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
            warningLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            warningLabel.text = NSLocalizedString("trackingWarning", comment: "")
            warningLabel.textAlignment = .center
            warningLabel.textColor = colour1
            warningLabel.sizeToFit()
            warningLabel.center = CGPoint(x: backgroundImage.center.x, y: backgroundImage.center.y - 44)
            view.addSubview(warningLabel)
            view.bringSubview(toFront: warningLabel)
        }
        
        
       
    }

    // MARK: Test
    //
    // Set Dates
    func setDates() {
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
    var currentPositionLabel = UILabel()

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
//        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: 500, thumbBorderWidth: 2)
//        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings, selectNearest: false)
        
//        // Current position labels array out of func so okbuttonaction can clear them
//        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints], lineColor: colour2, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
//            
//            self.currentPositionLabels.forEach{$0.removeFromSuperview()}
//            
//            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
//                
//                let label = UILabel()
//                let test3 = chartPoints[index].y
//                let test = chartPointWithScreenLoc.chartPoint.y
//                let test2 = chartPointWithScreenLoc.screenLoc.y
//                label.text = chartPointWithScreenLoc.chartPoint.description + "%"
//                label.sizeToFit()
//                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
//                if label.frame.maxX > self.view.bounds.width {
//                    label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x - label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
//                }
//                
//                label.backgroundColor = colour2
//                label.textColor = colour1
//                
//                self.currentPositionLabels.append(label)
//                self.view.addSubview(label)
//            }
//        }
        
//
//        let chartPointsTrackerLayer = ChartPointsTrackerLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, locChangedFunc: {[weak chartPointsLayer, weak currentPositionLabel] screenLoc in
////                    chartPointsLayer?.highlightChartpointView(screenLoc: screenLoc)
//                    if let chartPoint = chartPointsLayer?.chartPointsForScreenLocX(screenLoc.x).first {
//                        currentPositionLabel?.text = chartPoint.description
//                        currentPositionLabel?.sizeToFit()
//                        self.view.addSubview(currentPositionLabel!)
//                    } else {
//                        currentPositionLabel?.removeFromSuperview()
//                    }
//        }, lineColor: colour2, lineWidth: 1)
        
//        let chartPointsTrackerLayer = ChartPointsTrackerLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, locChangedFunc: {[weak chartPointsCircleLayer, weak currentPositionLabel] screenLoc in
//            
//            
//            // Label
//            currentPositionLabel?.text = chartPoints.description
//            currentPositionLabel?.sizeToFit()
//            currentPositionLabel?.center = CGPoint(x: (currentPositionLabel?.frame.width)! / 2, y: chartFrame.minY - (currentPositionLabel?.frame.height)! / 2)
//            if (currentPositionLabel?.frame.maxX)! > self.view.bounds.width {
//                currentPositionLabel?.center = CGPoint(x: (currentPositionLabel?.frame.width)! / 2, y: chartFrame.minY - ((currentPositionLabel?.frame.height)! / 2))
//            }
//            
//            currentPositionLabel?.backgroundColor = colour2
//            currentPositionLabel?.textColor = colour1
//            
//            self.currentPositionLabels.append(currentPositionLabel!)
//            self.view.addSubview(currentPositionLabel!)
//            
//            //
//            if let chartPoint = chartPointsCircleLayer?.chartPointsForScreenLocX(screenLoc.x).first {
//                currentPositionLabel?.text = chartPoint.description
//            } else {
//                currentPositionLabel?.removeFromSuperview()
//            }
//        }, lineColor: colour2, lineWidth: 1)
//
        
        
//        let trackerLayer = ChartPointsTrackerLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, locChangedFunc: {[weak candleStickLayer, weak infoView] screenLoc in
//            candleStickLayer?.highlightChartpointView(screenLoc: screenLoc)
//            if let chartPoint = candleStickLayer?.chartPointsForScreenLocX(screenLoc.x).first {
//                infoView?.showChartPoint(chartPoint)
//            } else {
//                infoView?.clear()
//            }
//            }, lineColor: UIColor.red, lineWidth: Env.iPad ? 1 : 0.6)
        

        
//        
//        locChangedFunc: {[weak chartPointsLayer, weak infoView] screenLoc in
//            candleStickLayer?.highlightChartpointView(screenLoc: screenLoc)
//            if let chartPoint = candleStickLayer?.chartPointsForScreenLocX(screenLoc.x).first {
//                infoView?.showChartPoint(chartPoint)
//            } else {
//                infoView?.clear()
//            }
//            }, lineColor: colour2, lineWidth: 1)


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
//            chartPointsTrackerLayer
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
        //
        // Swipe
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(swipeGestureRight))
        view.addGestureRecognizer(rightSwipe)
//        let rightSwipe = UISwipeGestureRecognizer()
//        rightSwipe.direction = .right
//        rightSwipe.addTarget(self, action: #selector(swipeGestureRight))
    }
    
    //
    // drawGraph() Helper Functions --------------------------------------------------------------------------------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------------
    // Get Chart Points
    func returnChartPoints() -> [ChartPoint] {
        //
        // Format Date
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        //
        switch selectedTimeScale {
        // Week
        case 0:
            let chartData = weekTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            //
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        // 1 Month, 3 Months, 6 Months
        case 1,2,3:
            //
            // To get data from
            let calendar = Calendar(identifier: .gregorian)
            let keys = trackingDictionary.keys.sorted()
            // To put data in (so only 1 month presented)
            var chartData: [(key: Date, value: Int)] = []
            //
            // Add relevant daya to chartData Array
            var startDate = Date()
            // Start Date for 1, 3, 6 months
            switch selectedTimeScale {
            case 1:
                if keys.contains(Date().firstMondayInMonth) {
                    startDate = Date().firstMondayInMonth
                } else {
                    startDate = keys.first!
                }
            case 2:
                startDate = calendar.date(byAdding: .month, value: -2, to: Date().firstMondayInMonth)!
                if keys.contains(startDate) == false {
                    startDate = keys.first!
                }
            case 3:
                startDate = calendar.date(byAdding: .month, value: -5, to: Date().firstMondayInMonth)!
                if keys.contains(startDate) == false {
                    startDate = keys.first!
                }
            default: break
            }
            let endDate = keys.last!
            // Loop adding data to chartData
            while startDate <= endDate {
                let value = trackingDictionary[startDate]!
                let tupleToAdd = (key: startDate, value: value)
                chartData.append(tupleToAdd)
                startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
            }
            
            let chartPoints: [ChartPoint] = (chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))})
            return chartPoints
            
        // Last year
        case 4:
            
            //
            // To get data from
            let calendar = Calendar(identifier: .gregorian)
            let keys = monthTrackingDictionary.keys.sorted()
            // To put data in (so only 1 month presented)
            var chartData: [(key: Date, value: Int)] = []
            //
            // Add relevant data to chartData Array
            var startDate = calendar.date(byAdding: .year, value: -1, to: Date().firstDateInCurrentMonth)!
            let endDate = keys.last!
            // Loop adding data to chartData
            while startDate <= endDate {
                let tupleToAdd = (key: startDate, value: monthTrackingDictionary[startDate]!)
                chartData.append(tupleToAdd)
                startDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
            }
            
            let chartPoints: [ChartPoint] = (chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))})
            return chartPoints
        
        // All
        case 5:
            let chartData = monthTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            //
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
        //
        default:
            //
            let chartData = monthTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        }
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
            // Fill in empty values if there are any (if current day isn't sunday)
            if xValues.count != 7 {
                // Number of empty days to add
                let numberToAdd = 7 - xValues.count
                let keys = weekTrackingDictionary.keys.sorted()
                for i in 1...numberToAdd {
                    let dateToAdd = Calendar.current.date(byAdding: .day, value: i, to: keys.last!)
                    let valueToAdd = ChartAxisValueDate(date: dateToAdd!, formatter: df)
                    xValues.append(valueToAdd)
                }
            }
            
            return xValues

        //
        // 1 Month, 3 Months, 6 Months
        case 1,2,3:
            //
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}

            // To get data from
            let calendar = Calendar(identifier: .gregorian)
            let keys = trackingDictionary.keys.sorted()
            //
            // Add empty xvalues before if necessart
            var startDate = Date()
            var endDate = Date()
            
            //
            // Fill empty values before first date if neccessary (the user might have started within the selected timescale)
            //
            // lastweek - 1
            endDate = calendar.date(byAdding: .weekOfYear, value: -1, to: keys.first!)!
            // Start Date for 1, 3, 6 months
            switch selectedTimeScale {
            case 1:
                startDate = Date().firstDateInCurrentMonth
                if keys.contains(startDate) == false {
                    xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
                }
            case 2:
                startDate = calendar.date(byAdding: .month, value: -2, to: Date().firstDateInCurrentMonth)!
                if keys.contains(startDate) == false {
                    xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
                }
            case 3:
                startDate = calendar.date(byAdding: .month, value: -5, to: Date().firstDateInCurrentMonth)!
                if keys.contains(startDate) == false {
                    xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
                }
            default: break
            }
            
            
            //
            // Fill emtpy values after first date if neccessary (the current date wont always be last date in month)
            //
            // Start date is 1 after last monday added
            startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: keys.last!)!
            // firstmonday + ((numberofmondaysincurrentmonth - 1) * weeks) = lastmonday
            let toAdd = Date().numberOfMondaysInCurrentMonth - 1
            let test = Date().firstMondayInMonth
            let test2 = Date().firstMondayInCurrentWeek
            endDate = calendar.date(byAdding: .weekOfYear, value: toAdd, to: Date().firstMondayInMonth)!
            // Start Date for 1, 3, 6 months
            switch selectedTimeScale {
            case 1:
                if keys.contains(endDate) == false {
                    xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
                }
            case 2:
                if keys.contains(endDate) == false {
                    xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
                }
            case 3:
                if keys.contains(endDate) == false {
                    xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
                }
            default: break
            }
            
            
            return xValues
            
            
        // 12 Months
        case 4:
            //
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            
            // To get data from
            let calendar = Calendar(identifier: .gregorian)
            let keys = monthTrackingDictionary.keys.sorted()
            //
            // Add empty xvalues before if necessart
            var startDate = Date()
            var endDate = Date()
            
            //
            // Fill empty values before first date if neccessary (the user might have started within the selected timescale)
            //
            // Add empty xvalues before if necessary
            // lastweek - 1
            endDate = calendar.date(byAdding: .weekOfYear, value: -1, to: keys.first!)!
            //
            startDate = calendar.date(byAdding: .month, value: -11, to: Date().firstDateInCurrentMonth)!
            if keys.contains(startDate) == false {
                xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
            }
            
            
            //
            // Fill emtpy values after first date if neccessary (the current date wont always be last date in month)
            //
            // Add empty xvalues After if necessary
            startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: Date().firstMondayInMonth)!
            // firstmonday + ((numberofmondaysincurrentmonth - 1) * weeks) = lastmonday
            let toAdd = Date().numberOfMondaysInCurrentMonth - 1
            endDate = calendar.date(byAdding: .weekOfYear, value: toAdd, to: Date().firstMondayInMonth)!
            //
            if keys.contains(endDate) == false {
                xValues = fillEmptyValues(startDate: startDate, endDate: endDate, xValues: xValues)
            }
            
            return xValues
            
            
        // All
        case 5:
            let xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            return xValues
        //
        default:
            let xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            return xValues
        }
    }
    
    
    
    // Fill empty xvalues if user started less that 1,3,6 months ago
    func fillEmptyValues(startDate: Date, endDate: Date, xValues: [ChartAxisValue]) -> [ChartAxisValue] {
        //
        let calendar = Calendar(identifier: .gregorian)
        // Need a mutable start date
        var startDate2 = startDate
        var updatedXValues = xValues
        //
        // Format Date
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        // Loop adding data to chartData
        while startDate2 < endDate {
            let dateToAdd = ChartAxisValueDate(date: startDate, formatter: df)
            updatedXValues.append(dateToAdd)
            //
            startDate2 = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate2)!
        }
        //
        return updatedXValues
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
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            
            let df2 = DateFormatter()
            df2.dateFormat = " dd"
            
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
            return self.view.bounds.height - TopBarHeights.combinedHeight
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
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
        
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["tracking0", "tracking1"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    func walkthroughTracking() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughTracking), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour2
            walkthroughLabel.backgroundColor = colour1
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width - 15, height: 20)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: TopBarHeights.combinedHeight + 12.25 + ((view.bounds.height - 73.5) * (25/125)))
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Menu
        case 1:
            //
            highlightSize = CGSize(width: 36, height: 36)
            let barButtonItem = self.navigationItem.rightBarButtonItem!
            let buttonItemView = barButtonItem.value(forKey: "view") as? UIView
            highlightCenter = CGPoint(x: (buttonItemView?.center.x)!, y: (buttonItemView?.center.y)! + TopBarHeights.statusBarHeight)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                walkthroughs[6] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
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



private class InfoView: UIView {
    
    let statusView: UIView
    
    let dateLabel: UILabel
    let percentageTextLabel: UILabel
    
    
    override init(frame: CGRect) {
        
        let itemHeight: CGFloat = 40
        let y = (frame.height - itemHeight) / CGFloat(2)
        
        statusView = UIView(frame: CGRect(x: 0, y: y, width: itemHeight, height: itemHeight))
        statusView.layer.borderColor = UIColor.black.cgColor
        statusView.layer.borderWidth = 1
        statusView.layer.cornerRadius = 8
        
        let font = UIFont(name: "SFUIDisplay-light", size: 17)
        
        dateLabel = UILabel()
        dateLabel.font = font
        
        percentageTextLabel = UILabel()
        percentageTextLabel.font = font
        
        super.init(frame: frame)
        
        addSubview(statusView)
        addSubview(dateLabel)
        addSubview(percentageTextLabel)
    }
    
    fileprivate override func didMoveToSuperview() {
        
        let views = [statusView, dateLabel, percentageTextLabel]
        for v in views {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let namedViews = views.enumerated().map{index, view in
            ("v\(index)", view)
        }
        
        var viewsDict = Dictionary<String, UIView>()
        for namedView in namedViews {
            viewsDict[namedView.0] = namedView.1
        }
        
        let circleDiameter: CGFloat = 15
        let labelsSpace: CGFloat = 5
        
        let hConstraintStr = namedViews[1..<namedViews.count].reduce("H:|[v0(\(circleDiameter))]") {str, tuple in
            "\(str)-(\(labelsSpace))-[\(tuple.0)]"
        }
        
        let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraints(withVisualFormat: "V:|-(18)-[\($0.0)(\(circleDiameter))]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)}
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraintStr, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)
            + vConstraits)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showChartPoint(_ chartPoint: ChartPoint) {
        statusView.backgroundColor = colour2
        dateLabel.text = chartPoint.x.labels.first?.text ?? ""
        percentageTextLabel.text = "\(chartPoint.y)"
    }
    
    func clear() {
        statusView.backgroundColor = UIColor.clear
    }
}


private class InfoWithIntroView: UIView {
    
    var introView: UIView!
    var infoView: InfoView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate override func didMoveToSuperview() {
        let label = UILabel(frame: CGRect(x: 0, y: bounds.origin.y, width: bounds.width, height: bounds.height))
        label.text = "Drag the line to see chartpoint data"
        label.font = UIFont(name: "SFUIDisplay-light", size: 17)
        label.backgroundColor = UIColor.white
        introView = label
        
        infoView = InfoView(frame: bounds)
        
        addSubview(infoView)
        addSubview(introView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func animateIntroAlpha(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.introView.alpha = alpha
        })
    }
    
    func showChartPoint(_ chartPoint: ChartPointCandleStick) {
        animateIntroAlpha(0)
        infoView.showChartPoint(chartPoint)
    }
    
    func clear() {
        animateIntroAlpha(1)
        infoView.clear()
    }
}


