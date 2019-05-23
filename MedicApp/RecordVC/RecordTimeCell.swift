//
//  RecordTimeCell.swift
//  PatientApp
//
//  Created by Ацамаз Бицоев on 23/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class RecordTimeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var labTime: UILabel!
    
    
    override var isSelected: Bool {
        didSet {
            setSelected(isSelected)
            layoutSubviews()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        labTime.layer.cornerRadius = labTime.bounds.height / 2
        labTime.layer.borderColor = UIColor.black.cgColor
        labTime.layer.borderWidth = isSelected ? 0 : 1
    }
    
    
    func setSelected(_ selected: Bool) {
        
        if selected {
            
            labTime.backgroundColor = #colorLiteral(red: 0, green: 0.8751577735, blue: 0.76799649, alpha: 1)
            labTime.textColor = .white
            labTime.layer.borderColor = UIColor.clear.cgColor
        } else {
            
            labTime.backgroundColor = .white
            labTime.textColor = .black
            labTime.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
}
