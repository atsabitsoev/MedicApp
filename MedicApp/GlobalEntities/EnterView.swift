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
    @IBOutlet weak var viewUnderButRegistration: ViewUnderTextFields!
    
    
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
    
    
    @IBAction func butRegistrationTouchDown(_ sender: UIButton) {
        animateButRegistration(pressed: true)
    }
    
    @IBAction func butRegistrationTouchUpInside(_ sender: UIButton) {
        animateButRegistration(pressed: false)
    }
    
    @IBAction func butRegistrationTouchUpOutside(_ sender: UIButton) {
        animateButRegistration(pressed: false)
    }
    
    private func animateButRegistration(pressed: Bool) {
        
        switch pressed {
        case true:
            
            UIView.animate(withDuration: 0.1) {
                self.viewUnderButRegistration.shadowView.transform = CGAffineTransform(scaleX: 1, y: 0.9)
            }
            
        case false:
            
            UIView.animate(withDuration: 0.1) {
                self.viewUnderButRegistration.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            
        }
    }
    
    
    @IBAction func butGoTouchDown(_ sender: UIButton) {
        animateButGo(pressed: true)
    }
    
    @IBAction func butGoTouchUpInside(_ sender: UIButton) {
        animateButGo(pressed: false)
    }
    
    @IBAction func butGoTouchUpOutside(_ sender: UIButton) {
        animateButGo(pressed: false)
    }
    
    private func animateButGo(pressed: Bool) {
        
        switch pressed {
        case true:
            
            UIView.animate(withDuration: 0.1) {
                self.butGo.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            
        case false:
            
            UIView.animate(withDuration: 0.1) {
                self.butGo.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}

