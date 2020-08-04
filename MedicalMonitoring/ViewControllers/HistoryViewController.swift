//
//  HistoryViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 29.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FSCalendar

class HistoryViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource
{

    var calendar :FSCalendar!
    var formatter = DateFormatter()
    var datesWithEvent = ["2020-10-03", "2020-10-06", "2020-10-12", "2020-10-25"]

    var datesWithMultipleEvents = ["2020-10-08", "2020-10-16", "2020-10-20", "2020-10-28"]

    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString) {
            return 1
        }

        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }

        return 0
    }
    lazy var modeSegmentedControl:UISegmentedControl = {
        let mode = UISegmentedControl(items: ["Week", "Month"])
        mode.selectedSegmentIndex = 1
        mode.layer.cornerRadius = 6
        mode.layer.borderWidth = 1
        mode.layer.masksToBounds = true
        mode.layer.borderColor = UIColor.white.cgColor
        mode.tintColor = .white
        mode.addTarget(self, action: #selector(changeCalendarMode), for: .touchUpInside)
        return mode
    }()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(modeSegmentedControl)
        modeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        modeSegmentedControl.topAnchor.constraint(equalTo:view.topAnchor , constant: 90).isActive = true
        modeSegmentedControl.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
         modeSegmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Configure Calendar Object
        calendar = FSCalendar(frame: .zero)
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.locale = Locale(identifier: "en")
        self.view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 380).isActive = true
        calendar.topAnchor.constraint(equalTo: modeSegmentedControl.bottomAnchor).isActive = true
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
        calendar.appearance.todayColor = .systemGreen
        calendar.appearance.titleTodayColor = .white
        //calendar.appearance.titleDefaultColor = .systemBlue
      //  calendar.appearance.titleWeekendColor
        calendar.dataSource = self
        calendar.delegate = self
        

    }
    
    //MARK:-Change Calender Mode
    @objc func changeCalendarMode( sender : UISegmentedControl)
    {
        print("sender.selectedSegmentIndex")
        switch sender.selectedSegmentIndex
        {
            case 0:
                calendar.scope = .week
            case 1:
                calendar.scope = .month
            default:
                calendar.scope = .month
        }
    }
    
    // MARK:- Delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Date Selected = \(formatter.string(from: date))")
    }
    
    //MARK: - Datasource
    

   

}
