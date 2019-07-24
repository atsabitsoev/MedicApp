//
//  AdviceImageVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class AdviceImageVC: UIViewController {
    
    
    var imageURL: URL!
    
    
    @IBOutlet weak var imView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            do {
                let imageData = try Data(contentsOf: self.imageURL)
                let image = UIImage(data: imageData)
                self.imView.image = image
                self.activityIndicator.stopAnimating()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func butCloseTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}
