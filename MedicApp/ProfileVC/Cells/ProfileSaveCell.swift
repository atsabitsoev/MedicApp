//
//  ProfileSaveCell.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 06/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ProfileSaveCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func saveTapped(_ sender: UIButton) {
        
        ProfileAPIService.standard.postProfileRequest()
        NotificationManager.post(.profileSavingBegan)
    }
}
