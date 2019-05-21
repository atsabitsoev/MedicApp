//
//  ChatVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 20/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import RxSwift
import RxKeyboard

class ChatVC: UIViewController {
    

    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var viewUnderTF: SimpleGradientView!
    @IBOutlet weak var constrHeaderTop: NSLayoutConstraint!
    @IBOutlet weak var constrLabTitleTop: NSLayoutConstraint!
    @IBOutlet weak var viewSend: ViewUnderTextFields!
    
    
    private var rxFirstCircle = true
    private var topSafeArea: CGFloat = 0
    private var bottomSafeArea: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTFMessage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        observeKeyboard()
    }
    
    
    private func observeKeyboard() {
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { (height) in
                if self.rxFirstCircle {
                    self.rxFirstCircle = false
                    return
                }
                if height == 0 {
                    self.keyboardHide()
                    print("Опустил клавиатуру")
                } else {
                    self.keyboardUp(height: height)
                    print("Поднял клавиатуру")
                }
            },
                   onCompleted: {
                    print("Готово")
            })
        
    }
    
    private func keyboardUp(height: CGFloat) {
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
        print(bottomSafeArea)
        
        self.view.frame.origin.y -= height
        constrHeaderTop.constant += height
        constrLabTitleTop.constant += height + topSafeArea
        viewSend.shadowView.frame.origin.y += bottomSafeArea
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
    private func keyboardHide() {
        
        self.view.frame.origin.y = 0
        constrHeaderTop.constant = 0
        constrLabTitleTop.constant = 8
        viewSend.shadowView.frame.origin.y -= bottomSafeArea
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
