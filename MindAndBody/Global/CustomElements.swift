//
//  CustomElements.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class TriangleLabel2: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var triangleColor = Colors.dark
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let halfHeight = rect.height / 2
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX - halfHeight, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + halfHeight))
        context.addLine(to: CGPoint(x: rect.maxX - halfHeight, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX + halfHeight, y: rect.maxY - halfHeight))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(triangleColor.cgColor)
        context.fillPath()
    }
}

class TriangleLabel3: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var triangleColor = Colors.dark
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let halfHeight = rect.height / 2
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX + halfHeight, y: rect.maxY - halfHeight))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(triangleColor.cgColor)
        context.fillPath()
    }
}


class ArrowViewDown: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var arrowColor = Colors.red
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let thirdHeight = rect.height / 3
        
        let halfWidth = rect.width / 2
        let sixthWidth = rect.width / 6

        context.beginPath()
        // 1
        context.move(to: CGPoint(x: rect.minX + halfWidth + sixthWidth, y: rect.minY))
        // 2
        context.addLine(to: CGPoint(x: rect.minX + halfWidth + sixthWidth, y: 2 * thirdHeight))
        // 3
        context.addLine(to: CGPoint(x: rect.maxX - sixthWidth, y: 2 * thirdHeight))
        // 4
        context.addLine(to: CGPoint(x: rect.minX + halfWidth, y: rect.maxY))
        // 5
        context.addLine(to: CGPoint(x: rect.minX + sixthWidth, y: 2 * thirdHeight))
        // 6
        context.addLine(to: CGPoint(x: rect.minX + halfWidth - sixthWidth, y: 2 * thirdHeight))
        // 7
        context.addLine(to: CGPoint(x: rect.minX + halfWidth - sixthWidth, y: rect.minY))
        // 8
        context.addLine(to: CGPoint(x: rect.minX + halfWidth + sixthWidth, y: rect.minY))
        
        context.closePath()
        
        context.setFillColor(arrowColor.cgColor)
        context.fillPath()
    }
}

class ArrowViewUp: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var arrowColor = Colors.red
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let thirdHeight = rect.height / 3
        
        let halfWidth = rect.width / 2
        let sixthWidth = rect.width / 6
        
        context.beginPath()
        // 1
        context.move(to: CGPoint(x: rect.minX + halfWidth + sixthWidth, y: rect.maxY))
        // 2
        context.addLine(to: CGPoint(x: rect.minX + halfWidth + sixthWidth, y: thirdHeight))
        // 3
        context.addLine(to: CGPoint(x: rect.maxX - sixthWidth, y: thirdHeight))
        // 4
        context.addLine(to: CGPoint(x: rect.minX + halfWidth, y: rect.minY))
        // 5
        context.addLine(to: CGPoint(x: rect.minX + sixthWidth, y: thirdHeight))
        // 6
        context.addLine(to: CGPoint(x: rect.minX + halfWidth - sixthWidth, y: thirdHeight))
        // 7
        context.addLine(to: CGPoint(x: rect.minX + halfWidth - sixthWidth, y: rect.maxY))
        // 8
        context.addLine(to: CGPoint(x: rect.minX + halfWidth + sixthWidth, y: rect.maxY))
        
        context.closePath()
        
        context.setFillColor(arrowColor.cgColor)
        context.fillPath()
    }
}
