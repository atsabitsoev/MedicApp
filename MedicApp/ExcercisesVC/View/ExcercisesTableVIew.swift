//
//  ExcercisesTableVIew.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 17/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SDWebImage


extension ExcercisesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentExercises[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "excercisesCell") as! ExercisesCell
        
        cell.labTitle.text = currentExercises[indexPath.section][indexPath.row].name
        
        let imageUrl = currentExercises[indexPath.section][indexPath.row].preview
        cell.imagePreview.sd_setImage(with: imageUrl, completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8 + 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: UIScreen.main.bounds.width,
                          height: 8 + 24)
        let view = UIView(frame: rect)
        let label = UILabel(frame: rect.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)))
        label.text = currentExercises[section].first!.category
        label.font = UIFont(name: "SFCompactRounded-Bold", size: 24)!
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let videoURL = currentExercises[indexPath.section][indexPath.row].video
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        let cell = tableView.cellForRow(at: indexPath) as! ExercisesCell
        
        UIView.animate(withDuration: 0.05) {
            cell.viewShadow.shadowView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.viewPlay.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.imagePreview.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ExercisesCell
        
        UIView.animate(withDuration: 0.05) {
            cell.viewShadow.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.viewPlay.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.imagePreview.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
}
