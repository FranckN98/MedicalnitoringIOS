//
//  EditInformationViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 30.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit

class EditInformationViewController: UIViewController {
    
    var tableView = UITableView()
    var patientakteItems = [ListElemen]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        floatingButton()
        
    }
    
    
 
    func floatingButton(){
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 325, y: 785, width: 70, height: 70)
        btn.setTitle("x", for: .normal)
        btn.backgroundColor = .mainBlue
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 35
        btn.titleLabel?.font = .systemFont(ofSize: 35)
        btn.addTarget(self,action: #selector(self.buttonTapped), for: .touchUpInside)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -35).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        btn.layer.cornerRadius = 65 / 2
    }
    @objc func buttonTapped(sender:UIButton)
    {
        let informationViewController = self.storyboard?.instantiateViewController(identifier:Constants.Storyboard.infoViewController) as? InformationViewController
       
        self.view.window?.rootViewController = informationViewController
        self.view.window?.makeKeyAndVisible()
        print("Button Tapped")
    }
    func configureTableView()
    {
        view.addSubview(tableView)
         setTableViewDelegate()
         tableView.register(ListElement.self, forCellReuseIdentifier: "cellId")
         tableView.rowHeight = 110
         tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setTableViewDelegate()
    {
              tableView.delegate = self
              tableView.dataSource = self
    }

}
extension EditInformationViewController : UITableViewDelegate,UITableViewDataSource
{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return patientakteItems.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
           let listitem = patientakteItems[indexPath.row]
           guard let item = cell as? ListElement else{
               return cell
           }
           item.activateEditModus()
           item.title.text = listitem.title
           item.editvalue.text = listitem.value
           item.imageIV.image = listitem.image
           
           return cell
       }
       
       
   }
