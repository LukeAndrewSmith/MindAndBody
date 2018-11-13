//
//  Tracking.swift
//  MindAndBody
//
//  Created by Luke Smith on 02.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import Charts


//
// Tracking Screen Class --------------------------------------------------------------------------------------------------------
//
class TrackingScreen: UIViewController, ChartViewDelegate {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Chart
    let chartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    var menuSwipeView = UIView()
    
    let percentageLabel = UILabel()
    
    // Time scale variables
    //
    // Time Scale Action Sheet
    let timeScaleTable = UITableView()
//    let timeScaleArray: [String] = ["1week", "1month", "3months", "6months", "1year", "all"]
    let timeScaleArray: [String] = ["1month", "3months", "6months", "all"]

    var selectedTimeScale = 0
    // StackView
    var stackArray: [UILabel] = []
    //
    @IBOutlet weak var timeScaleStack: UIStackView!
    @IBOutlet weak var timeScaleIndicator: UIView!
    @IBOutlet weak var timeScaleIndicatorLeading: NSLayoutConstraint!
    @IBOutlet weak var timeScaleIndicatorHeight: NSLayoutConstraint!
    
    
    //
    // Retreive trackingDictionary from userdefaults as [String: Int] and convert to [Date: Int]
    var trackingDictionaryDates: [Date: Int] = [:]
    
    //
    // View Will Appear ---------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure schedule reset
        ScheduleVariables.shared.resetScheduleTracking()
        // Ensure week goal correct
        Tracking.shared.updateWeekGoal()
        // Update Tracking
        Tracking.shared.updateWeekProgress()
        Tracking.shared.updateTracking()
        
        // Reload data and graphs incase tracking updated
        // Create [[Date: Int]] from the stored [[String: Int]] (UserDefaults won't store [Date: Int], only [String: Int])
        // Also scales values above 100% so they can be seen on the graph
            // Presenting the indicator for the data point de scales and presents the correct value (see tracking classes)
        let trackingDictionaryString = UserDefaults.standard.object(forKey: "trackingDictionary") as! [String: Int]
        trackingDictionaryDates = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionaryString)
        setupChartData(timeScale: selectedTimeScale)
    }
    
    
    
    func testCurrentProgress(total: Int, current: Int) -> Int {
        let weekProgress: Double = Double(current)
        let weekGoal: Double = Double(total)
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        let currentProgress = Int(currentProgressDivision)
        return currentProgress
    }
    
//    func testTrackingValues() {
//        var calendar = Calendar(identifier: .iso8601)
//        calendar.timeZone = TimeZone(abbreviation: "UTC")!
//        //
//        var trackingDictionary = UserDefaults.standard.object(forKey: "trackingDictionary") as! [String: Int]
//
//        trackingDictionary = [:]
//        var firstMondayLastMonth = calendar.date(byAdding: .month, value: -1, to: Date().setToMidnightUTC())!
//        firstMondayLastMonth = firstMondayLastMonth.firstMondayInMonth
////        let firstMondayLastMonth = Date().firstMondayInMonth
//        //
//        trackingDictionary.updateValue(100, forKey: TrackingHelpers.shared.dateToString(date: firstMondayLastMonth))
//        trackingDictionary.updateValue(85, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 1, to: firstMondayLastMonth)!))
//        trackingDictionary.updateValue(95, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 2, to: firstMondayLastMonth)!))
//        trackingDictionary.updateValue(90, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 3, to: firstMondayLastMonth)!))
//
//
////        let possibleValues = [60,70,80,85,85,90,90,90,95,95,95,97,100,100,105,110]
////        var dateLoop = calendar.date(byAdding: .month, value: -8, to:  Date().firstMondayInMonth) // First monday in year
////        while dateLoop! < Date().firstMondayInCurrentWeek {
////
////            let random = Int(arc4random_uniform(UInt32(possibleValues.count)))
////            let chosenValue = possibleValues[random]
////            trackingDictionary.updateValue(chosenValue, forKey: TrackingHelpers.shared.dateToString(date: dateLoop!))
////            dateLoop = calendar.date(byAdding: .weekOfYear, value: 1, to: dateLoop!)
////        }
//
//
//        UserDefaults.standard.set(trackingDictionary, forKey: "trackingDictionary")
//
//    }
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Navigation Controller
        // Remove navigation separator
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("tracking", comment: ""), separator: false, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)

        view.backgroundColor = Colors.light
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTimeScaleChoice()
        setupChart()
        
        if !view.subviews.contains(percentageLabel) {
            percentageLabel.text = NSLocalizedString("%acheived", comment: "")
            percentageLabel.font = Fonts.smallElementLight!
            percentageLabel.sizeToFit()
            percentageLabel.center = CGPoint(x: percentageLabel.bounds.height/2, y: chartView.center.y)
            percentageLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            view.addSubview(percentageLabel)
        }
    }
    
    // Time Scale
    func setupTimeScaleChoice() {
        if timeScaleStack.arrangedSubviews.count == 0 {
            for i in 0..<timeScaleArray.count {
                let timeScaleLabel = UILabel()
                timeScaleLabel.textColor = Colors.light
                timeScaleLabel.textAlignment = .center
                timeScaleLabel.font = Fonts.verySmallElementLight
                timeScaleLabel.text = NSLocalizedString(timeScaleArray[i], comment: "")
                timeScaleLabel.sizeToFit()
                timeScaleLabel.tag = i
                //
                let timeScaleTap = UITapGestureRecognizer()
                timeScaleTap.numberOfTapsRequired = 1
                timeScaleTap.addTarget(self, action: #selector(timeScaleTapHandler))
                //
                timeScaleLabel.isUserInteractionEnabled = true
                timeScaleLabel.addGestureRecognizer(timeScaleTap)
                stackArray.append(timeScaleLabel)
            }
            for i in 0...stackArray.count - 1 {
                timeScaleStack.addArrangedSubview(stackArray[i])
            }
            timeScaleStack.isUserInteractionEnabled = true
            timeScaleIndicatorHeight.constant = 2
            //
            timeScaleIndicator.backgroundColor = Colors.light
            //
            // Add background color to stack view
            let backgroundStackView = UIView(frame: timeScaleStack.bounds)
            backgroundStackView.backgroundColor = Colors.dark
            backgroundStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            timeScaleStack.insertSubview(backgroundStackView, at: 0)
            
            backgroundStackView.layer.shadowColor = Colors.dark.cgColor
            backgroundStackView.layer.shadowOpacity = 1
            backgroundStackView.layer.shadowOffset = CGSize.zero
            backgroundStackView.layer.shadowRadius = 7
        }
    }
    
    @objc func timeScaleTapHandler(sender: UITapGestureRecognizer) {
        
        let timeScaleLabel = sender.view as! UILabel
        let index = timeScaleLabel.tag
        selectedTimeScale = index
        setupChartData(timeScale: selectedTimeScale)
        timeScaleTable.reloadData()
        
        // Animate indicator to time scale label
        timeScaleIndicatorLeading.constant = self.stackArray[selectedTimeScale].frame.minX
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Setup chart
    func setupChart() {
        
        let viewHeight: CGFloat = UIScreen.main.bounds.height - ElementHeights.combinedHeight - ElementHeights.tabBarHeight - timeScaleStack.bounds.height - ElementHeights.bottomSafeAreaInset
        
        // Chart
        chartView.frame = CGRect(x: 16, y: timeScaleStack.bounds.height + 8, width: view.bounds.width - 16, height: viewHeight - 16)
        view.addSubview(chartView)
        
        // No data
        chartView.noDataFont = Fonts.largeElementRegular
        chartView.noDataText = NSLocalizedString("trackingWarning", comment: "")
        chartView.noDataTextColor = Colors.dark
        
        // General
        chartView.delegate = self
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(false)
        chartView.doubleTapToZoomEnabled = false
        chartView.chartDescription?.enabled = false
        
        // Y Axis
        let leftAxis = chartView.leftAxis
        // MARK: Test!!!
        leftAxis.axisLineWidth = 2
        leftAxis.axisLineColor = Colors.dark
        leftAxis.labelTextColor = Colors.dark
        leftAxis.labelFont = Fonts.smallElementRegular!
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawLabelsEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 125
        
        // X Axis
        let xAxis = chartView.xAxis
        // MARK: Test!!!
        xAxis.axisLineWidth = 2
        xAxis.axisLineColor = Colors.dark
        xAxis.axisLineColor = Colors.dark
        xAxis.labelTextColor = Colors.dark
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.labelFont = Fonts.smallElementLight!
        
        // Goal: 100 %
        let goalLine = ChartLimitLine(limit: 100, label: "100 %")
        // nina
        goalLine.valueFont = UIFont(name: "SFUIDisplay-light", size: 11)!
        goalLine.lineWidth = 2
        goalLine.lineDashLengths = [5,5]
        goalLine.labelPosition = .rightTop
        goalLine.valueTextColor = Colors.dark
        goalLine.lineColor = Colors.green
        chartView.leftAxis.addLimitLine(goalLine)
        
        //
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        // Animation
        chartView.animate(xAxisDuration: AnimationTimes.animationTime1, yAxisDuration: AnimationTimes.animationTime1)
        
        // Populate chart
        setupChartData(timeScale: 0)
    }
    
    
    // MARK: Setup chart data
    func setupChartData(timeScale: Int) {
        
        // Ensure no axis min/max set
        chartView.xAxis.resetCustomAxisMin()
        chartView.xAxis.resetCustomAxisMax()
        
        //
        var chartDataOriginal: [(key: Date, value: Int)] = []
        var chartDataShifted: [(key: Double, value: Int)] = [] // Shift chart data so min date is 0, this allows for correct presenting of labels
        // Data points

        chartDataOriginal = trackingDictionaryDates.sorted(by: { $0.key < $1.key })

        // Shift chart data so min date is 0, this allows for correct presenting of labels
        if trackingDictionaryDates.count != 0 {
            Tracking.shared.minTime = chartDataOriginal[0].key.timeIntervalSince1970
            for i in 0..<chartDataOriginal.count {
                let key = (chartDataOriginal[i].key.timeIntervalSince1970 - Tracking.shared.minTime) / (3600.0 * 24.0)
                let value = chartDataOriginal[i].value
                //
                let keyValue = (key: key, value: value)
                chartDataShifted.append(keyValue)
            }
            lineDataEntry = chartDataShifted.map{ChartDataEntry(x: $0.0, y: Double($0.1))}
        }
        
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        // Set Start and end dates for 1,3,6,12 months && set date formatter
        switch timeScale {
        // 1,3,6 months
        case 0,1,2,3:
            
            var startDate = Date().setToMidnightUTC()
            var endDate = calendar.date(byAdding: .weekOfYear, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
            
            switch selectedTimeScale {
            case 0:
                startDate = Date().firstMondayInMonth
                chartView.xAxis.labelCount = Date().numberOfMondaysInCurrentMonth
                chartView.xAxis.forceLabelsEnabled = true
                chartView.xAxis.valueFormatter = DateValueFormatterDayDate()
            case 1:
                startDate = calendar.date(byAdding: .month, value: -2, to: Date().setToMidnightUTC())!
                startDate = startDate.firstMondayInMonth
                // Find the number of x axis values to have
                var numberOfValues = 0
                for i in 0...2 {
                    let month = calendar.date(byAdding: .month, value: i, to: startDate)!
                    numberOfValues += month.numberOfMondaysInCurrentMonth
                }
                chartView.xAxis.labelCount = 3
                chartView.xAxis.forceLabelsEnabled = true
                chartView.xAxis.valueFormatter = DateValueFormatterMonth()
            case 2:
                startDate = calendar.date(byAdding: .month, value: -5, to: Date().setToMidnightUTC())!
                startDate = startDate.firstMondayInMonth
                chartView.xAxis.labelCount = 6
                chartView.xAxis.forceLabelsEnabled = true
                chartView.xAxis.valueFormatter = DateValueFormatterMonth()
            // All
            case 3:
                startDate = trackingDictionaryDates.keys.sorted().first ?? Date().firstMondayInMonth
                endDate = trackingDictionaryDates.keys.sorted().last ?? calendar.date(byAdding: .weekOfYear, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
                chartView.xAxis.labelCount = 0
                chartView.xAxis.forceLabelsEnabled = true
                chartView.xAxis.valueFormatter = DateValueFormatterMonth()
            default: break
            }
            //
            let start = (startDate.timeIntervalSince1970 - Tracking.shared.minTime) / (3600.0 * 24.0)
            chartView.xAxis.axisMinimum = start
            
            let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: endDate!).day

            chartView.xAxis.axisMaximum = start + Double(diffInDays!)
        default: break
        }
        
        // Chart data
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "I'm a label that isn't shown")
        let chartData = LineChartData()
        if trackingDictionaryDates.count != 0 || trackingDictionaryDates.count != 0 {
            chartData.addDataSet(chartDataSet)
            chartData.setDrawValues(true)
        }
        chartDataSet.colors = [Colors.red]
        chartDataSet.setCircleColor(Colors.red)
        chartDataSet.circleHoleColor = Colors.red
        chartDataSet.circleRadius = 4
        chartDataSet.valueFont = UIFont(name: "SFUIDisplay-light", size: 10)!
        chartDataSet.valueTextColor = UIColor.clear
        // MARK: TEst!!!!
        chartDataSet.lineWidth = 2
        
        // Marker
        let marker: XYMarkerView = XYMarkerView(color: Colors.dark, font: Fonts.smallElementRegular!, textColor: Colors.light, insets: UIEdgeInsets(top: 3.0, left: 5.0, bottom: 8.0, right: 5.0), xAxisValueFormatter: DateValueFormatterMarker())
        marker.minimumSize = CGSize(width: 75, height: 35)
        chartView.marker = marker
        
        // Highlight
        chartDataSet.setDrawHighlightIndicators(true)
        chartDataSet.highlightColor = Colors.dark
        chartDataSet.highlightEnabled = true
        chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet.highlightLineWidth = 0.5
        
        // Axes setup
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false // true
        chartView.xAxis.gridColor = Colors.darkGray.withAlphaComponent(0.5)
        chartView.xAxis.drawAxisLineEnabled = true
        //
        chartView.data = chartData
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Remove back button text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}

class TrackingNavigation: UINavigationController {
    
}
