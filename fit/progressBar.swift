//
//  progressBar.swift
//  fit
//
//  Created by Avery Eastberg on 3/27/19.
//  Copyright © 2019 AvvCole. All rights reserved.
//

import UIKit


class progressBar: UIView {

    @IBInspectable public var backgroundCircleColor: UIColor = UIColor.lightGray
    @IBInspectable public var startGradient: UIColor = UIColor.orange
    @IBInspectable public var endGradient: UIColor = UIColor.yellow
    @IBInspectable public var textColor: UIColor = UIColor.white
    
    private var backgroundLayer: CAShapeLayer!
    var foregroundLayer: CAShapeLayer!
    var gradientLayer: CAGradientLayer!
    
    
     var progress: CGFloat = 0.0
     {
        willSet{
            didProgressUpdate()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        guard layer.sublayers == nil else{
            return
        }
        
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
       backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.orange.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        
        gradientLayer.colors = [startGradient.cgColor, endGradient.cgColor]
        gradientLayer.frame = rect
        gradientLayer.mask = foregroundLayer

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(gradientLayer)
        
        
    }
    
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer{
        let width = rect.width
        let height = rect.height
        
        
        let center = CGPoint(x: width/2, y: height/2)
        let radius = (min(width, height) - lineWidth)/2
        
        let startAngle = -CGFloat.pi/2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
    
     func didProgressUpdate(){
        foregroundLayer?.strokeEnd = progress 
        
    }

}
