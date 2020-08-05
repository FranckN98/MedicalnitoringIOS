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

    var datesWithMultipleEvents = ["2020-10-08", "2020-10-16", "2020-10-20", "2020-10-28"]

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
        mode.addTarget(self, action: #selector(changeCalendarMode), for: .touchUpInside)
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
           }
    }
    // MARK: TableView Configuration
    func configureTableView()
    {
         view.addSubview(tableView)
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(ListElement.self, forCellReuseIdentifier: "cellId")
         tableView.rowHeight = 110
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor).isActive = true
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         tableView.backgroundColor = .white
         tableView.heightAnchor.constraint(equalToConstant: 400).isActive = true
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
          calendar.heightAnchor.constraint(equalToConstant: 380).isActive = true
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
       let btn = UIButton(type: .custom)
       btn.frame = CGRect(x: 325, y: 785, width: 70, height: 70)
       btn.setImage(UIImage(systemName: "plus")?.withTintColor(.white), for: .normal)
       btn.backgroundColor = #colorLiteral(red: 0.2736301115, green: 0.7592733637, blue: 1, alpha: 1)
       btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
       btn.clipsToBounds = true
       btn.titleLabel?.font = .systemFont(ofSize: 40)
       btn.addTarget(self,action: #selector(self.changeCalendarMode(sender:)), for: .touchUpInside)
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
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
       let listitem = listOfVisit[indexPath.row]
        //TODO : - Create a Cellule Type
     
       
       cell.textLabel?.text = listitem.title
       
       
       return cell
   }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Events"
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9535095531, green: 0.9535095531, blue: 0.9535095531, alpha: 1)
        let l = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width, height: 50))
        l.text = "Events"
        view.addSubview(l)
        return v
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
}
