//
//  ProfileSelectCell.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ProfileSelectCell: UITableViewCell {
    
    
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var viewCheck0: ViewCheckRound!
    @IBOutlet weak var viewCheck1: ViewCheckRound!
    @IBOutlet weak var labVariant0: UILabel!
    @IBOutlet weak var labVariant1: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func set(_ inPath: IndexPath) {
        
        removeObservers(inPath)
        
        viewCheck0.inPath = inPath
        viewCheck1.inPath = inPath
        
        addObservers(inPath)
    }
    
    private func addObservers(_ inPath: IndexPath) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCheck), name: NSNotification.Name("\(inPath) changedValue"), object: nil)
    }
    
    private func removeObservers(_ inPath: IndexPath) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("\(inPath) changedValue"), object: nil)
    }
    
    
    @objc func changeCheck() {
        
        viewCheck0.isActive = !viewCheck0.isActive
        viewCheck1.isActive = !viewCheck1.isActive
        viewCheck0.setNeedsDisplay()
        viewCheck1.setNeedsDisplay()
        
        let profile = ProfileAPIService.standard.patientProfile
        
        switch self.tag {
        case 1:
            
            profile?.sex = viewCheck0.isActive ? Sex.male.rawValue : Sex.female.rawValue
            
        case 2:
            
            profile?.sport = viewCheck0.isActive
            
        case 3:
            
            profile?.workType = viewCheck0.isActive ? WorkType.active.rawValue : WorkType.sedentary.rawValue
            
        default:
            print("error")
        }
        
        print("changed")
    }

}
