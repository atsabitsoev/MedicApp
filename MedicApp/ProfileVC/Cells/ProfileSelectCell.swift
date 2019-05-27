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
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func set(_ inPath: IndexPath) {
        
        viewCheck0.inPath = inPath
        viewCheck1.inPath = inPath
        addObservers(inPath)
    }
    
    private func addObservers(_ inPath: IndexPath) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCheck), name: NSNotification.Name("\(inPath) changedValue"), object: nil)
    }
    
    
    @objc private func changeCheck() {
        
        viewCheck0.isActive = !viewCheck0.isActive
        viewCheck1.isActive = !viewCheck1.isActive
        viewCheck0.setNeedsDisplay()
        viewCheck1.setNeedsDisplay()
        print("changed")
    }

}
