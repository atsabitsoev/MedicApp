//
//  RecordVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class RecordVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedIndexPath: IndexPath?
    var validTimeArr: [Date] = [Date(), Date(), Date(), Date(), Date()]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
}
