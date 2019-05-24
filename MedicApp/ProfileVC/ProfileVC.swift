//
//  ProfileVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    
    @IBOutlet weak var imProfile: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
        imProfile.layer.cornerRadius = imProfile.bounds.height / 2
    }

    
}
