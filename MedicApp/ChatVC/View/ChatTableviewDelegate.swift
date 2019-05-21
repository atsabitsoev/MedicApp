//
//  ChatTableviewDelegate.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 21/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messageArr[indexPath.row]
        
        switch (message.sender, message.contentType) {
            
        case (.user, .text):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMessageCell") as! UserMessageCell
            cell.labText.text = message.text
            return cell
            
        case (.penPal, .text):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PenPalMessageCell") as! PenPalMessageCell
            cell.labText.text = message.text
            return cell
            
        case (.user, .photo):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserImageCell") as! UserImageCell
            let image = messageArr[indexPath.row].image
            cell.imageMain.image = image
            cell.set(image: image!)
            return cell
        
        default:
        
            return UITableViewCell()
            
        }
        
    }
    
    
}
