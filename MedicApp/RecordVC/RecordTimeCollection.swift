//
//  RecordTimeCollection.swift
//  PatientApp
//
//  Created by Ацамаз Бицоев on 23/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension RecordVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return validTimeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordTimeCell", for: indexPath) as! RecordTimeCell
        
        cell.labTime.text = validTimeArr[indexPath.row]
        
        if indexPath == selectedIndexPath {
            
            cell.isSelected = true
            print("ячейка \(indexPath) выделена")
        } else {
            
            cell.isSelected = false
            print("ячейка \(indexPath) не выделена")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 2.5
        let height = collectionView.bounds.height / 2 - 4
        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? RecordTimeCell else { return }
        
        cell.isSelected = true
        selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    
    
}
