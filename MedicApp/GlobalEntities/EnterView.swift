//
//  ViewController.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 03/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class EnterView: UIViewController {
    
    
    @IBOutlet var viewWaveBottomMas: [WaveGradientView]!
    @IBOutlet weak var viewUnderTextFields: ViewUnderTextFields!
    @IBOutlet weak var butGo: ButtonGradient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        turnViewsUpsideDown(viewWaveBottomMas)
    }
    
    
    private func turnViewsUpsideDown(_ views: [UIView]) {
        for view in views {
            view.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}

