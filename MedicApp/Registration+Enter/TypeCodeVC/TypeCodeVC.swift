//
//  TypeCodeVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 03/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class TypeCodeVC: UIViewController {
    
    
    @IBOutlet weak var viewBackground: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
    }
    
    
    private func configureBackground() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        viewBackground.addGestureRecognizer(recognizer)
    }
    
    @objc private func backgroundTapped() {
        
        self.dismiss(animated: true, completion: nil)
    }

}
