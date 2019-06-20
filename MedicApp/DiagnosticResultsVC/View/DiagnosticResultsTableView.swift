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
        
        if indexPath.row == 1 {
            
            cell.labTitle.text = "Ваш позвоночник в 3D"
            
        } else if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosticConclusionCell") as! DiagnosticConclusionCell
            cell.labDate.text = dateString
            cell.labConclusion.text = currentInfo.conclusion
            return cell
            
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
        
        if indexPath.row == 1 {
            
            let currentInfo = masDiagnosticInfo[indexPath.section]
            let masBackBoneUrl = currentInfo.backbone
            
            let backboneVC = UIStoryboard(name: "DiagnosticResults", bundle: nil).instantiateViewController(withIdentifier: "BackboneVC") as! BackboneVC
            backboneVC.linksImages = [URL(string: "https://i.pinimg.com/originals/1e/fa/36/1efa368e017d53a8702f2a3da63de2b5.jpg")!,
                                      URL(string: "https://wallpapershome.ru/images/wallpapers/oboi-ayfon-8-3840x2160-oboi-ayfon-8-15475.jpg")!,
                                      URL(string: "http://www.radionetplus.ru/uploads/posts/2015-08/1439144004_12-www.radionetplus.ru.jpg")!]//masBackBoneUrl
            self.navigationController?.show(backboneVC, sender: nil)
            
        } else if indexPath.row != 0 {
            
            let currentInfo = masDiagnosticInfo[indexPath.section].otherInfo[indexPath.row - 2]
            
            let diagnosticItemVC = UIStoryboard(name: "DiagnosticResults",
                                                bundle: nil)
                .instantiateViewController(withIdentifier: "DiagnosticItemVC") as! DiagnosticItemVC
            
            do {
                
                let imageData = try Data(contentsOf: currentInfo.imageUrl)
                let image = UIImage(data: imageData) ?? UIImage()
                diagnosticItemVC.image = image
                diagnosticItemVC.navigationItem.title = currentInfo.name
                self.navigationController?.show(diagnosticItemVC, sender: nil)
                
            } catch {
                
                return
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
}
