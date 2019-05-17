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
    var segmentedControlShadow: UIView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillLayoutSubviews() {
        
        self.view.layoutIfNeeded()
        configureSegmentedControl()
    }
    

    private func configureSegmentedControl() {
        
        segmentedControl.layer.cornerRadius = segmentedControl.bounds.height / 2
        segmentedControl.layer.borderColor = segmentedControl.tintColor.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.masksToBounds = true
        
//        segmentedControlShadow.frame = segmentedControl.frame
//        segmentedControlShadow.layer.cornerRadius = segmentedControl.layer.cornerRadius
//        segmentedControlShadow.backgroundColor = segmentedControl.tintColor
//        segmentedControlShadow.layer.shadowColor = UIColor.black.cgColor
//        segmentedControlShadow.layer.shadowOpacity = 0.2
//        segmentedControlShadow.layer.shadowRadius = 2
//        segmentedControlShadow.layer.shadowOffset = CGSize(width: 0, height: 4)
//        self.view.insertSubview(segmentedControlShadow, at: 0)
    }
    
    
}
