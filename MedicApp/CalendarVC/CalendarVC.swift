
//
//  CalendarVC.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 23/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarVC: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    
    // CalendarDelegate
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        print(dayView.dayLabel.text)
    }
    
    func earliestSelectableDate() -> Date {
        return Date()
    }
    
    
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuView.delegate = self
        calendarView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

}
