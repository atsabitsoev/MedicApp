//
//  BackboneVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 18/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class BackboneVC: UIViewController {
    
    
    @IBOutlet weak var imageMain: UIImageView!
    
    
    var loadingFinished = false {
        didSet {
            if loadingFinished {
                imageMain.image = masImages.first
            }
        }
    }
    
    var linksImages = [URL]()
    private var masImages: [UIImage] = []
    var previousTouchX: CGFloat?
    var currentImageIndex = 0 {
        didSet {
            if currentImageIndex >= masImages.count {
                currentImageIndex = 0
            } else if currentImageIndex < 0 {
                currentImageIndex = masImages.count - 1
            }
            imageMain.image = masImages[currentImageIndex]
            print(currentImageIndex)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadImages()
    }
    
    
    private func loadImages() {
        
        let progressStep: Float = Float(1)/Float(linksImages.count)
        
        for link in linksImages {
            
            do {
                let imageData = try Data(contentsOf: link)
                let image = UIImage(data: imageData)
                masImages.append(image!)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        self.loadingFinished = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        previousTouchX = touches.first!.location(in: imageMain).x
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard self.previousTouchX != nil else { return }
        
        let step = UIScreen.main.bounds.width / CGFloat(masImages.count) / 2
        
        if touches.first!.location(in: imageMain).x - previousTouchX! >= step {
            currentImageIndex += 1
            previousTouchX = touches.first!.location(in: imageMain).x
        } else if touches.first!.location(in: imageMain).x - previousTouchX! <= -step {
            currentImageIndex -= 1
            previousTouchX = touches.first!.location(in: imageMain).x
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        previousTouchX = nil
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
