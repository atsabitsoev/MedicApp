//
//  ViewRoundAnyCorners.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 17/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

@IBDesignable
class ViewGradientHeader: UIView {
    
    
    @IBInspectable var radius: CGFloat = 8
    @IBInspectable var color1: UIColor = #colorLiteral(red: 0.07450980392, green: 0.8, blue: 0.7843137255, alpha: 1)
    @IBInspectable var color2: UIColor = #colorLiteral(red: 0.1294117647, green: 0.9137254902, blue: 0.6470588235, alpha: 1)

    
    override func draw(_ rect: CGRect) {
        
        drawGradient()
        
    }
    
    
    private func drawGradient() {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        path.addClip()
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                  colors: [color1.cgColor, color2.cgColor] as CFArray,
                                  locations: [0.0,1.0])!
        
        let context = UIGraphicsGetCurrentContext()!
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: bounds.maxX, y: 1)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        
        
    }
    

}
