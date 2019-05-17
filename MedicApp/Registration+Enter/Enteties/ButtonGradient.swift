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
    
    @IBInspectable var color2: UIColor = #colorLiteral(red: 0.9725490196, green: 0.3803921569, blue: 0.3568627451, alpha: 1)
    @IBInspectable var color1: UIColor = #colorLiteral(red: 0.9843137255, green: 0.6862745098, blue: 0.3764705882, alpha: 1)
    
    let myImageView = UIImageView()

    var imageSet = false
    
    @IBInspectable var needImage: Bool = true

    override var frame: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {

        if !imageSet && needImage {
            setMyImage(bounds)
        }
        configureButNext()
        
    }
    
    
    func configureButNext() {
        print("Рамка кнопки некст: \(bounds)")
        layer.cornerRadius = bounds.height/2
        addGradient(colors: [color1.cgColor,
                             color2.cgColor],
                    coordinatesX: [1,0],
                    coordinatesY: [0,0],
                    cornerRadius: layer.cornerRadius)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        let bounds = self.bounds
        let insetedBounds = bounds.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0))
        
        let shadowPath = CGPath(ellipseIn: insetedBounds, transform: nil)
        layer.shadowPath = shadowPath
    }
    
    private func setRounded() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
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
