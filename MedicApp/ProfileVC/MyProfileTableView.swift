//
//  MyProfileTableView.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 29/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class MyProfileTableView: UITableView {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addRecognizer()
    }
    
    
    private func addRecognizer() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(turnOnOff(_:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc func turnOnOff(_ recognizer: UITapGestureRecognizer) {
        
        guard let cell = cellForRow(at: indexPathForRow(at: recognizer.location(in: self))!) as? ProfileSelectCell else { return }
        
        cell.viewCheck0.turnOnOff()
    }

}
