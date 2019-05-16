//
//  ExcercisesVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 16/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ExcercisesVC: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let segmentedControlShadow: UIView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillLayoutSubviews() {
        
        configureSegmentedControl()
    }
    

    private func configureSegmentedControl() {
        
        segmentedControl.layer.cornerRadius = segmentedControl.bounds.height / 2
        segmentedControl.layer.borderColor = segmentedControl.tintColor.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.masksToBounds = true
        
        segmentedControlShadow.frame = segmentedControl.bounds
        segmentedControlShadow.backgroundColor = segmentedControl.tintColor
    }
    
    
}
