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
        
        setNavigationBar()
    }
    
    
    private func setNavigationBar() {
        
        let itemShare = UIBarButtonItem(image: UIImage(named: "Поделиться"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(shareTapped))
        self.navigationItem.setRightBarButtonItems([itemShare], animated: false)
    }
    
    @objc private func shareTapped() {
        
        let imageToShare = [imageMain.image!]
        let activityVC = UIActivityViewController(activityItems: imageToShare,
                                                  applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,
                     animated: true,
                     completion: nil)
    }

}
