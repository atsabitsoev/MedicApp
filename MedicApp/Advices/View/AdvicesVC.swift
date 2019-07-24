
//
//  AdvicesVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 23/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AdvicesVC: UIViewController, ShowableImageVideo {
    
    
    let advicesService = AdvicesService.standard
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var advices: [Advice] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delaysContentTouches = false
        
        addObservers()
        advicesService.getAdvicesRequest()
    }
    
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(advicesFetched),
                                               name: NSNotification.Name(NotificationNames.getAdvicesRequestAnswered.rawValue),
                                               object: nil)
    }
    
    
    @objc private func advicesFetched() {
        
        guard advicesService.advices.count != 0 else {
            let errorString = advicesService.getAdvicesError
            showErrorAlert(errorString!)
            return
        }
        
        self.advices = advicesService.advices
        reloadTable(tableView: tableView)
    }
    
    
    private func reloadTable(tableView: UITableView) {
        
        let contentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.setContentOffset(contentOffset,
                                   animated: false)
    }
    
    
    private func showErrorAlert(_ errorString: String) {
        
        let alert = UIAlertController(title: "Ошибка",
                                      message: "\(errorString)",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    
    func openImage(url: URL) {
        print("openImage")
    }
    
    func openVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.present(playerVC,
                     animated: true,
                     completion: nil)
    }

}
