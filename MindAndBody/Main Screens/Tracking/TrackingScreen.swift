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
    
    // Time scale variables
    //
    // Time Scale Action Sheet
    let timeScaleTable = UITableView()
//    let timeScaleArray: [String] = ["1week", "1month", "3months", "6months", "1year", "all"]
    let timeScaleArray: [String] = ["1month", "3months", "6months", "all"]

    var selectedTimeScale = 0
    // StackView
    var stackArray: [UILabel] = []
    var stackFontUnselected = UIFont(name: "SFUIDisplay-thin", size: 17)
    var stackFontSelected = UIFont(name: "SFUIDisplay-medium", size: 17)
    //
    @IBOutlet weak var timeScaleStack: UIStackView!
    @IBOutlet weak var timeScaleIndicator: UIView!
    @IBOutlet weak var timeScaleIndicatorLeading: NSLayoutConstraint!
    
    
    //
    // Retreive trackingDictionary from userdefaults as [String: Int] and convert to [Date: Int]
    var trackingDictionaryDates: [Date: Int] = [:]
    
    //
    // View Will Appear ---------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure week goal correct
        updateWeekGoal()
        // Update Tracking
        updateWeekProgress()
        updateTracking()
        
        // Add here incase image changed in settings
        addBackgroundImage(withBlur: true, fullScreen: false)
        
        // Reload data and graphs incase tracking updated
        // Create [[Date: Int]] from the stored [[String: Int]] (ICloud wont store [Date: Int], only [String: Int])
        let trackingDictionary = UserDefaults.standard.object(forKey: "trackingDictionary") as! [String: Int]
        trackingDictionaryDates = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionary)
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
//        trackingDictionary[0] = [:]
//        let firstMonday = Date().firstMondayInCurrentWeek
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 1), forKey: TrackingHelpers.shared.dateToString(date: firstMonday))
//        let tue = calendar.date(byAdding: .day, value: 1, to: firstMonday)
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 1), forKey: TrackingHelpers.shared.dateToString(date: tue!))
//        let wed = calendar.date(byAdding: .day, value: 2, to: firstMonday)
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 3), forKey: TrackingHelpers.shared.dateToString(date: wed!))
//        let thur = calendar.date(byAdding: .day, value: 2, to: firstMonday)
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 3), forKey: TrackingHelpers.shared.dateToString(date: thur!))
//        let fri = calendar.date(byAdding: .day, value: 4, to: firstMonday)
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 4), forKey: TrackingHelpers.shared.dateToString(date: fri!))
//        let sat = calendar.date(byAdding: .day, value: 5, to: firstMonday)
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 6), forKey: TrackingHelpers.shared.dateToString(date: sat!))
//        let sun = calendar.date(byAdding: .day, value: 6, to: firstMonday)
//        trackingDictionary[0].updateValue(testCurrentProgress(total: 6, current: 6), forKey: TrackingHelpers.shared.dateToString(date: sun!))
//
//        //
//        trackingDictionary = [:]
////        var firstMondayLastMonth = calendar.date(byAdding: .month, value: -1, to: Date().setToMidnightUTC())!
////        firstMondayLastMonth = firstMondayLastMonth.firstMondayInMonth
//        var firstMondayLastMonth = Date().firstMondayInMonth
//        //
//        trackingDictionary.updateValue(100, forKey: TrackingHelpers.shared.dateToString(date: firstMondayLastMonth))
//        trackingDictionary.updateValue(85, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 1, to: firstMondayLastMonth)!))
//        trackingDictionary.updateValue(95, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 2, to: firstMondayLastMonth)!))
//        trackingDictionary.updateValue(90, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 3, to: firstMondayLastMonth)!))
//
//        UserDefaults.standard.set(trackingDictionary, forKey: "trackingDictionary")
//        ICloudFunctions.shared.pushToICloud(toSync: ["trackingDictionary"])
//
//    }
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Tests !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //        testTrackingValues()
        
        // Check if reset necessary
        ScheduleVariables.shared.resetWeekTracking()
        
        // Ensure week goal correct
        updateWeekGoal()
        // Update Tracking
        updateWeekProgress()
        updateTracking()
        
        
        // Create [[Date: Int]] from the stored [[String: Int]] (ICloud wont store [Date: Int], only [String: Int])
        let trackingDictionary = UserDefaults.standard.object(forKey: "trackingDictionary") as! [String: Int]
        trackingDictionaryDates = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionary)
        
        // Present walkthrough 2
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Tracking"] == false {
            walkthroughTracking()
        }
        
        //
        setupTimeScaleChoice()
        
        
        //
        // Navigation Controller
        // Remove navigation separator
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar]
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
        //
        setupChart()
    }
    
    // Time Scale
    func setupTimeScaleChoice() {
        if timeScaleStack.arrangedSubviews.count == 0 {
            for i in 0..<timeScaleArray.count {
                let timeScaleLabel = UILabel()
                timeScaleLabel.textColor = Colors.light
                timeScaleLabel.textAlignment = .center
                timeScaleLabel.font = stackFontUnselected
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
            //
            // Add background color to stack view
            let backgroundStackView = UIView(frame: timeScaleStack.bounds)
            backgroundStackView.backgroundColor = Colors.dark
            backgroundStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            timeScaleStack.insertSubview(backgroundStackView, at: 0)
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
        
        let viewHeight = UIScreen.main.bounds.height - ControlBarHeights.combinedHeight - ControlBarHeights.tabBarHeight - timeScaleStack.bounds.height
        
        // Chart
        chartView.frame = CGRect(x: 8, y: timeScaleStack.bounds.height + 8, width: view.bounds.width - 16, height: viewHeight - 16 - 8)
        view.addSubview(chartView)
        
        // No data
        chartView.noDataFont = UIFont(name: "SFUIDisplay-thin", size: 23)
        chartView.noDataText = NSLocalizedString("trackingWarning", comment: "")
        chartView.noDataTextColor = Colors.light
        
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
        leftAxis.axisLineColor = Colors.light
        leftAxis.labelTextColor = Colors.light
        leftAxis.labelFont = UIFont(name: "SFUIDisplay-thin", size: 21)!
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawLabelsEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 125
        
        // X Axis
        let xAxis = chartView.xAxis
        xAxis.axisLineColor = Colors.light
        xAxis.axisLineColor = Colors.light
        xAxis.labelTextColor = Colors.light
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.labelFont = UIFont(name: "SFUIDisplay-thin", size: 17)!
        
        // Goal: 100 %
        let goalLine = ChartLimitLine(limit: 100, label: "100 %")
        goalLine.valueFont = UIFont(name: "SFUIDisplay-thin", size: 10)!
        goalLine.lineWidth = 1
        goalLine.lineDashLengths = [5,5]
        goalLine.labelPosition = .rightTop
        goalLine.valueTextColor = Colors.light
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
        switch timeScale {
        // 1 Month
        case 0,1,2,3:
            //
            chartView.xAxis.granularity = 7 // 7 days in a week

            //
            chartDataOriginal = trackingDictionaryDates.sorted(by: { $0.key < $1.key })
            //
            // Shift chart data so min date is 0, this allows for correct presenting of labels
            if trackingDictionaryDates.count != 0 {
                TrackingVariables.shared.minTime = chartDataOriginal[0].key.timeIntervalSince1970
                for i in 0..<chartDataOriginal.count {
                    let key = (chartDataOriginal[i].key.timeIntervalSince1970 - TrackingVariables.shared.minTime) / (3600.0 * 24.0)
                    let value = chartDataOriginal[i].value
                    //
                    let keyValue = (key: key, value: value)
                    chartDataShifted.append(keyValue)
                }
                //
                lineDataEntry = chartDataShifted.map{ChartDataEntry(x: $0.0, y: Double($0.1))}
            }
            
            //
            var calendar = Calendar(identifier: .iso8601)
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            // Set Start and end dates for 1,3,6,12 months && set date formatter
            switch timeScale {
            // 1,3,6 months
            case 0,1,2:
                
                var startDate = Date().setToMidnightUTC()
                let endDate = calendar.date(byAdding: .weekOfYear, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
                
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
                default: break
                }
                //
                let start = (startDate.timeIntervalSince1970 - TrackingVariables.shared.minTime) / (3600.0 * 24.0)
                chartView.xAxis.axisMinimum = start
                
                
                let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: endDate!).day

                //
                var numberOfDays = 0
                for i in 0...timeScale {
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .month, value: i, to: startDate.firstDateInMonth)
                    //
                    let range = calendar.range(of: .day, in: .month, for: date!)!
                    let numDays = range.count
                    //
                    numberOfDays += numDays
                }
                
                chartView.xAxis.axisMaximum = start + Double(diffInDays!)
                
            // All
            case 3:
                
                chartView.xAxis.valueFormatter = DateValueFormatterDayDate()
            default: break
            }
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
        chartDataSet.valueFont = UIFont(name: "SFUIDisplay-thin", size: 10)!
        chartDataSet.valueTextColor = UIColor.clear
        
        // Marker
        let marker: XYMarkerView = XYMarkerView(color: Colors.light, font: UIFont(name: "SFUIDisplay-thin", size: 19)!, textColor: Colors.dark, insets: UIEdgeInsets(top: 3.0, left: 5.0, bottom: 8.0, right: 5.0), xAxisValueFormatter: DateValueFormatterMarker())
        marker.minimumSize = CGSize(width: 75, height: 35)
        chartView.marker = marker
        
        // Highlight
        chartDataSet.setDrawHighlightIndicators(true)
        chartDataSet.highlightColor = Colors.light
        chartDataSet.highlightEnabled = true
        chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet.highlightLineWidth = 0.5
        
        // Axes setup
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.gridColor = Colors.light.withAlphaComponent(0.03)
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
    
    //
    // MARK: Walkthrough
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
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabel.backgroundColor = Colors.light
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width - 15, height: 20)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: ControlBarHeights.combinedHeight + 2.5 + ((view.bounds.height - 73.5) * (25/125)))
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Menu
        case 1:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width * (91.5/100), y: ((self.navigationController?.navigationBar.frame.height)! / 2) + ControlBarHeights.statusBarHeight)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
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

class TrackingNavigation: UINavigationController {
    
}
