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
    
    
    var masImages: [UIImage] = [UIImage(named: "Девушка фото")!,
                                UIImage(named: "Замок")!,
                                UIImage(named: "Запись иконка")!,
                                UIImage(named: "Конверт")!,
                                UIImage(named: "Отправить иконка")!,
                                UIImage(named: "Позвоночник")!,
                                UIImage(named: "Девушка фото")!,
                                UIImage(named: "Замок")!,
                                UIImage(named: "Запись иконка")!,
                                UIImage(named: "Конверт")!,
                                UIImage(named: "Отправить иконка")!,
                                UIImage(named: "Позвоночник")!,
                                UIImage(named: "Запись иконка")!,
                                UIImage(named: "Конверт")!,
                                UIImage(named: "Отправить иконка")!,
                                UIImage(named: "Позвоночник")!,
                                UIImage(named: "Девушка фото")!,
                                UIImage(named: "Замок")!,
                                UIImage(named: "Запись иконка")!,
                                UIImage(named: "Конверт")!,
                                UIImage(named: "Отправить иконка")!,
                                UIImage(named: "Позвоночник")!]
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
        
        imageMain.image = masImages.first ?? UIImage()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        previousTouchX = touches.first!.location(in: imageMain).x
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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

}
