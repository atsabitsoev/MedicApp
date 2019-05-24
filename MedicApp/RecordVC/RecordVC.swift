//
//  RecordVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class RecordVC: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var viewUnderButChooseDate: ViewUnderTextFields!
    @IBOutlet weak var butChooseDate: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfFathersName: UITextField!
    
    
    
    var selectedIndexPath: IndexPath?
    var validTimeArr: [Date] = [Date(), Date(), Date(), Date(), Date()]
    
    
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
        
        
    }
    
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(activateTabBar), name: NSNotification.Name(rawValue: NotificationNames.calendarClosed.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deactivateTabBar), name: NSNotification.Name(rawValue: NotificationNames.calendarOpened.rawValue), object: nil)
    }
    
    @objc private func activateTabBar() {
        
        self.tabBarController!.tabBar.isUserInteractionEnabled = true
    }
    
    @objc private func deactivateTabBar() {
        
        self.tabBarController!.tabBar.isUserInteractionEnabled = false
    }
    
    
    private func setTfDelegates() {
        
        tfLastName.delegate = self
        tfName.delegate = self
        tfFathersName.delegate = self
    }
    
    
    func updateButChooseDate() {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: record!.date!)
        
        let dateString = "\(components.day!)/\(components.month!)/\(components.year!)"
        
        self.viewUnderButChooseDate.mainColor = Colors().greenMain
        self.viewUnderButChooseDate.draw(viewUnderButChooseDate.bounds)
        butChooseDate.setTitleColor(.white, for: .normal)
        
        butChooseDate.setTitle(dateString, for: .normal)
        
        showTimeCollectionView()
    }
    
    private func showTimeCollectionView() {
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
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
