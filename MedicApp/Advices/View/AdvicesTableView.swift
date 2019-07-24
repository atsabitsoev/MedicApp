//
//  AdvicesTableView.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 24/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import UIKit


extension AdvicesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentAdvice = advices[indexPath.row]
        
        switch currentAdvice.type {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdvicesTextCell") as! AdvicesTextCell
            cell.labName.text = currentAdvice.name ?? "Совет"
            cell.labText.text = currentAdvice.text ?? ""
            return cell
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdvicesCollectionCell") as! AdvicesCollectionCell
            cell.type = .image
            cell.images = currentAdvice.imageUrls
            return cell
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdvicesCollectionCell") as! AdvicesCollectionCell
            cell.type = .video
            cell.images = currentAdvice.videoPreviewUrls
            cell.videos = currentAdvice.videoUrls
            return cell
        }
    
        
        let cell = UITableViewCell()
        return cell
    }
    
    
}
