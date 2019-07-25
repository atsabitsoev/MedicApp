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
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfSurname: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let masTextFieldTitles = ["Рост (см)",
                              "Вес (кг)",
                              "Возраст"]
    let masChooseTitles = ["Выберете ваш пол",
                           "Занимаетесь ли вы спортом?",
                           "Какая у вас работа?"]
    let masVariants = [["Мужской","Женский"],
                       ["Да","Нет"],
                       ["Активная","Сидячая"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delaysContentTouches = false
        addObservers()
        
        ProfileAPIService.standard.getProfileRequest()
        startLoadingAnimation()
    }
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
        
        configureImProfile()
        setTableViewTop()
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getProfileRequestAnswered),
                                               name: NSNotification.Name(rawValue: NotificationNames.getProfileRequestAnswered.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(postProfileRequestAnswered),
                                               name: NSNotification.Name(rawValue: NotificationNames.postProfileRequestAnswered.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(profileSavingBegan),
                                               name: NSNotification.Name(rawValue: NotificationNames.profileSavingBegan.rawValue),
                                               object: nil)
        
        
    }
    
    
    @objc private func profileSavingBegan() {
        startLoadingAnimation()
        saveNameSurname()
    }
    
    @objc private func getProfileRequestAnswered() {
        stopLoadingAnimation()
        
        guard ProfileAPIService.standard.getErrorString == nil else {
            
            errorAlert(ProfileAPIService.standard.getErrorString!)
            return
        }
        
        tfName.text = ProfileAPIService.standard.patientProfile?.name
        tfSurname.text = ProfileAPIService.standard.patientProfile?.surname
        print(ProfileAPIService.standard.patientProfile?.sex)
        tableView.reloadData()
    }
    
    @objc private func postProfileRequestAnswered() {
        stopLoadingAnimation()
        
        guard ProfileAPIService.standard.postErrorString == nil else {
            
            errorAlert(ProfileAPIService.standard.getErrorString!)
            return
        }
        
        successAlert("Ваши данные успешно сохранены")
    }
    
    
    private func errorAlert(_ message: String) {
        
        let alert = UIAlertController(title: "Ошибка",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    private func successAlert(_ message: String) {
        
        let alert = UIAlertController(title: "Успех!",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок",
                                   style: .cancel,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    
    private func saveNameSurname() {
        
        guard let name = tfName.text, let surname = tfSurname.text else { return }
        SaveManager.save(value: name, key: .userName)
        SaveManager.save(value: surname, key: .userSurname)
    }
    
    private func setSavedData() {
        
        guard let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue), let surname = UserDefaults.standard.string(forKey: UserDefaultsKeys.userSurname.rawValue) else { return }
        
        tfName.text = name
        tfSurname.text = surname
    }
    
    
    private func startLoadingAnimation() {
        
        activityIndicator.startAnimating()
    }
    
    private func stopLoadingAnimation() {
        
        activityIndicator.stopAnimating()
    }
    
    
    private func configureImProfile() {
        
        imProfile.layer.cornerRadius = imProfile.bounds.height / 2
    }
    
    private func setTableViewTop() {
        
        constrTableViewTop.constant = -viewHeader.bounds.height * 0.375
    }
    
    
    private func showLogOutAlert() {
        let alert = UIAlertController(title: "Вы уверены?",
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Выйти",
                                     style: .default) { (action) in
                                        self.logOut()
        }
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    private func logOut() {
        
        ChatService.standard!.stopConnection()
        UserDefaults.standard.set(false, forKey: "userEntered")
        let storyboard = UIStoryboard(name: "Registration+Enter", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "EnterVC")
        self.present(loginVC,
                     animated: true,
                     completion: nil)
    }
    
    
    @IBAction func nameChanged(_ sender: UITextField) {
        
        ProfileAPIService.standard.patientProfile?.name = sender.text ?? ""
    }
    
    @IBAction func surnameChanged(_ sender: UITextField) {
        
        ProfileAPIService.standard.patientProfile?.surname = sender.text ?? ""
    }
    
    @IBAction func butLogOutTapped(_ sender: UIButton) {
        
        showLogOutAlert()
    }
    
}
