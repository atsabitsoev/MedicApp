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
    @IBOutlet weak var viewUnderLabTime: ViewUnderTextFields!
    
    
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
    }
    
    
    func setSelected(_ selected: Bool) {
        
        if selected {
            
            viewUnderLabTime.mainColor = Colors().greenMain
            labTime.textColor = .white
        } else {
            
            viewUnderLabTime.mainColor = .white
            labTime.textColor = .black
        }
        
        viewUnderLabTime.draw(viewUnderLabTime.bounds)
        
    }
    
}
