//
//  DiagnosticResultsVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 17/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class DiagnosticResultsVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delaysContentTouches = false

        DiagnosticService.standard.getDiagnosticInfoRequest()
    }
    

}
