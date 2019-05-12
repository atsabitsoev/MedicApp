//
//  ButtonGradient.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 03/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonGradient: UIButton {
    
    @IBInspectable var color1: UIColor = #colorLiteral(red: 0.9725490196, green: 0.3803921569, blue: 0.3568627451, alpha: 1)
    @IBInspectable var color2: UIColor = #colorLiteral(red: 0.9843137255, green: 0.6862745098, blue: 0.3764705882, alpha: 1)
    
    let shadowView = UIView()
    let myImageView = UIImageView()
    
    var imageSet = false
    
    override var frame: CGRect {
        didSet {
            shadowView.frame = frame
            setMyImage(bounds)
        }
    }
    
    override func draw(_ rect: CGRect) {
        print("рисую")
        setRounded()
        addGradient(color1: color1, color2: color2)
        setupShadow()
        
        if !imageSet {
            setMyImage(bounds)
        }
    }
    
    
    private func addGradient(color1: UIColor, color2: UIColor) {
        
//        let context = UIGraphicsGetCurrentContext()!
//
//        let colors = [color1.cgColor, color2.cgColor]
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//        let colorLocations: [CGFloat] = [0, 1]
//
//        let gradient = CGGradient(colorsSpace: colorSpace,
//                                  colors: colors as CFArray,
//                                  locations: colorLocations)!
//
//        let startPoint = CGPoint(x: 0, y: 0)
//        let endPoint = CGPoint(x: bounds.width, y: 0)
//        context.drawLinearGradient(gradient,
//                                   start: startPoint,
//                                   end: endPoint,
//                                   options: [])
        
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        let colorLocations: [NSNumber] = [0, 1]
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 1, y: 0)
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = colorLocations
        gradient.frame = bounds
        layer.insertSublayer(gradient, below: layer)
        print("Добавил градиент")
    }
    
    private func setRounded() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    private func setupShadow() {
        shadowView.frame = frame
        shadowView.layer.cornerRadius = layer.cornerRadius
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 2
        shadowView.backgroundColor = UIColor.white
        superview!.insertSubview(shadowView, belowSubview: self)
        print("Добавил тень кнопке")
    }

    private func setMyImage(_ rect: CGRect) {
        
        let inset = bounds.width / 5
        myImageView.frame = rect.inset(by: UIEdgeInsets(top: inset,
                                                        left: inset,
                                                        bottom: inset,
                                                        right: inset))
        myImageView.image = UIImage(named: "Стрелка вправо")
        myImageView.contentMode = .scaleAspectFit
        addSubview(myImageView)
        
        imageSet = true
    }
}
