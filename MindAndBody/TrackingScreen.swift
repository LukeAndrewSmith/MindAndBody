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
        actionSheet.backgroundColor = Colours.colour1
        actionSheet.layer.cornerRadius = 15
        actionSheet.clipsToBounds = true
        
        //
        // Picker
        timeScalePickerView.backgroundColor = Colours.colour2
        timeScalePickerView.delegate = self
        timeScalePickerView.dataSource = self
        timeScalePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 147)
        
        // ok
        okButton.backgroundColor = Colours.colour1
        okButton.setTitleColor(Colours.colour3, for: .normal)
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
        self.navigationController?.navigationBar.barTintColor = Colours.colour2
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        
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
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
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
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        if weekTrackingDictionary.count != 0 {
            drawGraph()
        } else {
            let warningLabel = UILabel()
            warningLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            warningLabel.text = NSLocalizedString("trackingWarning", comment: "")
            warningLabel.textAlignment = .center
            warningLabel.textColor = Colours.colour1
            warningLabel.sizeToFit()
            warningLabel.center = CGPoint(x: backgroundImage.center.x, y: backgroundImage.center.y - 44)
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
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
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
            let chartData = weekTrackingDictionary.sorted(by: { $0.key < $1.key })
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
            // Add relevant data to chartData Array
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
            var startDate = calendar.date(byAdding: .year, value: -1, to: Date().firstDateInMonth)!
            if keys.contains(startDate) == false {
                startDate = keys.first!
            }
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
            let chartData = monthTrackingDictionary.sorted(by: { $0.key < $1.key })
            //
            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
            return chartPoints
        //
        default:
            //
            let chartData = monthTrackingDictionary.sorted(by: { $0.key < $1.key })
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
            var startDate = Date()
            let endDate = calendar.date(byAdding: .weekOfMonth, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
            
            switch selectedTimeScale {
            case 1:
                startDate = Date().firstMondayInMonth
            case 2:
                startDate = calendar.date(byAdding: .month, value: -2, to: Date())!
                startDate = startDate.firstMondayInMonth
            case 3:
                startDate = calendar.date(byAdding: .month, value: -5, to: Date())!
                startDate = startDate.firstMondayInMonth
            default: break
            }

            //
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            //
            while startDate <= endDate! {
                let calendar = Calendar(identifier: .gregorian)
                let valueToAdd = ChartAxisValueDate(date: startDate, formatter: df)
                xValues.append(valueToAdd)
                startDate = calendar.date(byAdding: .weekOfMonth, value: 1, to: startDate)!
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
                startDate = calendar.date(byAdding: .weekOfMonth, value: 1, to: startDate)!
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
            var startDate = calendar.date(byAdding: .month, value: -2, to: Date())!
            startDate = startDate.firstMondayInMonth
            let endDate = calendar.date(byAdding: .weekOfMonth, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInCurrentWeek)
            
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
            var startDate = calendar.date(byAdding: .month, value: -5, to: Date())!
            startDate = startDate.firstMondayInMonth
            let endDate = calendar.date(byAdding: .weekOfMonth, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInCurrentWeek)
            
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
            var startDate = Date().firstDateInYear
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
            let numberOfDividers = monthTrackingDictionary.count
            //
            let xValuesRangedGenerator = ChartAxisValuesGeneratorDate(unit: .quarter, preferredDividers: 4, minSpace: 0, maxTextSize: 12)
            
            //
            let keys = monthTrackingDictionary.keys.sorted()
            let startDate = keys.first!
            let endDate = keys.last!
//            if keys.count == 1 {
//                endDate = keys.last!
//            } else {
//                let calendar = Calendar(identifier: .gregorian)
//                endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
//            }
            
            
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
        timeLabel.textColor = Colours.colour1
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
    @objc func okButtonAction(_ sender: Any) {
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
    @objc func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
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
