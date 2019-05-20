//
//  ChatVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 20/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    

    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var viewBottom: SimpleGradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTFMessage()
    }
    
    
    private func configureTFMessage() {
        
        tfMessage.delegate = self
        
        tfMessage.layer.cornerRadius = 8
        
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        tfMessage.leftViewMode = .always
        tfMessage.leftView = spacerView
    }
    
    
    func putUpTFMessage() {
        
        
    }
    
}
