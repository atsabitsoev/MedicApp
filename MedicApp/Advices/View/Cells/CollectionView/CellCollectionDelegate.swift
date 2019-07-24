//
//  CellCollectionDelegate.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit


extension AdvicesCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvicesCollectionViewCell", for: indexPath) as! AdvicesCollectionViewCell
        
        DispatchQueue.main.async {
            do {
                let imageData = try Data(contentsOf: self.images[indexPath.row])
                cell.imView.image = UIImage(data: imageData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.type {
        case AdviceType.image:
            openImage(url: images[indexPath.row])
        case AdviceType.video:
            openVideo(url: videos![indexPath.row])
        default:
            print("error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.bounds.height
        let width = height
        let size = CGSize(width: width,
                          height: height)
        return size
    }
    
    
}
