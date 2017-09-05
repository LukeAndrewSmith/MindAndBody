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
        drawGraph()
        
        //
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGestureRight))
        
        swipeGestureView.backgroundColor = .clear
        swipeGestureView.bounds = view.bounds
        swipeGestureView.addGestureRecognizer(rightSwipe)
        swipeGestureView.isUserInteractionEnabled = true
        
        view.addSubview(swipeGestureView)
        view.bringSubview(toFront: swipeGestureView)
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
        let firstModelValueX = returnFirstModelValueX()
        let lastModelValueX = returnLastModelValueX()
        let xValues = returnAxisValues(chartPoints: chartPoints)
        let xAxisTitle = returnAxisTitle()
        let xModel = returnXAxisModel(xAxisValues: xValues, firstModelValue: firstModelValueX, lastModelValue: lastModelValueX, titleLabelSettings: titleLabelSettings, axisLabelSettings: axisLabelSettings, xAxisTitle: xAxisTitle, generator: generator)
        
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
        
        var currentPositionLabels: [UILabel] = []
        
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints], lineColor: colour2, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
            
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.sizeToFit()
                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                
                label.backgroundColor = colour2
                label.textColor = colour1
                
                currentPositionLabels.append(label)
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
            let dividersSettings =  ChartDividersLayerSettings(linesColor: UIColor.white, linesWidth: 0.5, start: 30, end: 0)
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
        view.bringSubview(toFront: swipeGestureView)
    }
    
    //
    // drawGraph() Helper Functions ------------------------------
    //
    // Get Chart Points
    func returnChartPoints() -> [ChartPoint] {
        switch selectedTimeScale {
        // Week
        case 0:
            //
            let chartData = weekTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        // Month
        case 1:
            let chartData = trackingDictionary[currentYear]?[currentMonth]?.sorted(by: { $0.0.key < $0.1.key })
            let chartPoints: [ChartPoint] = (chartData?.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))})!
            return chartPoints
            
        // 3 Months
        case 2:
            // Test
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            //test
            var chartPoints: [ChartPoint] = []

            for i in (0...2).reversed() {
                // All in same year
                if currentMondayDate > 2 {
                    for j in 0...(trackingDictionary[currentYear]?[currentMonth - i]?.count)! - 1 {
                        // Get array of dates sorted
                        var toConvertArray = trackingDictionary[currentYear]?[currentMonth - i]?.sorted(by: { $0.0.key < $0.1.key })
                        var toAddValue = toConvertArray?[j].value
                        
                        // Get array of month keys sorted
                        var toConvertKeys = trackingDictionary[currentYear]?[currentMonth - i]?.keys.sorted()
                        // Get month as string + .
                        let toAddMonth = "." + String(currentMonth - i)
                        // Get year as string + .
                        let toAddYear = "." + String(currentYear)
                        // Get day as string
                        let toConvertString = toConvertKeys?[j]
                        var toAddDayString: String = String(toConvertString!)
                        // Format date as "dd.MM"
                        let toAddDateString = toAddDayString + toAddMonth + toAddYear
                        let toAddDate = dfConvert.date(from: toAddDateString)!
                        // Create Chart Point and add to chartPoints + make x axis values labels clear
                        let clearLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!, fontColor: .clear)
                        let chartPointToAdd = ChartPoint(x: ChartAxisValueDate(date: toAddDate, formatter: dfConvert, labelSettings: clearLabelSettings), y: ChartAxisValueInt(toAddValue!))
                        chartPoints.append(chartPointToAdd)
                    }
                    
                    
                // Not in same year
                } else {
                    
                }
            }
            
            return chartPoints
            
        default:
            //
            let chartData = weekTrackingDictionary.sorted(by: { $0.0.key < $0.1.key })
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        }
    }
    
    // Return first and last model values
    func returnFirstModelValueX() -> Double {
        switch selectedTimeScale {
        case 0:
            let firstModelValuex = Double(weekTrackingDictionary.keys.sorted().first!)
            return firstModelValuex
        case 1:
            let firstModelValuex = Double((trackingDictionary[currentYear]?[currentMonth]?.keys.sorted().first)!)
            return firstModelValuex
        
        default:
            let firstModelValuex = Double(weekTrackingDictionary.keys.sorted().first!)
            return firstModelValuex
        }
    }
    //
    func returnLastModelValueX() -> Double {
        switch selectedTimeScale {
        case 0:
            let firstModelValuex = Double(weekTrackingDictionary.keys.sorted().first!)
            let lastModelValuex = firstModelValuex + Double(6)
            return lastModelValuex
        case 1:
            let firstModelValuex = Double((trackingDictionary[currentYear]?[currentMonth]?.keys.sorted().first)!)
            let numberOfMondaysToAdd = numberOfMondaysInMonth(currentMonth, forYear: currentYear)! - 1
            let lastModelValuex = firstModelValuex + Double(numberOfMondaysToAdd * 7)
            return lastModelValuex
        default:
            let firstModelValuex = Double(weekTrackingDictionary.keys.sorted().first!)
            let lastModelValuex = firstModelValuex + Double(6)
            return lastModelValuex
        }
    }
    
    // Get Generator
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
        // 1 month doesn't use axis values
        // 3 Month
        case 2:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            
            // Check last month has all keys even if no value pair is associated with it, if not fill in necessary mondays
            let mondayKeys = trackingDictionary[currentYear]?[currentMonth]?.keys.sorted()
            let numberOfMondays = numberOfMondaysInMonth(currentMonth, forYear: currentYear)
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
                    let toAddMonth = "." + String(currentMonth)
                    // Get year as string + .
                    let toAddYear = "." + String(currentYear)
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
                    xValues.append(xValuesToAdd[i])
                }
            }
            
            return xValues
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
    // Get xAxis Model
    func returnXAxisModel(xAxisValues: [ChartAxisValue], firstModelValue: Double, lastModelValue: Double, titleLabelSettings: ChartLabelSettings, axisLabelSettings: ChartLabelSettings, xAxisTitle: String, generator: ChartAxisGeneratorMultiplier) -> ChartAxisModel {
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
            let xModel = ChartAxisModel(axisValues: xAxisValues, lineColor: colour1, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
            
        // Month
        case 1:
            let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: firstModelValue, lastModelValue: lastModelValue, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: generator, labelsGenerator: labelsGenerator, leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
           
        // 3 Month
        case 2:
            // Date formatters
            let dfConvert = DateFormatter()
            dfConvert.dateFormat = "dd.MM.yyyy"
            
            let df2 = DateFormatter()
            df2.dateFormat = "MMMM"
            
            // Generators
            var titleLabelSettings2 = titleLabelSettings
            titleLabelSettings2.textAlignment = .right
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: titleLabelSettings2, formatter: df2)
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .month, preferredDividers: 2, minSpace: 30, maxTextSize: 12)
            
            //
            let firstDateString: String = String(describing: xAxisValues.first!)
            let firstDate = dfConvert.date(from: firstDateString)
            let lastDateString: String = String(describing: xAxisValues.last!)
            let lastDate = dfConvert.date(from: lastDateString)
            let xModel = ChartAxisModel(lineColor: UIColor.white, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            
            return xModel

        // 6 Month
//        case 3:
        //
        default:
            let xModel = ChartAxisModel(axisValues: xAxisValues, lineColor: colour1, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
        }
    }
//    // Get axis model 2 for ranged graph bars
//    func returnXAxisModel2(xAxisValues: [ChartAxisValue], firstModelValue: Double, lastModelValue: Double, titleLabelSettings: ChartLabelSettings, axisLabelSettings: ChartLabelSettings, xAxisTitle: String, generator: ChartAxisGeneratorMultiplier) -> ChartAxisModel {
//        //
//        switch selectedTimeScale {
//        // 3 Month
//        case 2:
//            //
//            let rangeSize: Double = 30.42
//            let rangedMult: Double = rangeSize / 2
//            
//            // Number Formatter
//            let formatter = NumberFormatter()
//            formatter.maximumFractionDigits = 0
//            
//            // Date formatters
//            let dfConvert = DateFormatter()
//            dfConvert.dateFormat = "dd.MM.yyyy"
//            
//            let df2 = DateFormatter()
//            df2.dateFormat = "MMMM"
//            
//            // Generators
//            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: titleLabelSettings, formatter: df2)
//            
//            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .month, preferredDividers: 2, minSpace: 1, maxTextSize: 12)
//       
//            let firstDateString: String = String(describing: xAxisValues.first!)
//            let firstDate = dfConvert.date(from: firstDateString)
//            let lastDateString: String = String(describing: xAxisValues.last!)
//            let lastDate = dfConvert.date(from: lastDateString)
//            
//            let xEmptyLabelsGenerator = ChartAxisLabelsGeneratorFunc {value in return
//                ChartAxisLabel(text: "", settings: titleLabelSettings)
//            }
//            
//            let xValuesGuidelineGenerator = ChartAxisGeneratorMultiplier(rangeSize)
//            let xModelForGuidelines = ChartAxisModel(lineColor: UIColor.white, firstModelValue: (firstDate?.timeIntervalSince1970)!, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xEmptyLabelsGenerator)
//        
//            return xModelForGuidelines
//            
//        //
//        default:
//            break
//        }
//        let xModel = ChartAxisModel(axisValues: xAxisValues, lineColor: colour1, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
//        return xModel
//    }
    
    
    //
    // Get xAxis Title
    func returnAxisTitle() -> String {
        //
        let monthArray = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
        // x axis title
        switch selectedTimeScale {
        // 1 Week
        case 0:
            var addOn = String()
            switch weekTrackingDictionary.keys.sorted().first! {
            case 1: addOn = NSLocalizedString("st", comment: "")
            case 2: addOn = NSLocalizedString("nd", comment: "")
            case 3: addOn = NSLocalizedString("rd", comment: "")
            default: addOn = NSLocalizedString("th", comment: "")
            }
            //let xAxisTitle: String = NSLocalizedString("weekOfThe", comment: "") + "\(Int(firstModelValuex))" + addOn
            return NSLocalizedString("currentWeek", comment: "")
        // 1 Month
        case 1:
            // -1 because array starts at 0
            let month = NSLocalizedString(monthArray[currentMonth - 1], comment: "")
            return month
        //
        default: return ""
        }
    }

    //
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
        //
        selectedTimeScale = timeScalePickerView.selectedRow(inComponent: 0)
        //
        animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
        //
        chart?.view.removeFromSuperview()
        drawGraph()
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
