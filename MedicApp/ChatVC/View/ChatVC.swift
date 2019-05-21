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
    @IBOutlet weak var viewUnderTF: SimpleGradientView!
    @IBOutlet weak var constrHeaderTop: NSLayoutConstraint!
    @IBOutlet weak var constrLabTitleTop: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        configureTFMessage()
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            var topSafeArea: CGFloat
            
            if #available(iOS 11.0, *) {
                topSafeArea = view.safeAreaInsets.top
            } else {
                topSafeArea = topLayoutGuide.length
            }
            
            self.view.frame.origin.y -= keyboardSize.height
            constrHeaderTop.constant += keyboardSize.height
            constrLabTitleTop.constant += keyboardSize.height + topSafeArea
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
        constrHeaderTop.constant = 0
        constrLabTitleTop.constant = 8
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureTFMessage() {
        
        tfMessage.delegate = self
        
        tfMessage.layer.cornerRadius = 8
        
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        tfMessage.leftViewMode = .always
        tfMessage.leftView = spacerView
    }
    
}
