//
//  ProfileTextFieldCell.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ProfileTextFieldCell: UITableViewCell {
    
    
    
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var tfMain: ViewRoundedBorders!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
