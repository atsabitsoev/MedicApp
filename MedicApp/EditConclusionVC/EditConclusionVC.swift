//
//  EditConclusionVC.swift
//  MedicTerapevtNew
//
//  Created by Ацамаз Бицоев on 03/08/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class EditConclusionVC: UIViewController {
    
    
    @IBOutlet weak var textViewMain: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var conclusion: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setOldConclusion()
    }
    
    
    private func setOldConclusion() {
        
        self.textViewMain.text = conclusion
    }
}
