//
//  MessageView.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 21/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


class MessageLabel: UILabel {
    
    
    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    private func commonInit() {
        setCornerRadius()
    }
    
    
    private func setCornerRadius() {
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
    }

}
