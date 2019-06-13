//
//  RecordVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class RecordVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    
    let recordService = RecordService.standard
    
    
    @IBOutlet weak var viewUnderButChooseDate: ViewUnderTextFields!
    @IBOutlet weak var butChooseDate: UIButton!
    @IBOutlet weak var butRecord: ButtonGradient!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewUnderButRecord: ViewUnderTextFields!
    
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfFathersName: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var selectedIndexPath: IndexPath?
    var validTimeArr: [String] = []
    
    
    var record: Record?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        setTfDelegates()
        
        record = Record(name: "",
                        lastName: "",
                        fathersName: "",
                        phoneOrEmail: "",
                        date: nil)
        collectionView.alpha = 0
        
        self.scrollView.delaysContentTouches = false

    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(activateTabBar),
                                               name: NSNotification.Name(rawValue: NotificationNames.calendarClosed.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deactivateTabBar),
                                               name: NSNotification.Name(rawValue: NotificationNames.calendarOpened.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(timesRequestAnswered),
                                               name: NSNotification.Name(rawValue: NotificationNames.getValidHoursRequestAnswered.rawValue),
                                               object: nil)
    }
    
    @objc private func activateTabBar() {
        
        self.tabBarController!.tabBar.isUserInteractionEnabled = true
    }
    
    @objc private func deactivateTabBar() {
        
        self.tabBarController!.tabBar.isUserInteractionEnabled = false
    }
    
    @objc private func timesRequestAnswered() {
        
        activityIndicator.stopAnimating()
        
        guard recordService.getHoursError == nil else {
            showErrorAlert(message: recordService.getHoursError!)
            return
        }
        
        validTimeArr = recordService.arrValidHours!
        showTimeCollectionView()
    }
    
    
    private func setTfDelegates() {
        
        tfLastName.delegate = self
        tfName.delegate = self
        tfFathersName.delegate = self
    }
    
    
    func updateDate() {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: record!.date!)
        
        
        let dateString = "Ваша дата: \(components.day!)/\(components.month!)/\(components.year!)"
        
        self.viewUnderButChooseDate.mainColor = Colors().greenMain
        self.viewUnderButChooseDate.draw(viewUnderButChooseDate.bounds)
        butChooseDate.setTitleColor(.white, for: .normal)
        
        butChooseDate.setTitle(dateString, for: .normal)
        
        sendGetTimeArrRequest(day: "\(components.day!).\(components.month!).\(components.year!)")
        activityIndicator.startAnimating()
    }
    
    
    //MARK: Показать ошибку
    
    private func showErrorAlert(message: String?) {
        
        let alert = UIAlertController(title: "Ошибка", message: message ?? "Возникла неизвестная ошибка", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    private func sendGetTimeArrRequest(day: String) {
        
        RecordService.standard.getValidHoursRequest(day: day)
    }
    
    
    private func showTimeCollectionView() {
        collectionView.alpha = 0
        selectedIndexPath = nil
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        }
        
    }
    
    
    
    
    @IBAction func butChooseDateTouchDown(_ sender: UIButton) {
        butChooseDateTouchDown()
    }
    @IBAction func butChooseDateTouchUpInside(_ sender: UIButton) {
        butChooseDateTouchUp()
    }
    @IBAction func butChooseDateTouchUpOutside(_ sender: UIButton) {
        butChooseDateTouchUp()
    }
    
    private func butChooseDateTouchDown() {
        UIView.animate(withDuration: 0.05) {
            self.viewUnderButChooseDate.shadowView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.butChooseDate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func butChooseDateTouchUp() {
        UIView.animate(withDuration: 0.05) {
            self.viewUnderButChooseDate.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.butChooseDate.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
    
    @IBAction func butRecordTouchDown(_ sender: UIButton) {
        butRecordTouchDown()
    }
    
    @IBAction func butRecordTouchUpInside(_ sender: UIButton) {
        butRecordTouchUp()
    }
    
    @IBAction func butRecordTouchUpOutside(_ sender: UIButton) {
        butRecordTouchUp()
    }
    
    private func butRecordTouchDown() {
        UIView.animate(withDuration: 0.05) {
            self.butRecord.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.viewUnderButRecord.shadowView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func butRecordTouchUp() {
        UIView.animate(withDuration: 0.05) {
            self.butRecord.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.viewUnderButRecord.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    
    @IBAction func butChooseDateTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func butRecordTapped(_ sender: ButtonGradient) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CalendarSegue" {
            
            let destination = segue.destination as! CalendarVC
            destination.recordVC = self
        }
    }
    
    
    //Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
