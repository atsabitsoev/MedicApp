
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
    @IBOutlet weak var viewBackground: UIView!
    
    
    var recordVC: RecordVC?
    
    
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
        let day = dayView.date.day
        let month = dayView.date.month
        let year = dayView.date.year
        
        let date = DateComponents(calendar: .current, timeZone: .current, era: 0, year: year, month: month, day: day).date
        
        recordVC!.record?.date = date
        recordVC!.updateButChooseDate()
        dismissVC()
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
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
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
    
    @objc private func dismissVC() {
        NotificationManager.post(.calendarClosed)
        dismiss(animated: true, completion: nil)
    }
    
    
    // Overrides
    override func viewDidLoad() {
        
        NotificationManager.post(.calendarOpened)
        
        menuView.delegate = self
        calendarView.delegate = self
        calendarView.calendarDelegate = self
        currentMonth = Calendar.current.component(.month, from: Date()) - 1
        
        let recognizerToDismissVC = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        viewBackground.addGestureRecognizer(recognizerToDismissVC)
    }
    
    override func viewDidLayoutSubviews() {
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

}
