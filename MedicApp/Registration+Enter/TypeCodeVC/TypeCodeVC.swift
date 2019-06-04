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
    @IBOutlet weak var tfCode: UITextField!
    
    
    let registrationService = RegistrationService.standard
    
    
    var userLogin: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        configureBackground()
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(confirmationRequestAnswered),
                                               name: NSNotification.Name(NotificationNames.confirmationRequestAnswered.rawValue),
                                               object: nil)
    }
    
    
    //MARK: Подтверждение кода
    
    private func sendConfirmRequest(login: String, code: String) {
        
        RegistrationService.standard.confirmLogin(login: login, code: code)
    }
    
    @objc private func confirmationRequestAnswered() {
        
        let success = registrationService.confirmationCodeSucceed
        
        if success {
            print("Регистрация прошла успешно")
        } else {
            tfCode.text = ""
        }
    }
    
    
    private func configureBackground() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        viewBackground.addGestureRecognizer(recognizer)
    }
    
    @objc private func backgroundTapped() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tfCodeTextChanged(_ sender: UITextField) {
        
        guard let code = sender.text, code.count == 5 else { return }
        
        sendConfirmRequest(login: userLogin!, code: code)
    }
    

}
