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
class TrackingScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
//UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    fileprivate var chart: Chart?
    
    var menuSwipeView = UIView()
    
    // Time Scale Action Sheet
    let timeScaleTable = UITableView()
    
    let timeScaleArray: [String] = ["1week", "1month", "3months", "6months", "1year", "all"]
    
    var selectedTimeScale = 0
    
    //
    var timeScaleButton2 = UIButton()

    //
    var trackingDictionariesDates: [[Date: Int]] = []
    
    //
    // View Will Appear ---------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // TimeScale Button2
        var yValue = CGFloat()
        // iPhone X
        if IPhoneType.shared.iPhoneType() == 2 {
            yValue = view.frame.maxY - 49 - 34
        // Normal iPhone
        } else {
            yValue = view.frame.maxY - 49
        }
        timeScaleButton2.frame = CGRect(x: 0, y: yValue, width: view.bounds.width, height: 49)
        timeScaleButton2.backgroundColor = .clear
        timeScaleButton2.addTarget(self, action: #selector(timeScaleButton(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow?.insertSubview(timeScaleButton2, aboveSubview: view)
        
    }
    
    
    func testTrackingValues() {
        let calendar = Calendar(identifier: .gregorian)
        //
        var trackingDictionaries = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
        trackingDictionaries[0] = [:]
        trackingDictionaries[0].updateValue(20, forKey: TrackingHelpers.shared.dateToString(date: Date().firstMondayInMonth))

        //
        trackingDictionaries[1] = [:]
        var firstMondayLastMonth = calendar.date(byAdding: .month, value: -1, to: Date().currentDate)!
        firstMondayLastMonth = firstMondayLastMonth.firstMondayInMonth
        //
        trackingDictionaries[1].updateValue(70, forKey: TrackingHelpers.shared.dateToString(date: firstMondayLastMonth))
        trackingDictionaries[1].updateValue(90, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 1, to: firstMondayLastMonth)!))
        trackingDictionaries[1].updateValue(70, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 2, to: firstMondayLastMonth)!))
        trackingDictionaries[1].updateValue(80, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 3, to: firstMondayLastMonth)!))
        
        UserDefaults.standard.set(trackingDictionaries, forKey: "trackingDictionaries")
        ICloudFunctions.shared.pushToICloud(toSync: ["trackingDictionaries"])
        
    }
    
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ensure week goal correct
        updateWeekGoal()
        
        // Create [[Date: Int]] from the stored [[String: Int]] (Icloud wont store [Date: Int], only [String: Int])
        let trackingDictionaries = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
        trackingDictionariesDates = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionaries)
        
        // Tests !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        testTrackingValues()
        updateWeekTracking()
        updateTracking()
        
        // Present walkthrough 2
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Tracking"] == false {
            walkthroughTracking()
        }
       
        // Time scale table
        timeScaleTable.dataSource = self
        timeScaleTable.delegate = self
        timeScaleTable.tableFooterView = UIView()
        timeScaleTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        timeScaleTable.separatorColor = Colours.colour1.withAlphaComponent(0.5)
        timeScaleTable.backgroundColor = Colours.colour2
        timeScaleTable.layer.cornerRadius = 15
        timeScaleTable.clipsToBounds = true
        timeScaleTable.layer.borderWidth = 1
        timeScaleTable.layer.borderColor = Colours.colour1.cgColor
        timeScaleTable.isScrollEnabled = false
        timeScaleTable.frame = CGRect(x: 0, y: 0, width: ActionSheet.shared.actionSheet.bounds.width, height: 7 * 47)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(timeScaleTable)
        let heightToAdd = timeScaleTable.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()

        //
        //
        // Navigation Controller
        self.navigationController?.navigationBar.barTintColor = Colours.colour2
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
        
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: false)
        
        if trackingDictionaries[0].count != 0 {
            drawGraph()
        } else {
            let warningLabel = UILabel()
            warningLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            warningLabel.text = NSLocalizedString("trackingWarning", comment: "")
            warningLabel.textAlignment = .center
            warningLabel.textColor = Colours.colour1
            warningLabel.sizeToFit()
            warningLabel.center = CGPoint(x: view.center.x, y: view.center.y - 44)
            view.addSubview(warningLabel)
            view.bringSubview(toFront: warningLabel)
        }
    }
    
    //
    // MARK: Graphs
    //
    var currentPositionLabels: [UILabel] = []
    var currentPositionLabel = UILabel()
    
    //
    func drawGraph() {
        //
        // Axis Label Settings
        var titleLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 17)!)
        titleLabelSettings.fontColor = Colours.colour1
        //
        var axisLabelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 14)!)
        axisLabelSettings.fontColor = Colours.colour1
        
        //
        // Generators
        // X generator for numbers
        let generator = returnChartAxisGeneratorMultiplier()
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        //
        
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
        
        let yModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: 0, lastModelValue: 125, axisValuesGenerator: generator, labelsGenerator: labelsGenerator2)
        
        //
        // Chart Settings
        let height = returnChartHeight()
        let chartFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: height)
        //
        var chartSettings = ChartSettings()
        chartSettings.leading = 8.25
        chartSettings.top = 24.5
        chartSettings.trailing = 12.25
        // iPhone X
        if IPhoneType.shared.iPhoneType() == 2 {
            chartSettings.bottom = 34 + 10
        // Normal iPhone
        } else {
            chartSettings.bottom = 10
        }
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
        let guideLinesHighlightLayerSettings = ChartGuideLinesLayerSettings(linesColor: Colours.colour3, linesWidth: 0.5)
        let guideLinesHighlightLayer = ChartGuideLinesForValuesLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, settings: guideLinesHighlightLayerSettings, axisValuesX: [], axisValuesY: [ChartAxisValueDouble(100)])
        
        //
        // Line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: Colours.colour4, animDuration: 1.0, animDelay: 0)
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
            circleView.fillColor = Colours.colour4
            return circleView
        }
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05, mode: .translate)
        
        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: 50, thumbBorderWidth: 4)
//        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings)
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings.init(thumbSettings: thumbSettings, selectNearest: true)
        
        var currentPositionLabels: [UILabel] = []
        
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints], lineColor: Colours.colour2, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) { chartPointsWithScreenLoc in
            
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
                label.sizeToFit()
                // Put to left of line if no room
                if (chartPointWithScreenLoc.screenLoc.x + label.frame.width) > self.view.frame.maxX {
                    label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x - label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                // Right of line if room
                } else {
                    label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                }
                
                
                label.backgroundColor = Colours.colour2
                label.textColor = Colours.colour1
                
                currentPositionLabels.append(label)
                self.view.addSubview(label)
            }
        }
        
        
        //
        // Finalise ----------------------------
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
            let dividersSettings =  ChartDividersLayerSettings(linesColor: Colours.colour1, linesWidth: 0.5, start: length, end: 0)
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
        // Menu Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        menuSwipeView.backgroundColor = .clear
        menuSwipeView.frame = CGRect(x: 0, y: 0, width: 8.25, height: view.bounds.height)
        menuSwipeView.addGestureRecognizer(rightSwipe)
        view.addSubview(menuSwipeView)
        view.bringSubview(toFront: menuSwipeView)
        
    }
    
    //
    // MARK: drawGraph() Helper Functions --------------------------------------------------------------------------------------------------------------------------------------------------------
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
            let chartData = trackingDictionariesDates[0].sorted(by: { $0.key < $1.key })
            //
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        // 1 Month, 3 Months, 6 Months
        case 1,2,3,4,5:
            //
            let chartData = trackingDictionariesDates[1].sorted(by: { $0.key < $1.key })
            //
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
            
        //
        default:
            //
            let chartData = trackingDictionariesDates[1].sorted(by: { $0.key < $1.key })
            //
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
        axisLabelSettings.fontColor = Colours.colour1
        
        // Values
        switch selectedTimeScale {
        // Week
        case 0:
            //
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            //
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            let monday = Date().firstMondayInCurrentWeek
            for i in 0...6 {
                let calendar = Calendar(identifier: .gregorian)
                let dateToAdd = calendar.date(byAdding: .day, value: i, to: monday)
                let valueToAdd = ChartAxisValueDate(date: dateToAdd!, formatter: df)
                xValues.append(valueToAdd)
            }
            
            return xValues

            //
        // 1 Month, 3 Months, 6 Months
        case 1,2,3:
            //
            var xValues: [ChartAxisValue] = []
            
            // To get data from
            let calendar = Calendar(identifier: .gregorian)
            //
            var startDate = Date().currentDate
            let endDate = calendar.date(byAdding: .weekOfYear, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
            
            switch selectedTimeScale {
            case 1:
                startDate = Date().firstMondayInMonth
            case 2:
                startDate = calendar.date(byAdding: .month, value: -2, to: Date().currentDate)!
                startDate = startDate.firstMondayInMonth
            case 3:
                startDate = calendar.date(byAdding: .month, value: -5, to: Date().currentDate)!
                startDate = startDate.firstMondayInMonth
            default: break
            }

            //
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            //
            while startDate <= endDate! {
                let valueToAdd = ChartAxisValueDate(date: startDate, formatter: df)
                xValues.append(valueToAdd)
                startDate = calendar.date(byAdding: .hour, value: 168, to: startDate)!
            }
            //
            return xValues
            
        // Current year
        case 4:
            //
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            
            // To get data from
            let calendar = Calendar(identifier: .gregorian)
            //
            // Add empty xvalues before if necessart
            var startDate = Date().firstDateInYear
            var endDate = calendar.date(byAdding: .month, value: 11, to: startDate)
            endDate = endDate?.firstDateInMonth
            
            //
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            //
            while startDate <= endDate! {
                let calendar = Calendar(identifier: .gregorian)
                let valueToAdd = ChartAxisValueDate(date: startDate, formatter: df)
                xValues.append(valueToAdd)
                startDate = calendar.date(byAdding: .hour, value: 168, to: startDate)!
            }
            
            return xValues
        
        // All
        case 5:
            var xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            //
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            //
            if xValues.count == 1 {
                let keys = trackingDictionariesDates[1].keys.sorted()
                let valueToAdd = ChartAxisValueDate(date: keys.first!, formatter: df)
                xValues.append(valueToAdd)
            }
            return xValues
        //
        default:
            let xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints).array as! [ChartPoint]).map{$0.x}
            return xValues
        }
    }
    
    // --------------------------------------------------------------------------------------
    // Get xAxis Model
    func returnXAxisModel(xAxisValues: [ChartAxisValue], titleLabelSettings: ChartLabelSettings, axisLabelSettings: ChartLabelSettings, xAxisTitle: String, generator: ChartAxisGeneratorMultiplier) -> ChartAxisModel {
        // Parameters
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        //
        
        //
        switch selectedTimeScale {
        // Week
        case 0:
            // Date formatter
            let df = DateFormatter()
            df.dateFormat = "EEE"
            //
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: axisLabelSettings, formatter: df)
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .day, preferredDividers: 6, minSpace: 0, maxTextSize: 12)
            
            // Dates
            let firstDate = Date().firstMondayInCurrentWeek
            let calendar = Calendar(identifier: .gregorian)
            let lastDate = calendar.date(byAdding: .day, value: 6, to: firstDate)
            
            let xModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: firstDate.timeIntervalSince1970, lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
            
        // Month
        case 1:
            // Date formatter
            let df2 = DateFormatter()
            df2.dateFormat = " dd"
            
            let xLabelGenerator = ChartAxisLabelsGeneratorDate(labelSettings: axisLabelSettings, formatter: df2)
            //
            let nDividers = xAxisValues.count - 1
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .day, preferredDividers: nDividers, minSpace: 0, maxTextSize: 12)
            
            //
            let firstDate = Date().firstMondayInMonth
            let calendar = Calendar(identifier: .gregorian)
            let lastDate = calendar.date(byAdding: .weekOfMonth, value: Date().numberOfMondaysInCurrentMonth - 1, to: firstDate)
            
            let xModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: (firstDate.timeIntervalSince1970), lastModelValue: (lastDate?.timeIntervalSince1970)!, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator)
            
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
            
            let calendar = Calendar(identifier: .gregorian)
            //
            var startDate = calendar.date(byAdding: .month, value: -2, to: Date().currentDate)!
            startDate = startDate.firstMondayInMonth
            let endDate = calendar.date(byAdding: .weekOfMonth, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
            
            let xModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: startDate.timeIntervalSince1970, lastModelValue: (endDate?.timeIntervalSince1970)!, axisTitleLabels: [], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator)
            
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
            
            let calendar = Calendar(identifier: .gregorian)
            //
            var startDate = calendar.date(byAdding: .month, value: -5, to: Date().currentDate)!
            startDate = startDate.firstMondayInMonth
            let endDate = calendar.date(byAdding: .weekOfMonth, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
            
            //
            let xModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: startDate.timeIntervalSince1970, lastModelValue: (endDate?.timeIntervalSince1970)!, axisTitleLabels: [], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator)
            
            return xModel
            
        // 12 Months
        case 4:
            // Date formatter
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
            
            let calendar = Calendar(identifier: .gregorian)
            //
            let startDate = Date().firstDateInYear
            var endDate = calendar.date(byAdding: .month, value: 11, to: startDate)
            endDate = endDate?.firstDateInMonth
            
            //
            let xModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: startDate.timeIntervalSince1970, lastModelValue: (endDate?.timeIntervalSince1970)!, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, trailingPadding: ChartAxisPadding.label)
            
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
            //
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .quarter, preferredDividers: 4, minSpace: 0, maxTextSize: 12)
            
            //
            let keys = trackingDictionariesDates[1].keys.sorted()
            let startDate = keys.first!
            var endDate = keys.last!
            if keys.count == 1 {
                let calendar = Calendar(identifier: .gregorian)
                endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
            }
            
            
            let xModel = ChartAxisModel(lineColor: Colours.colour1, firstModelValue: startDate.timeIntervalSince1970, lastModelValue: endDate.timeIntervalSince1970, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], axisValuesGenerator: xValuesRangedGenerator, labelsGenerator: xLabelGenerator, trailingPadding: ChartAxisPadding.label)
            
            return xModel
            
        //
        default:
            let xModel = ChartAxisModel(axisValues: xAxisValues, lineColor: Colours.colour1, axisTitleLabels: [ChartAxisLabel(text: xAxisTitle, settings: titleLabelSettings)], leadingPadding: ChartAxisPadding.label, trailingPadding: ChartAxisPadding.label)
            return xModel
        }
    }
    
    // --------------------------------------------------------------------------------------
    // Get xAxis Title
    func returnAxisTitle(xValues : [ChartAxisValue]) -> String {
        //
        // x axis title
        switch selectedTimeScale {
        // 1 Week
        case 0:
            return NSLocalizedString("currentWeek", comment: "")
        // 1 Month
        case 1:
            let df = DateFormatter()
            df.dateFormat = "MMMM"
            let month = df.string(from: Date().firstMondayInMonth)
            return month
        // Last year
        case 4:
            let df = DateFormatter()
            df.dateFormat = "yyyy"
            let year = df.string(from: Date().firstDateInYear)
            return year
            
        // All year
        case 5:
            //
            let df = DateFormatter()
            df.dateFormat = "MM.yyyy"
            let keys = trackingDictionariesDates[1].keys.sorted()
            let firstString = df.string(from: keys.first!)
            let lastString = df.string(from: keys.last!)
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
    // MARK: Table View
    // Sections
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Section Titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("trackingScreenTimeScaleOption", comment: "")
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = Colours.colour2
        //
        let background = UIView()
        background.frame = header.bounds
        background.backgroundColor = Colours.colour1
        header.backgroundView = background
    }
    

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeScaleArray.count
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
        cell.textLabel?.text = NSLocalizedString(timeScaleArray[indexPath.row], comment: "")
        cell.textLabel?.textColor = Colours.colour1
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = Colours.colour2
        if indexPath.row == selectedTimeScale {
            cell.accessoryType = .checkmark
            cell.tintColor = Colours.colour3
            cell.textLabel?.textColor = Colours.colour3
        }
        if indexPath.row == timeScaleArray.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        return cell
    }
    
    //
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If data is available
        if trackingDictionariesDates[0].count != 0 {
            //
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            //
            selectedTimeScale = indexPath.row
            //
            chart?.view.removeFromSuperview()
            drawGraph()
            // No data to display
        } else {
            selectedTimeScale = indexPath.row
        }
        //
        timeScaleTable.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            // Dismiss action sheet
            ActionSheet.shared.animateActionSheetDown()
            //
        })
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //
    @IBAction func timeScaleButton(_ sender: Any) {
        ActionSheet.shared.animateActionSheetUp()
    }
    
    //
    // Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    
    // Elements
    //
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
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
    @objc func walkthroughTracking() {
        
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
            walkthroughLabel.textColor = Colours.colour2
            walkthroughLabel.backgroundColor = Colours.colour1
            walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colours.colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width - 15, height: 20)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: TopBarHeights.combinedHeight + 12.25 + ((view.bounds.height - 73.5) * (25/125)))
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0)
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
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
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
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Tracking"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
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
