//
//  ExcercisesVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 16/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ExcercisesVC: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var segmentedControlShadow: UIView = UIView()
    
    
    let getExercisesService = GetExercisesService.standard
    var allExercises: [Exercise] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        tableView.delaysContentTouches = false
        GetExercisesService.standard.sendGetAllExercisesRequest()
    }
    
    
    override func viewWillLayoutSubviews() {
        
        self.view.layoutIfNeeded()
        configureSegmentedControl()
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(allExercisesRequestAnswered),
                                               name: NSNotification.Name(NotificationNames.getAllExercisesRequestAnswered.rawValue),
                                               object: nil)
    }
    

    private func configureSegmentedControl() {
        
        segmentedControl.layer.cornerRadius = segmentedControl.bounds.height / 2
        segmentedControl.layer.borderColor = segmentedControl.tintColor.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.masksToBounds = true
    }
    
    
    private func showErrorAlert(message: String?) {
        
        let alert = UIAlertController(title: "Ошибка", message: message ?? "Возникла неизвестная ошибка", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func allExercisesRequestAnswered() {
        
        guard getExercisesService.errorAllExcercises == nil else {
            
            let errorString = getExercisesService.errorAllExcercises!
            showErrorAlert(message: errorString)
            return
        }
        
        allExercises = getExercisesService.allExercises!
        tableView.reloadData()
    }
    
    
}
