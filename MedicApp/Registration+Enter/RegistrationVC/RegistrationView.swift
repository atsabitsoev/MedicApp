//
//  ViewController.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 03/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class RegistrationView: UIViewController {
    
    
    @IBOutlet var viewWaveBottomMas: [WaveGradientView]!
    @IBOutlet weak var viewUnderTextFields: ViewUnderTextFields!
    @IBOutlet weak var butGo: ButtonGradient!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        turnViewsUpsideDown(viewWaveBottomMas)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateButGo()
    }
    
    
    private func turnViewsUpsideDown(_ views: [UIView]) {
        for view in views {
            view.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    private func animateButGo() {
        
        let radius = butGo.bounds.height / 2
        
        UIView.animate(withDuration: 0.3) {
            self.butGo.frame = CGRect(x: self.viewUnderTextFields.frame.maxX - radius,
                                       y: self.viewUnderTextFields.center.y - radius,
                                       width: self.butGo.frame.width,
                                       height: self.butGo.frame.height)
        }
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

}

