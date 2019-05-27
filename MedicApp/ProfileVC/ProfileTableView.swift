//
//  ProfileTableView.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masTextFieldTitles.count + masChooseTitles.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
        
            return UIScreen.main.bounds.height * (241/812) * 0.375
        
        } else if indexPath.row <= masTextFieldTitles.count {
            
            return 55
            
        } else {
            
            return 124
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.row == 0 {
            
            let cell = UITableViewCell()
            let headerHeight = UIScreen.main.bounds.height * (241/812) * 0.375
            let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerHeight))
            let label = UILabel(frame: header.bounds.inset(by: UIEdgeInsets(top: 25, left: 18, bottom: 0, right: 18)))
            
            label.text = "Помогите нам улучшить сервис, заполнив данные:"
            label.font = UIFont(name: "SF Compact Rounded Medium", size: 18)
            label.textColor = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1)
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            
            header.addSubview(label)
            cell.contentView.addSubview(header)
            return cell
        
        } else if indexPath.row <= masTextFieldTitles.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell") as! ProfileTextFieldCell
            cell.labTitle.text = masTextFieldTitles[indexPath.row - 1]
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSelectCell") as! ProfileSelectCell
            cell.labTitle.text = masChooseTitles[indexPath.row - masTextFieldTitles.count - 1]
            cell.set(indexPath)
            return cell
            
        }
        
    }
    
    
}
