//
//  ProfileVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    
    @IBOutlet weak var imProfile: UIImageView!
    @IBOutlet weak var constrTableViewTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeader: ProfileHeaderView!
    
    
    let masTextFieldTitles = ["Рост (см)",
                              "Вес (кг)",
                              "Возраст"]
    let masChooseTitles = ["Выберете ваш пол",
                           "Занимаетесь ли вы спортом?",
                           "Сидячая ли у вас работа?"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRecognizer()
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
        
        configureImProfile()
        setTableViewTop()
    }
    
    
    private func configureImProfile() {
        
        imProfile.layer.cornerRadius = imProfile.bounds.height / 2
    }
    
    private func setTableViewTop() {
        
        constrTableViewTop.constant = -viewHeader.bounds.height * 0.375
    }
    
    private func addRecognizer() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(turnOnOff(_:)))
        tableView.addGestureRecognizer(recognizer)
    }
    
    
    @objc func turnOnOff(_ recognizer: UITapGestureRecognizer) {
        
        guard let cell = tableView.cellForRow(at: tableView.indexPathForRow(at: recognizer.location(in: tableView))!) as? ProfileSelectCell else { return }
        
        cell.viewCheck0.turnOnOff()
    }
    
}
