//
//  DiagnosticResultsTableView.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 17/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension DiagnosticResultsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosticResultsCell")!
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        let cell = tableView.cellForRow(at: indexPath) as! DiagnosticResultsCell
        
        UIView.animate(withDuration: 0.05) {
            cell.viewMainCard.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.viewMainCard.shadowView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! DiagnosticResultsCell
        
        UIView.animate(withDuration: 0.05) {
            cell.viewMainCard.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.viewMainCard.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
    
    
}
