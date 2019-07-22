//
//  OpeningChatVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class OpeningChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.items![2].badgeColor = nil
        self.tabBarController?.tabBar.items![2].badgeValue = nil
    }

}
