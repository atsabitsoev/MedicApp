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
    @IBOutlet weak var viewTFMain: ViewRoundedBorders!
    @IBOutlet weak var tfMain: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func textChanged(_ sender: UITextField) {
        
        let profile = ProfileAPIService.standard.patientProfile
        
        switch sender.tag {
        case 1:
            profile?.growth = NSString(string: sender.text!).floatValue
        case 2:
            profile?.weight = NSString(string: sender.text!).floatValue
        case 3:
            profile?.age = Int(NSString(string: sender.text!).intValue)
        default:
            print("Error")
        }
    }
    
}
