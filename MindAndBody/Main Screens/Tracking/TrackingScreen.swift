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
class TrackingScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, ChartViewDelegate {
    
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
    let timeScaleArray: [String] = ["1week", "1month", "3months", "6months", "1year", "all"]
    var selectedTimeScale = 0
    // Button on x axis
    var timeScaleButton2 = UIButton()
    //
    
    // Slide menu
    var slideMenuInteraction = UIScreenEdgePanGestureRecognizer()
    
    //
    // Retreive trackingdictionaries from userdefaults as [String: Int] and convert to [Date: Int]
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
            yValue = view.frame.maxY - 49 - TopBarHeights.homeIndicatorHeight
            // Normal iPhone
        } else {
            yValue = view.frame.maxY - 49
        }
        timeScaleButton2.frame = CGRect(x: 0, y: yValue, width: view.bounds.width, height: 49)
        timeScaleButton2.backgroundColor = .clear
        timeScaleButton2.addTarget(self, action: #selector(timeScaleButton(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow?.insertSubview(timeScaleButton2, aboveSubview: view)
        
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
//        var trackingDictionaries = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
//        trackingDictionaries[0] = [:]
//        let firstMonday = Date().firstMondayInCurrentWeek
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 1), forKey: TrackingHelpers.shared.dateToString(date: firstMonday))
//        let tue = calendar.date(byAdding: .day, value: 1, to: firstMonday)
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 1), forKey: TrackingHelpers.shared.dateToString(date: tue!))
//        let wed = calendar.date(byAdding: .day, value: 2, to: firstMonday)
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 3), forKey: TrackingHelpers.shared.dateToString(date: wed!))
//        let thur = calendar.date(byAdding: .day, value: 2, to: firstMonday)
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 3), forKey: TrackingHelpers.shared.dateToString(date: thur!))
//        let fri = calendar.date(byAdding: .day, value: 4, to: firstMonday)
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 4), forKey: TrackingHelpers.shared.dateToString(date: fri!))
//        let sat = calendar.date(byAdding: .day, value: 5, to: firstMonday)
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 6), forKey: TrackingHelpers.shared.dateToString(date: sat!))
//        let sun = calendar.date(byAdding: .day, value: 6, to: firstMonday)
//        trackingDictionaries[0].updateValue(testCurrentProgress(total: 6, current: 6), forKey: TrackingHelpers.shared.dateToString(date: sun!))
//
//        //
//        trackingDictionaries[1] = [:]
////        var firstMondayLastMonth = calendar.date(byAdding: .month, value: -1, to: Date().setToMidnightUTC())!
////        firstMondayLastMonth = firstMondayLastMonth.firstMondayInMonth
//        var firstMondayLastMonth = Date().firstMondayInMonth
//        //
//        trackingDictionaries[1].updateValue(100, forKey: TrackingHelpers.shared.dateToString(date: firstMondayLastMonth))
//        trackingDictionaries[1].updateValue(85, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 1, to: firstMondayLastMonth)!))
//        trackingDictionaries[1].updateValue(95, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 2, to: firstMondayLastMonth)!))
//        trackingDictionaries[1].updateValue(90, forKey: TrackingHelpers.shared.dateToString(date: calendar.date(byAdding: .weekOfMonth, value: 3, to: firstMondayLastMonth)!))
//
//        UserDefaults.standard.set(trackingDictionaries, forKey: "trackingDictionaries")
//        ICloudFunctions.shared.pushToICloud(toSync: ["trackingDictionaries"])
//
//    }
    
    //
    // MARK: View did load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure week goal correct
        updateWeekGoal()
        
        // MARK: Tests !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        testTrackingValues()
        updateWeekTracking()
        updateTracking()
        
        // Create [[Date: Int]] from the stored [[String: Int]] (ICloud wont store [Date: Int], only [String: Int])
        let trackingDictionaries = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
        trackingDictionariesDates = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionaries)
        
        
        
        // Present walkthrough 2
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Tracking"] == false {
            walkthroughTracking()
        }
        
        //
        setupTimeScaleButton()
        
        //
        // Navigation Controller
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
        
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: false)
        
        //
        setupChart()
        
        // Slide Menu
        chartView.addGestureRecognizer(slideMenuInteraction)
        slideMenuInteraction.addTarget(self, action: #selector(edgePanGesture(sender:)))
        slideMenuInteraction.edges = .left
    }
    
    func setupTimeScaleButton() {
        // Time scale table
        timeScaleTable.dataSource = self
        timeScaleTable.delegate = self
        timeScaleTable.tableFooterView = UIView()
        timeScaleTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        timeScaleTable.separatorColor = Colors.light.withAlphaComponent(0.5)
        timeScaleTable.backgroundColor = Colors.dark
        timeScaleTable.layer.cornerRadius = 15
        timeScaleTable.clipsToBounds = true
        timeScaleTable.layer.borderWidth = 1
        timeScaleTable.layer.borderColor = Colors.light.cgColor
        timeScaleTable.isScrollEnabled = false
        timeScaleTable.frame = CGRect(x: 0, y: 0, width: ActionSheet.shared.actionSheet.bounds.width, height: 7 * 47)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(timeScaleTable)
        let heightToAdd = timeScaleTable.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
    }
    
    // MARK: Setup chart
    func setupChart() {
        
        // Chart
        chartView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: returnChartHeight())
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
        // 1 Week
        case 0:
            
            //
            chartView.xAxis.granularity = 1 // 1 day

            //
            chartDataOriginal = trackingDictionariesDates[0].sorted(by: { $0.key < $1.key })
            //
            // Shift chart data so min date is 0, this allows for correct presenting of labels
            if trackingDictionariesDates[0].count != 0 {
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
            chartView.xAxis.axisMinimum = 0
            chartView.xAxis.axisMaximum = 6
            //
            chartView.xAxis.valueFormatter = DateValueFormatterDay()
            chartView.xAxis.labelCount = 7
            chartView.xAxis.forceLabelsEnabled = true
        // 1 Month
        case 1,2,3,4,5:
            //
            chartView.xAxis.granularity = 7 // 7 days in a week

            //
            chartDataOriginal = trackingDictionariesDates[1].sorted(by: { $0.key < $1.key })
            //
            // Shift chart data so min date is 0, this allows for correct presenting of labels
            if trackingDictionariesDates[1].count != 0 {
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
            case 1,2,3:
                //
                //
                var startDate = Date().setToMidnightUTC()
                let endDate = calendar.date(byAdding: .weekOfYear, value: Date().numberOfMondaysInCurrentMonth - 1, to: Date().firstMondayInMonth)
                
                switch selectedTimeScale {
                case 1:
                    startDate = Date().firstMondayInMonth
                    chartView.xAxis.labelCount = Date().numberOfMondaysInCurrentMonth
                    chartView.xAxis.forceLabelsEnabled = true
                    chartView.xAxis.valueFormatter = DateValueFormatterDayDate()
                case 2:
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
                case 3:
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
                //
//                chartView.xAxis.axisMinimum = startDate.timeIntervalSince1970
//                chartView.xAxis.axisMaximum = (endDate?.timeIntervalSince1970)!
                //

            // 12 months
            case 4:
                //
                let startDate = Date().firstDateInYear
                var endDate = calendar.date(byAdding: .month, value: 11, to: startDate)
                endDate = endDate?.firstDateInMonth
                //
                chartView.xAxis.axisMinimum = 0
                chartView.xAxis.axisMaximum = 364
                //
                chartView.xAxis.valueFormatter = DateValueFormatterMonthLetter()
                chartView.xAxis.labelCount = 12
                chartView.xAxis.forceLabelsEnabled = true
                
            // All
            case 5:
                //
                chartView.xAxis.valueFormatter = DateValueFormatterDayDate()
            default: break
            }
        default: break
        }
        
        // Chart data
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "I'm a label that isn't shown")
        let chartData = LineChartData()
        if trackingDictionariesDates[0].count != 0 || trackingDictionariesDates[1].count != 0 {
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
    
    // Return chart height
    var firstTimeOpened = true
    func returnChartHeight() -> CGFloat {
        if firstTimeOpened {
            firstTimeOpened = false
            if IPhoneType.shared.iPhoneType() == 2 {
                return self.view.bounds.height - TopBarHeights.combinedHeight - 4 - TopBarHeights.homeIndicatorHeight
            } else {
                return self.view.bounds.height - TopBarHeights.combinedHeight - 4
            }
            
        } else {
            if IPhoneType.shared.iPhoneType() == 2 {
                return self.view.bounds.height - 4 - TopBarHeights.homeIndicatorHeight
            } else {
                return self.view.bounds.height - 4
            }
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
        header.textLabel?.textColor = Colors.dark
        //
        let background = UIView()
        background.frame = header.bounds
        background.backgroundColor = Colors.light
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
        cell.textLabel?.textColor = Colors.light
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = Colors.dark
        if indexPath.row == selectedTimeScale {
            cell.accessoryType = .checkmark
            cell.tintColor = Colors.green
            cell.textLabel?.textColor = Colors.green
        }
        if indexPath.row == timeScaleArray.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        return cell
    }
    
    //
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        selectedTimeScale = indexPath.row
        setupChartData(timeScale: selectedTimeScale)
        //
        timeScaleTable.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            // Dismiss action sheet
            ActionSheet.shared.animateActionSheetDown()
        })
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //
    @IBAction func timeScaleButton(_ sender: Any) {
        ActionSheet.shared.animateActionSheetUp()
    }
    
    //
    // MARK: Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    let interactor = Interactor()
    // Edge pan
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        MenuVariables.shared.menuInteractionType = 1

        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    //
    @IBAction func slideMenuButtonAction(_ sender: Any) {
        MenuVariables.shared.menuInteractionType = 0
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
            // Handle changing colour of status bar if button pressed
            if MenuVariables.shared.menuInteractionType == 0 {
                UIApplication.shared.statusBarStyle = .default
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
    override func viewDidDisappear(_ animated: Bool) {
        timeScaleButton2.removeFromSuperview()
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
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: TopBarHeights.combinedHeight + 2.5 + ((view.bounds.height - 73.5) * (25/125)))
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
            highlightCenter = CGPoint(x: view.bounds.width * (91.5/100), y: ((self.navigationController?.navigationBar.frame.height)! / 2) + TopBarHeights.statusBarHeight)
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


//
// MARK: Slide Menu Extension
extension TrackingScreen: UIViewControllerTransitioningDelegate {
    
    // Interactive pan
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    //
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    // Button
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
