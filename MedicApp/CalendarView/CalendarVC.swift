
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
    
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var labMonth: UILabel!
    @IBOutlet weak var viewBig: UIView!
    
    
    private var months: [String] = ["Январь",
                                    "Февраль",
                                    "Март",
                                    "Апрель",
                                    "Май",
                                    "Июнь",
                                    "Июль",
                                    "Август",
                                    "Сентябрь",
                                    "Октябрь",
                                    "Ноябрь",
                                    "Декабрь"]
    private var currentMonth = 1 {
        didSet {
            labMonth.text = months[currentMonth]
        }
    }
    
    
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
        
        let now = Date()
        let calendar = Calendar.current
        let newComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: now)
        
        let todayStartDate = DateComponents(calendar: calendar, timeZone: TimeZone.current, era: 1, year: newComponents.year, month: newComponents.month, day: newComponents.day, hour: 0, minute: 0, second: 0, nanosecond: 0).date!
        
        return todayStartDate
    }
    
    func disableScrollingBeforeDate() -> Date {
        return self.earliestSelectableDate()
    }
    
    func didShowNextMonthView(_ date: Date) {
        updateLabMonth(true)
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        updateLabMonth(false)
    }
    
    func didSelectDayView(_ dayView: DayView) -> Bool {
        return true
    }
    
    private func updateLabMonth(_ next: Bool) {
        
        if currentMonth == 0 && next == false {
            currentMonth = 11
        } else if currentMonth == 11 && next == true {
            currentMonth = 0
        } else if next == false {
            currentMonth -= 1
        } else {
            currentMonth += 1
        }
        
    }
    
    
    // Overrides
    override func viewDidLoad() {
        menuView.delegate = self
        calendarView.delegate = self
        currentMonth = Calendar.current.component(.month, from: Date()) - 1
    }
    
    override func viewDidLayoutSubviews() {
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

}
