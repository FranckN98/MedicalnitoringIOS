//
//  InformationViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 29.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ListElemen
{
    
    
    // MARK: - Init
    var title: String
    var value: String
    var image: UIImage
    var isAddedValue: Bool
    
    init( title:String, value:String , image:UIImage, isAddedValue:Bool)
    {
        self.image = image
        self.title = title
        self.value = value
        self.isAddedValue = isAddedValue
    }
}

class InformationViewController: UIViewController
{
      // MARK: - Properties
        
        var tableView = UITableView()
        var patientakteItems = [ListElemen( title: "Blood Group", value: "", image: #imageLiteral(resourceName: "blood.jpg"),isAddedValue:false),
                                ListElemen( title: "Size", value: "", image: #imageLiteral(resourceName: "size"),isAddedValue:false),
                                ListElemen( title: "Smoker", value: "", image: #imageLiteral(resourceName: "smoke"),isAddedValue:false),
                                ListElemen( title: "Vaccine", value: "", image: #imageLiteral(resourceName: "vaccin"),isAddedValue:false),
                                ListElemen( title: "Diseases", value: "", image: #imageLiteral(resourceName: "disease.jpg"),isAddedValue:false),
                                ListElemen( title: "Allergies", value: "", image: #imageLiteral(resourceName: "allergy"),isAddedValue:false),
                                ListElemen( title: "Athletic", value: "", image: #imageLiteral(resourceName: "sport"),isAddedValue:false),
                                ListElemen( title: "Job", value: "", image: #imageLiteral(resourceName: "job"),isAddedValue:false),
                                ListElemen( title: "Ethnies", value: "", image: #imageLiteral(resourceName: "ethnie"),isAddedValue:false),
                                ListElemen( title: "Vegetarian", value: "", image: #imageLiteral(resourceName: "vegetariean"),isAddedValue:false),
                                ListElemen( title: "Gender", value: "", image: #imageLiteral(resourceName: "gender"),isAddedValue:false),
                                ListElemen( title: "Diabetes", value: "", image: #imageLiteral(resourceName: "diabetes"),isAddedValue:false)
        ]
        var currentPatient : patient!
        var patientKey : String!
        var otherItems : [[String:String]] = []
        lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .mainBlue
            
            view.addSubview(profileImageView)
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            profileImageView.anchor(top: view.topAnchor, paddingTop: 100,
                                    width: 120, height: 120)
            profileImageView.layer.cornerRadius = 120 / 2
            
            view.addSubview(ageLabel)
            ageLabel.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 paddingTop: 84, paddingLeft: 30, width: 100, height: 70)
            
            view.addSubview(ageValue)
            ageValue.anchor(top: ageLabel.bottomAnchor, left: view.leftAnchor,
                                 paddingTop: 3, paddingLeft: 30, width: 100, height: 30)
            
            view.addSubview(weightLabel)
            weightLabel.anchor(top: view.topAnchor, right: view.rightAnchor,
                                 paddingTop: 84, paddingRight: 30, width: 100, height: 70)
            view.addSubview(weightValue)
            weightValue.anchor(top: weightLabel.bottomAnchor, right: view.rightAnchor,
                                 paddingTop: 3, paddingRight: 30, width: 100, height: 30)
            
            view.addSubview(nameLabel)
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
            
            return view
        }()
        let profileImageView: UIImageView = {
           let iv = UIImageView()
           iv.image =  #imageLiteral(resourceName: "profilExample")
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.layer.borderWidth = 4
           iv.layer.borderColor = UIColor.white.cgColor
           return iv
       }()
       
       let ageLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = "Age"
           label.font = UIFont.boldSystemFont(ofSize: 20)
           label.textColor = .white
           return label
          
       }()
   
       let ageValue: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
           label.text = ""
          label.font = UIFont.boldSystemFont(ofSize: 18)
          label.textColor = .white
       return label
      
      }()
       
      let weightLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = "Weight"
           label.font = UIFont.boldSystemFont(ofSize: 20)
           label.textColor = .white
           return label
          
       }()
   
       let weightValue: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = ""
           label.font = UIFont.boldSystemFont(ofSize: 18)
           label.textColor = .white
           return label
          
       }()
       
       let nameLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = ""
           label.font = UIFont.boldSystemFont(ofSize: 26)
           label.textColor = .white
           return label
       }()

   
    
            
    //MARK: - Floating Button
        func floatingButton()
        {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 325, y: 785, width: 70, height: 70)
            btn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.8711801023, green: 0.9414077123, blue: 0.957699158, alpha: 1)
            btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            btn.clipsToBounds = true
            btn.titleLabel?.font = .systemFont(ofSize: 40)
            btn.addTarget(self,action: #selector(self.buttonTapped), for: .touchUpInside)
            view.addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -35).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
            btn.widthAnchor.constraint(equalToConstant: 70).isActive = true
            btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
            btn.layer.cornerRadius = 70 / 2
        }
    // MARK: - Click on floating button Event
        @IBAction func buttonTapped(sender:UIButton)
        {
            performSegue(withIdentifier: "backtoInfo", sender: nil)
                
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.identifier == "backtoInfo"
            {
                let editinfoVC = segue.destination as! EditInformationViewController
                editinfoVC.patientakteItems = self.patientakteItems
                editinfoVC.currentPatient = self.currentPatient
                editinfoVC.otherItems = self.otherItems
                editinfoVC.patientKey = self.patientKey
                editinfoVC.patientakteItems.insert(ListElemen( title: "Weight", value: weightValue.text!, image: #imageLiteral(resourceName: "how-to-lose-weight-hub-image-scales.jpg"),isAddedValue:false), at: 0)
                editinfoVC.patientakteItems.insert(ListElemen( title: "age", value: ageValue.text!, image: #imageLiteral(resourceName: "age"),isAddedValue:false), at: 0)
                editinfoVC.patientakteItems.insert(ListElemen( title: "Name", value: nameLabel.text!, image: #imageLiteral(resourceName: "name"),isAddedValue:false), at: 0)
            }
        }
    // MARK: Items initialisation
    
    
      
        // MARK: - Lifecycle
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            view.backgroundColor = .white
            view.addSubview(containerView)
            containerView.anchor(top: view.topAnchor, left: view.leftAnchor,right: view.rightAnchor, height: 270)
            configureTableView()
            floatingButton()
            retrievingInformationFromDatabase()
        
        }
       
        
        override var preferredStatusBarStyle: UIStatusBarStyle
        {
            return .lightContent
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
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       }
    
        func retrievingInformationFromDatabase()
        {
            let ref = Database.database().reference()
            ref.child("PatientInformation").observe(.childAdded) { (snapshot) in
                       
            if let dico = snapshot.value as? [String:AnyObject]
            {
                
                if let id = dico["id"] as? String
                {
                    if id == Auth.auth().currentUser?.uid
                    {
                       
                        print(dico)
                        self.patientKey = snapshot.key
                        self.currentPatient = patient(age: dico["age"] as! Int,
                                                      allergies: dico["allergies"] as! String,
                                                      athletic: dico["athletic"] as! String,
                                                      bloodgroup: dico["bloodgroup"] as! String,
                                                      diabetic: dico["diabetic"] as! String,
                                                      diseases: dico["diseases"] as! String,
                                                      ethnies: dico["ethnies"] as! String,
                                                      gender: dico["gender"] as! String,
                                                      job: dico["job"] as! String,
                                                      name: dico["name"] as! String,
                                                      other: dico["other"] as! [[String:String]],
                                                      size: dico["size"] as! String ,
                                                      smoker: dico["smoker"] as! String,
                                                      vaccine: dico["vaccine"] as! String,
                                                      vegetarian: dico["vegetarian"] as! String,
                                                      weight: dico["weight"] as? Double ?? 0)
                                
                                self.weightValue.text = String(self.currentPatient.weight!)
                                self.ageValue.text = String(self.currentPatient.age!)
                                self.nameLabel.text = self.currentPatient.name
                                self.patientakteItems = [ListElemen( title: "Blood Group", value: self.currentPatient.bloodgroup, image: #imageLiteral(resourceName: "blood.jpg"),isAddedValue:false),
                                ListElemen( title: "Size", value: self.currentPatient.size, image: #imageLiteral(resourceName: "size"),isAddedValue:false),
                                ListElemen( title: "Smoker", value: self.currentPatient.smoker, image: #imageLiteral(resourceName: "smoke"),isAddedValue:false),
                                ListElemen( title: "Vaccine", value: self.currentPatient.vaccine, image: #imageLiteral(resourceName: "vaccin"),isAddedValue:false),
                                ListElemen( title: "Diseases", value: self.currentPatient.diseases , image: #imageLiteral(resourceName: "disease.jpg"),isAddedValue:false),
                                ListElemen( title: "Allergies", value: self.currentPatient.allergies, image: #imageLiteral(resourceName: "allergy"),isAddedValue:false),
                                ListElemen( title: "Athletic", value: self.currentPatient.athletic, image: #imageLiteral(resourceName: "sport"),isAddedValue:false),
                                ListElemen( title: "Job", value: self.currentPatient.job, image: #imageLiteral(resourceName: "job"),isAddedValue:false),
                                ListElemen( title: "Ethnies", value: self.currentPatient.ethnies, image: #imageLiteral(resourceName: "ethnie"),isAddedValue:false),
                                ListElemen( title: "Vegetarian", value:self.currentPatient.vegetarian, image: #imageLiteral(resourceName: "vegetariean"),isAddedValue:false),
                                ListElemen( title: "Gender", value:self.currentPatient.gender, image: #imageLiteral(resourceName: "gender"),isAddedValue:false),
                                ListElemen( title: "Diabetes", value:self.currentPatient.diabetic, image: #imageLiteral(resourceName: "diabetes"),isAddedValue:false)
                                ]
                        
                                                        
                                //var patientact : [String: AnyObject] = dico
                                //patientact["other"] = self.currentPatient.other
                                //print(patientact)
                                let otherProperties = self.currentPatient.other
                                self.otherItems = otherProperties
                                Constants.addedValue = self.otherItems
                        
                        
                                Constants.patientbeforeEdit = ["age":self.currentPatient.age ?? 0,
                                "allergies": self.currentPatient.allergies ?? "" ,
                                "athletic": self.currentPatient.athletic ?? "",
                                "bloodgroup":self.currentPatient.bloodgroup ?? "",
                                "diabetic":self.currentPatient.diabetic ?? "",
                                "diseases":self.currentPatient.diseases ?? "",
                                "ethnies":self.currentPatient.ethnies ?? "",
                                "gender":self.currentPatient.gender ?? "",
                                "id":Auth.auth().currentUser?.uid ?? Constants.userid!,
                                "job":self.currentPatient.job ?? "",
                                "name":self.currentPatient.name ?? "",
                                "other":self.otherItems,
                                "size":self.currentPatient.size ?? 0,
                                "smoker":self.currentPatient.smoker ?? "",
                                "vaccine":self.currentPatient.vaccine ?? "",
                                "vegetarian":self.currentPatient.vegetarian ?? "",
                                "weight":self.currentPatient.weight ?? 0] as [String : Any]

                        
                                for element in otherProperties
                                {
                                    self.patientakteItems.append(ListElemen( title: element["label"]!, value: element["value"]!, image: #imageLiteral(resourceName: "Evolution-of-Patient-Centricity-in-Clinical-Trials-and-Data-Collection"), isAddedValue:true))
                                }
                                self.tableView.reloadData()
                                self.containerView.reloadInputViews()
                        
                        
                        
     
                            }
                        }
                       
                    }
                }
           }
    }

    extension InformationViewController : UITableViewDelegate,UITableViewDataSource
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
            
            item.title.text = listitem.title
            item.value.text = listitem.value
            item.imageIV.image = listitem.image
            
            return cell
        }
        
        
    }
    extension UIColor
    {
        static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor
        {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        }
        
        static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
    }

    extension UIView
    {
       
        func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                    paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
            }
            
            if let bottom = bottom {
                if let paddingBottom = paddingBottom {
                    bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
                }
            }
            
            if let right = right {
                if let paddingRight = paddingRight {
                    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
                }
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
}
