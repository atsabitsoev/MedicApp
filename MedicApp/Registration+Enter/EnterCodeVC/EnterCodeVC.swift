//
//  EnterCodeVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 05/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class EnterCodeVC: UIViewController {
    
    
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var viewUnderTfCode: SimpleGradientView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewShadowButSend: ViewUnderTextFields!
    @IBOutlet weak var butSend: ButtonGradient!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        showTfCode()
    }
    
    
    private func configureView() {
        
        tfCode.isHidden = true
        viewUnderTfCode.isHidden = true
        labTitle.text = "Введите логин"
        tfLogin.isSecureTextEntry = false
    }
    
    private func showTfCode() {
        
        tfCode.isHidden = false
        viewUnderTfCode.isHidden = false
        labTitle.text = "Введите новый пароль и код подтверждения"
        tfLogin.placeholder = "Новый пароль"
        tfLogin.isSecureTextEntry = true
    }
    
    
    private func startAnimationLoading() {
        
        activityIndicator.startAnimating()
    }
    
    private func stopAnimationLoading() {
        
        activityIndicator.stopAnimating()
    }

}
