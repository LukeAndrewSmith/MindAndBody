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
        
        //
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
    }
    
    func setupChart() {
        // Chart Setup
        chartView.frame = view.bounds
        view.addSubview(chartView)
        
        // No data
        chartView.noDataFont = UIFont(name: "SFUIDisplay-thin", size: 23)
        chartView.noDataText = NSLocalizedString("trackingWarning", comment: "")
        chartView.noDataTextColor = Colors.light
        
        // Colours
        chartView.xAxis.axisLineColor = Colors.light
        chartView.leftAxis.axisLineColor = Colors.light
        chartView.leftAxis.labelTextColor = Colors.light
        chartView.leftAxis.labelFont = UIFont(name: "SFUIDisplay-thin", size: 21)!
        
        //
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 125
        
        // 100 %
        let goalLine = ChartLimitLine(limit: 100, label: "100 %")
        goalLine.valueFont = UIFont(name: "SFUIDisplay-thin", size: 10)!
        goalLine.lineWidth = 1
        goalLine.lineDashLengths = [5,5]
        goalLine.labelPosition = .rightTop
        goalLine.valueTextColor = Colors.light
        goalLine.lineColor = Colors.green
        chartView.leftAxis.addLimitLine(goalLine)
        
        
        // Line chart
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        // Animation
        chartView.animate(xAxisDuration: AnimationTimes.animationTime1, yAxisDuration: AnimationTimes.animationTime1)
        
        // Populate chart
        setupChartData(timeScale: 0)
    }
    
    func setupChartData(timeScale: Int) {
        
        // Data points
        switch timeScale {
        // 1 Week
        case 0:
            let chartData = trackingDictionariesDates[0].sorted(by: { $0.key < $1.key })
                //
            lineDataEntry = chartData.map{ChartDataEntry(x: $0.0.timeIntervalSince1970, y: Double($0.1))}
//            chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
//
//            let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueDate(date: $0.0, formatter: df), y: ChartAxisValueInt($0.1))}
//            return chartPoints
    
//            for i in 0... {
//                let dataPoint = ChartDataEntry(x: <#T##Double#>, y: <#T##Double#>)
//                lineDataEntry.append(dataPoint)
//            }
            
        // 1 Month
//        case 1:
//
//        // 3 Months
//        case 2:
//
//        // 6 Months
//        case 3:
//
//        // 1 Year
//        case 4:
//
//        // All
//        case 5:
            
        default: break
        }
        
        // Chart data
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "Where am I??")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [Colors.red]
        chartDataSet.setCircleColor(Colors.red)
        chartDataSet.circleHoleColor = Colors.red
        chartDataSet.circleRadius = 4
        
        // Gradient fill
        let gradientColors = [Colors.green.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("gradient error"); return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        
        // Axes setup
//        let formatter = ChartFormatter()
//        formatter.setValues(values: dadddd)
//        let xAxis: XAxis = XAxis()
//        xAxis.valueFormatter = formatter
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
//        chartView.xAxis.valueFormatter = IAxisValueFormatter.stringForValue(.)
//        chartView.chartDescription?.isEnabled = true
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        //
        chartView.data = chartData
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
        // If data is available
        if trackingDictionariesDates[0].count != 0 {
            //
            //
            selectedTimeScale = indexPath.row
            //
//            TODO: REMOVE!!!
//            chart?.view.removeFromSuperview()
//            drawGraph()
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
    // MARK Slide Menu ---------------------------------------------------------------------------------------------------------------------
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
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabel.backgroundColor = Colors.light
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width - 15, height: 20)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: TopBarHeights.combinedHeight + 12.25 + ((view.bounds.height - 73.5) * (25/125)))
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
            let barButtonItem = self.navigationItem.rightBarButtonItem!
            let buttonItemView = barButtonItem.value(forKey: "view") as? UIView
            highlightCenter = CGPoint(x: (buttonItemView?.center.x)!, y: (buttonItemView?.center.y)! + TopBarHeights.statusBarHeight)
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
