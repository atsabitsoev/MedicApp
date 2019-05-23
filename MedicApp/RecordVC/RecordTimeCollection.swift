//
//  RecordTimeCollection.swift
//  PatientApp
//
//  Created by Ацамаз Бицоев on 23/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension RecordVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordTimeCell", for: indexPath)
        
        return cell
    }
    
    
}
