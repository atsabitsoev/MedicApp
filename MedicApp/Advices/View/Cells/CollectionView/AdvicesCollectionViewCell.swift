//
//  AdvicesCollectionViewCell.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class AdvicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imView: UIImageView! {
        didSet {
            imView.contentMode = .scaleAspectFill
        }
    }
}
