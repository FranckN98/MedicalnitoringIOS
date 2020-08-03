//
//  EditInformationViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 30.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditInformationViewController: UIViewController
{
    
    var tableView = UITableView()
    var patientakteItems = [ListElemen]()
    var currentPatient : patient! = patient()
    var otherItems : [[String:String]] = []
    var patientKey : String!
    var ref: DatabaseReference! = Database.database().reference()
    let btn1 = UIButton(type: .custom)
    let btn2 = UIButton(type: .custom)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureTableView()
        floatingButton1()
        floatingButton2()
        
    }
    
    func floatingButton1()
    {
        
        btn1.frame = CGRect(x: 325, y: 785, width: 70, height: 70)
        btn1.setImage(UIImage(systemName: "tray.and.arrow.down"), for: .normal)
       // btn.setTitle("x", for: .normal)
        btn1.backgroundColor = #colorLiteral(red: 0.9098526554, green: 0.9034220025, blue: 0.8536889113, alpha: 1)
        btn1.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btn1.clipsToBounds = true
        btn1.layer.cornerRadius = 35
        btn1.titleLabel?.font = .systemFont(ofSize: 35)
        btn1.addTarget(self,action: #selector(self.button1Tapped), for: .touchUpInside)
        view.addSubview(btn1)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -35).isActive = true
        btn1.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn1.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btn1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        btn1.layer.cornerRadius = 70 / 2
    }
    func floatingButton2()
    {
        
         btn2.frame = CGRect(x: 325, y: 785, width: 70, height: 70)
         btn2.setImage(UIImage(systemName: "plus"), for: .normal)
        // btn.setTitle("x", for: .normal)
         btn2.backgroundColor = #colorLiteral(red: 0.9098526554, green: 0.9034220025, blue: 0.8536889113, alpha: 1)
         btn2.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
         btn2.clipsToBounds = true
         btn2.layer.cornerRadius = 35
         btn2.titleLabel?.font = .systemFont(ofSize: 35)
         btn2.addTarget(self,action: #selector(self.button2Tapped), for: .touchUpInside)
         view.addSubview(btn2)
         btn2.translatesAutoresizingMaskIntoConstraints = false
         btn2.bottomAnchor.constraint(equalTo: btn1.topAnchor, constant: -8).isActive = true
         btn2.heightAnchor.constraint(equalToConstant: 70).isActive = true
         btn2.widthAnchor.constraint(equalToConstant: 70).isActive = true
         btn2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
         btn2.layer.cornerRadius = 70 / 2
    }
    @IBAction func button1Tapped(sender:UIButton)
    {
        let alert = UIAlertController(title: "Warning", message: "Please be sure to check all the fields on the page before updating the Information", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
            // pop up verlassen
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { (action) in
            
            // TODO: Informationen werden geupdatet
        }))
        self.present(alert, animated: true)
    }
    @IBAction func button2Tapped(sender:UIButton)
    {
       let alert = UIAlertController(title: "Create new Information", message: "Enter the type and the content of the Information and press the button save", preferredStyle: .alert)
       alert.addTextField()
       alert.addTextField()
       
       
       alert.textFields![0].placeholder = "Type of the new information"
       alert.textFields![1].placeholder = "Content of the new information"
       
       alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
           
           // pop up verlassen
       }))
       alert.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { (action) in
           
        if(alert.textFields![0].text != "" && alert.textFields![1].text != "")
        {
            self.otherItems.append(["label":alert.textFields![0].text!, "value":alert.textFields![1].text!])
            self.currentPatient.other = self.otherItems
            self.patientakteItems.append(ListElemen( title: alert.textFields![0].text!, value: alert.textFields![1].text!, image: #imageLiteral(resourceName: "Evolution-of-Patient-Centricity-in-Clinical-Trials-and-Data-Collection")))
            self.functionUpdatePatientInfos(patient: self.currentPatient)
            self.tableView.reloadData()
        }
       }))
       self.present(alert, animated: true)
    }
    func functionUpdatePatientInfos(patient:patient)
    {
        let p = ["age":patient.age,"allergies":patient.allergies ,"athletic":patient.athletic, "bloodgroup":patient.bloodgroup,"diabetic":patient.diabetic, "diseases":patient.diseases,"ethnies":patient.ethnies,"gender":patient.gender, "id":patient.id, "job":patient.job, "name":patient.name, "other":patient.other, "size":patient.size, "smoker":patient.smoker, "vaccine":patient.vaccine, "vegetarian":patient.vegetarian, "weight":patient.weight] as [String : Any]
        
        ref.child("PatientInformation/\(patientKey!)").setValue(p as NSDictionary)
    }
   
    func configureTableView()
    {
         view.addSubview(tableView)
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(ListElement.self, forCellReuseIdentifier: "cellId")
         tableView.rowHeight = 110
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
 

}
extension EditInformationViewController : UITableViewDelegate,UITableViewDataSource
{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
           return patientakteItems.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
           let listitem = patientakteItems[indexPath.row]
           guard let item = cell as? ListElement else
           {
               return cell
           }
           item.activateEditModus()
           item.title.text = listitem.title
           item.editvalue.text = listitem.value
           item.imageIV.image = listitem.image
           
           return cell
       }
       
       
}
