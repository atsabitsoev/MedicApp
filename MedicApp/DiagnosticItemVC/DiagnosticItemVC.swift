//
//  DiagnosticItemVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 19/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class DiagnosticItemVC: UIViewController {
    
    
    @IBOutlet weak var imageMain: UIImageView!
    
    
    var image: UIImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageMain.image = image
    }

}
