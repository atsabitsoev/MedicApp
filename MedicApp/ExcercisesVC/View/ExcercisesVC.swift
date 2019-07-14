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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var segmentedControlShadow: UIView = UIView()
    
    
    var state = false {
        didSet {
            currentExercises = state ? allExercises : myExercises
        }
    }
    var getExercisesService = GetExercisesService.standard
    
    private var allExercises: [Exercise] = [] {
        didSet {
            if state {
                currentExercises = allExercises
            }
        }
    }
    private var myExercises: [Exercise] = [] {
        didSet {
            if !state {
                currentExercises = myExercises
            }
        }
    }
    var currentExercises: [Exercise] = [] {
        didSet {
            let animation = (currentExercises.count == 0) ? true : false
            loadingAnimation(state: animation)
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        tableView.delaysContentTouches = false
        getExercisesService.sendGetMyExcercisesRequest()
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myExercisesRequestAnswered),
                                               name: NSNotification.Name(rawValue: NotificationNames.getMyExercisesRequestAnswered.rawValue),
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
    
    private func loadingAnimation(state: Bool) {
        
        switch state {
        case true:
            activityIndicator.startAnimating()
        case false:
            activityIndicator.stopAnimating()
        }
    }
    
    
    @objc func allExercisesRequestAnswered() {
        
        guard getExercisesService.errorAllExcercises == nil else {
            
            let errorString = getExercisesService.errorAllExcercises!
            showErrorAlert(message: errorString)
            return
        }
        
        allExercises = getExercisesService.allExercises!
    }
    
    @objc func myExercisesRequestAnswered() {
        
        guard getExercisesService.errorMyExercises == nil else {
            
            let errorString = getExercisesService.errorMyExercises!
            showErrorAlert(message: errorString)
            return
        }
        
        myExercises = getExercisesService.myExercises!
    }
    
    
    @IBAction func stateChanged(_ sender: UISegmentedControl) {
        
        loadingAnimation(state: true)
        state = !state
        
        if allExercises.count == 0 && state {
            getExercisesService.sendGetAllExercisesRequest()
        }
    }
}
