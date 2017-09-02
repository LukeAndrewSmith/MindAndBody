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
        //let vibrancyE = UIVibrancyEffect(blurEffect: backgroundBlurE)
        //backgroundBlur.effect = vibrancyE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImage.bounds
        //
        if backgroundIndex > backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        updateMonthTracking()
        updateWeekTracking()
        drawGraph()
    }
    
    
    // Test
    func testFunc() {
        updateWeekTracking()
    }
    
    
    
    //
    // Graphs -----------------------------------------------------------------------------------------------------------
    //
    func drawGraph() {
        //
        let chartDataWeek = [(21, 100), (22, 80), (23, 90), (24, 100)]
        let chartDataOther = [(1,100), (2,100), (3,100)]
        
        
        //
        // Parameters
        var chartData: [(Int, Int)] = []
        var firstModelValuex = Double()
        var lastModelValuex = Double()
        
        // Set Parameters
        switch selectedTimeScale {
        case 0:
            chartData = chartDataWeek
            //firstModelValuex = chartDataWeek.map
            lastModelValuex = firstModelValuex + 7
        default:
            chartData = chartDataOther
        }
        //
        let chartPoints: [ChartPoint] = chartData.map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        
        //
        // Axis Labels
        var labelSettings = ChartLabelSettings(font: UIFont(name: "SFUIDisplay-light", size: 19)!)
        labelSettings.fontColor = colour1
        // would be better to not call at all rather than putting "" in text:
        let generator = ChartAxisGeneratorMultiplier(2)
        let labelsGenerator = ChartAxisLabelsGeneratorFunc {scalar in
            return ChartAxisLabel(text: "", settings: labelSettings)
        }
        
        //
        // Axes
        let xGenerator = ChartAxisGeneratorMultiplier(2)
        //
        let xModel = ChartAxisModel(lineColor: colour1, firstModelValue: firstModelValuex, lastModelValue: lastModelValuex, axisTitleLabels: [ChartAxisLabel(text: "Week", settings: labelSettings)], axisValuesGenerator: xGenerator, labelsGenerator: labelsGenerator)
        let yModel = ChartAxisModel(lineColor: colour1, firstModelValue: 0, lastModelValue: 125, axisValuesGenerator: generator, labelsGenerator: labelsGenerator)
        //
        let chartFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 64)
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
        
        
        
        // Touch Layer
        //
        let labelWidth: CGFloat = 70
        let labelHeight: CGFloat = 30
        //
        let showCoordsTextViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let text = chartPoint.description
            let font = UIFont(name: "SFUIDisplay-light", size: 19)!
            //let x = min(screenLoc.x + 5, chart.bounds.width - text.width(font) - 5)
            let view = UIView(frame: CGRect(x: 50, y: screenLoc.y - labelHeight, width: labelWidth, height: labelHeight))
            let label = UILabel(frame: view.bounds)
            label.text = text
            label.font = UIFont(name: "SFUIDisplay-light", size: 19)!
            view.addSubview(label)
            view.alpha = 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                view.alpha = 1
            }, completion: nil)
            
            return view
        }
        
        //let showCoordsLinesLayer = ChartShowCoordsLinesLayer<ChartPoint>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints)
        let showCoordsTextLayer = ChartPointsSingleViewLayer<ChartPoint, UIView>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: showCoordsTextViewsGenerator, mode: .custom, keepOnFront: true)
        
        //
        let touchViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let s: CGFloat = 30
            let view = HandlingView(frame: CGRect(x: screenLoc.x - s/2, y: screenLoc.y - s/2, width: s, height: s))
            view.touchHandler = {[ weak showCoordsTextLayer, weak chartPoint, weak chart] in
                guard let chartPoint = chartPoint, let chart = chart else {return}
                //showCoordsLinesLayer?.showChartPointLines(chartPoint, chart: chart)
                showCoordsTextLayer?.showView(chartPoint: chartPoint, chart: chart)
            }
            return view
        }
        let touchLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: touchViewsGenerator, mode: .translate, keepOnFront: true)
        
        
        
        // create chart instance with frame and layers
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guideLinesHighlightLayer,
                chartPointsLayer,
                chartPointsLineLayer,
                chartPointsCircleLayer,
                touchLayer
            ]
        )
        
        view.addSubview(chart.view)
        self.chart = chart
        
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
    
    // Test
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
