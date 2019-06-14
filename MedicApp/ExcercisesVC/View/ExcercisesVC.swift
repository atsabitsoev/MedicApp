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
    @IBOutlet weak var tableView: UITableView!
    var segmentedControlShadow: UIView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delaysContentTouches = false
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
    }
    
    
}
