//
//  TrackingClasses.swift
//  MindAndBody
//
//  Created by Luke Smith on 09.02.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import Charts

//
// MARK: Date Formatters
// Day Name
public class DateValueFormatterDay: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "E"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let timeIntervalDeShifted = (value * 3600 * 24) + TrackingVariables.shared.minTime
        let date2 = Date(timeIntervalSince1970: timeIntervalDeShifted)
        return dateFormatter.string(from: date2)
    }
}
// Day Date
public class DateValueFormatterDayDate: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let timeIntervalDeShifted = (value * 3600 * 24) + TrackingVariables.shared.minTime
        let date2 = Date(timeIntervalSince1970: timeIntervalDeShifted)
        return dateFormatter.string(from: date2)
//        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
// Month Name
public class DateValueFormatterMonth: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MMM"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let timeIntervalDeShifted = (value * 3600 * 24) + TrackingVariables.shared.minTime
        let date2 = Date(timeIntervalSince1970: timeIntervalDeShifted)
        return dateFormatter.string(from: date2)
//        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
// Month Letter
public class DateValueFormatterMonthLetter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MMMMM"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let timeIntervalDeShifted = (value * 3600 * 24) + TrackingVariables.shared.minTime
        let date2 = Date(timeIntervalSince1970: timeIntervalDeShifted)
        return dateFormatter.string(from: date2)
        //        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
//
// Day.Month.Year
public class DateValueFormatterMarker: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd.MM.yy"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

// Dates test
public class ChartFormatter: NSObject, IAxisValueFormatter {
    
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MMM"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

// MARK: Markers
public class BalloonMarker: MarkerImage {
    public var color: UIColor
    public var arrowSize = CGSize(width: 15, height: 11)
    public var font: UIFont
    public var textColor: UIColor
    public var insets: UIEdgeInsets
    public var minimumSize = CGSize()
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedStringKey : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets) {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    public override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = point
        origin.x -= width / 2
        origin.y -= height
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    public override func draw(context: CGContext, point: CGPoint) {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)
        
        if offset.y > 0 {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        } else {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }
        
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        setLabel(String(entry.y))
    }
    
    public func setLabel(_ newLabel: String) {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
    
}

public class XYMarkerView: BalloonMarker {
    public var xAxisValueFormatter: IAxisValueFormatter
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter) {
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 0
        yFormatter.maximumFractionDigits = 0
        super.init(color: color, font: font, textColor: textColor, insets: insets)
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        // De shift x value time
        let timeIntervalDeShifted = (entry.x * 3600 * 24) + TrackingVariables.shared.minTime
        
        let string = ""
            + xAxisValueFormatter.stringForValue(timeIntervalDeShifted, axis: XAxis())
            + " - "
            + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!
            + "%"
        setLabel(string)
    }
    
}
