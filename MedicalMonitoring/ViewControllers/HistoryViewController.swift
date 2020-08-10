//
//  HistoryViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 29.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FSCalendar
import FirebaseDatabase
import FirebaseAuth

class HistoryViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource
{

    var tableView = UITableView()
    var calendar :FSCalendar!
    var formatter = DateFormatter()
    var datesWithEvents = [String]()
    var listOfVisit = [Visit]()
    var btn : UIButton!
    var datesWithMultipleEvents = ["2020-09-08", "2020-08-06", "2020-10-20", "2020-10-28","2020-08-08", "2020-08-16", "2020-07-20", "2020-08-28"] //test

    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    lazy var modeSegmentedControl:UISegmentedControl = {
        let mode = UISegmentedControl(items: ["Week", "Month"])
        mode.selectedSegmentIndex = 1
        mode.layer.cornerRadius = 6
        mode.layer.borderWidth = 1
        mode.layer.masksToBounds = true
        mode.layer.borderColor = UIColor.white.cgColor
        mode.tintColor = .white
        mode.addTarget(self, action: #selector(changeCalendarMode(sender:)), for: .valueChanged)
        return mode
    }()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9682844883, green: 0.9682844883, blue: 0.9682844883, alpha: 1)
        configureModeSegmented()
        configureCalendar()
        configureTableView()
        retrievingInformationFromDatabase()
        floatingButton()
        Constants.setupFloatButton(button: btn)
        
       
    }
    
    //MARK:-Change Calender Mode
    @objc func changeCalendarMode( sender : UISegmentedControl)
    {
       
        switch sender.selectedSegmentIndex
        {
            case 0:
                self.calendar.scope = .week
           
            case 1:
                self.calendar.scope = .month
                
            default:
                self.calendar.scope = .month
        }
        
    }
    
    // MARK:- Delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Date Selected = \(formatter.string(from: date))")
    }
    
    //MARK: - Datasource
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvents.contains(dateString) {
            return 2
        }

        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }

        return 0
    }
    //MARK: -Fetching Element from Firebase Database
    func retrievingInformationFromDatabase()
    {
           let ref = Database.database().reference()
           ref.child("History").observe(.childAdded)
           {     (snapshot) in
                      
               if let dico = snapshot.value as? [String:AnyObject]
               {
                   if let id = dico["id"] as? String
                   {
                        print(dico)
                        if id == Auth.auth().currentUser?.uid
                        {
                          
                            let visit:Visit = Visit(title: dico["title"] as! String,
                                            temperature: dico["temperature"] as! Int ,
                                            startTime: dico["startTime"] as! String,
                                            endTime: dico["endTime"] as! String, prescription:
                                            dico["prescription"] as! String,
                                            other: dico["other"] as? [[String : String]] ?? [])
                            let str = dico["startTime"] as! String
                            
                            let mySubstring = str.prefix(10)
                            print(mySubstring)
                            self.datesWithEvents.insert(String(mySubstring), at: 0)
                            self.listOfVisit.insert(visit, at: 0);
                            
                        }
                    
                   }
                   
              }
                self.tableView.reloadData()
           }
    }
    // MARK: TableView Configuration
    func configureTableView()
    {
         view.addSubview(tableView)
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(DateCell.self, forCellReuseIdentifier: "dateCellId")
         tableView.rowHeight = 100
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor).isActive = true
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         tableView.backgroundColor = .white
         tableView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    // MARK: - Calendar Configuration
    func configureCalendar()
    {
          calendar = FSCalendar(frame: .zero)
          calendar.scrollDirection = .horizontal
          calendar.scope = .month
          calendar.locale = Locale(identifier: "en")
          self.view.addSubview(calendar)
          calendar.translatesAutoresizingMaskIntoConstraints = false
          calendar.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
          calendar.heightAnchor.constraint(equalToConstant: 300).isActive = true
          calendar.topAnchor.constraint(equalTo: modeSegmentedControl.bottomAnchor ,constant: 10).isActive = true
          calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
          calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
          calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
          calendar.appearance.selectionColor = .orange
          calendar.appearance.todayColor = .systemBlue
          calendar.appearance.eventDefaultColor = .systemGreen
          calendar.appearance.eventSelectionColor = .systemGreen
          calendar.appearance.borderRadius = 0
          calendar.calendarHeaderView.backgroundColor = #colorLiteral(red: 0.2736301115, green: 0.7592733637, blue: 1, alpha: 1)
          calendar.appearance.titleTodayColor = .white
          calendar.appearance.borderDefaultColor = .black
          calendar.appearance.headerTitleColor = .white
          calendar.appearance.weekdayTextColor = .black
          calendar.dataSource = self
          calendar.delegate = self
          calendar.backgroundColor = .white
    }
    //MARK:- Configure Mode Button
    func configureModeSegmented()
    {
        self.view.addSubview(modeSegmentedControl)
        modeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        modeSegmentedControl.topAnchor.constraint(equalTo:view.topAnchor , constant: 90).isActive = true
        modeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        modeSegmentedControl.widthAnchor.constraint(equalToConstant: self.view.frame.size.width/3).isActive = true
         modeSegmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        modeSegmentedControl.addTarget(self,action: #selector(self.changeCalendarMode(sender:)), for: .touchUpInside)
    }
    // MARK
   func floatingButton()
   {
        btn = UIButton(type: .custom)
       btn.frame = CGRect(x: 325, y: 785, width: 70, height: 70)
       btn.setImage(UIImage(systemName: "plus")?.withTintColor(.white), for: .normal)
       btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
       btn.clipsToBounds = true
       btn.titleLabel?.font = .systemFont(ofSize: 40)
      
       view.addSubview(btn)
       btn.translatesAutoresizingMaskIntoConstraints = false
       btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
       btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
       btn.widthAnchor.constraint(equalToConstant: 70).isActive = true
       btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
       btn.layer.cornerRadius = 70 / 2
   }

}
extension HistoryViewController : UITableViewDelegate,UITableViewDataSource
{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
    return self.listOfVisit.count
   }
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
       let cell = tableView.dequeueReusableCell(withIdentifier: "dateCellId", for: indexPath)
       let listitem = listOfVisit[indexPath.row]
   
   
      guard let item = cell as? DateCell else
      {
          return cell
      }
        let date1 = listitem.startTime
        let date2 =  String(date1?.prefix(10) ?? "FF2")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        item.title.text = listitem.title
        item.value.text = "Prescription: \(listitem.prescription ?? "Nothing")"
         
        guard let date = formatter.date(from: date2) else
        {
            let label = UILabel()
             label.textColor = .green
             label.backgroundColor = .black
             label.textAlignment = .center
             label.text = "02"
             label.font = UIFont.boldSystemFont(ofSize: 26)
             let label1 = UILabel()
             label1.textColor = .green
             label1.backgroundColor = .black
             label1.textAlignment = .center
             label1.text = "August"
             label1.font = UIFont.boldSystemFont(ofSize: 15)
            
            if item.DateStack.arrangedSubviews.count != 0
            {
                for subview in item.DateStack.arrangedSubviews
                {
                   subview.removeFromSuperview()
                }
            }
             item.DateStack.addArrangedSubview(label1)
             item.DateStack.addArrangedSubview(label)
            return cell
        }
        
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        print( month, day)
         
         let label = UILabel()
         label.textColor = .green
         label.backgroundColor = .black
         label.textAlignment = .center
         label.text = day
         label.font = UIFont.boldSystemFont(ofSize: 26)
         let label1 = UILabel()
         label1.textColor = .green
         label1.backgroundColor = .black
         label1.textAlignment = .center
         label1.text = month
         label1.font = UIFont.boldSystemFont(ofSize: 15)
        
        if item.DateStack.arrangedSubviews.count != 0
        {
            for subview in item.DateStack.arrangedSubviews
            {
               subview.removeFromSuperview()
            }
        }
         item.DateStack.addArrangedSubview(label1)
         item.DateStack.addArrangedSubview(label)
         
    
       return item
   }

   
}
