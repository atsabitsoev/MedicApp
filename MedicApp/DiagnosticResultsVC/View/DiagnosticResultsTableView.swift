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
        
        return masDiagnosticInfo[section].otherInfo.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return masDiagnosticInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosticResultsCell") as! DiagnosticResultsCell
        
        let currentInfo = masDiagnosticInfo[indexPath.section]
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: currentInfo.date)
        let dateString = "\(components.day!)/\(components.month!)/\(components.year!)"
        cell.labDate.text = dateString
        
        if indexPath.row == 0 {
            
            cell.labTitle.text = "Ваш позвоночник в 3D"
            
        } else if indexPath.row == 1 {
            
            cell.labTitle.text = "тут будет заключение врача"
            
        } else {
            
            cell.labTitle.text = currentInfo.otherInfo[indexPath.row - 2].name
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DiagnosticResultsCell else { return true }
        
        UIView.animate(withDuration: 0.05) {
            cell.viewMainCard.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.viewMainCard.shadowView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DiagnosticResultsCell else { return }
        
        UIView.animate(withDuration: 0.05) {
            cell.viewMainCard.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.viewMainCard.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let currentInfo = masDiagnosticInfo[indexPath.section]
            let masBackBoneUrl = currentInfo.backbone
            let masImagesData = masBackBoneUrl.map { (url) -> Data in
                do {
                    let data = try Data(contentsOf: url)
                    return data
                } catch {
                    print(error.localizedDescription)
                    return Data()
                }
            }
            
            let masImages = masImagesData.map { (data) -> UIImage in
                return UIImage(data: data) ?? UIImage()
            }
            
            let backboneVC = UIStoryboard(name: "DiagnosticResults", bundle: nil).instantiateViewController(withIdentifier: "BackboneVC") as! BackboneVC
            backboneVC.masImages = masImages
            self.present(backboneVC, animated: true, completion: nil)
        }
    }
    
    
    
    
}
