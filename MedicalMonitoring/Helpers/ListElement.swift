//
//  File.swift
//  MedicalMonitoring
//
//  Created by ema on 29.07.20.
//  Copyright © 2020 ema. All rights reserved.
//
//


import UIKit
import FirebaseDatabase
import FirebaseAuth

class ListElement : UITableViewCell
{
    
    
    // MARK: - Init
    var isAddedValue = false
    var safeArea: UILayoutGuide!
    let title = UILabel()
    var value = UILabel()
    let imageIV = UIImageView()
    var editvalue = UITextField()
    
    func activateEditModus()
    {
        value.alpha = 0
        editvalue.alpha = 1
    }
    func activateLabelModus()
    {
           value.alpha = 1
           editvalue.alpha = 0
    }
    func setupViews()
    {
        safeArea = layoutMarginsGuide
        setupImageView()
        setupTitleLabel()
        setupValue()
        setupEditValue()
        
    }
    func setupValue()
    {
        addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        value.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        value.topAnchor.constraint(equalTo: title.bottomAnchor, constant:8 ).isActive = true
        value.font = UIFont.systemFont(ofSize: 13)
    }
    func setupEditValue()
    {
        addSubview(editvalue)
        editvalue.translatesAutoresizingMaskIntoConstraints = false
        editvalue.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        editvalue.topAnchor.constraint(equalTo: title.bottomAnchor, constant:8 ).isActive = true
        editvalue.widthAnchor.constraint(equalToConstant: 210).isActive = true
        editvalue.font = UIFont.systemFont(ofSize: 13)
        editvalue.layer.shadowColor = UIColor.darkGray.cgColor
        editvalue.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        editvalue.layer.shadowOpacity = 0.6
        editvalue.layer.shadowRadius = 0.0
        editvalue.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        editvalue.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: editvalue.frame.height))
        editvalue.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEndOnExit)
        editvalue.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
    }
    @IBAction func textFieldDidEndEditing()
    {
        if(editvalue.text != "" && !self.isAddedValue)
        {
            let index = title.text!.lowercased().replacingOccurrences(of: " ", with: "")
            Constants.patientbeforeEdit[index] = editvalue.text!
            print("\(title.text!.lowercased()) \(editvalue.text!)")
            print(Constants.patientbeforeEdit)
        }
        else
        {
            var i = 0
            for index in Constants.addedValue
            {
                for(label,value) in index
                {
                  
                    if(label == title.text && editvalue.text?.trimmingCharacters(in: .whitespaces) != "")
                    {
                        Constants.addedValue[i]["\(value)"] = editvalue.text
                    }
                }
                i += 1
            }
            Constants.patientbeforeEdit["other"] = Constants.addedValue
            print(Constants.patientbeforeEdit)
        }
    }
    
    
    func setupTitleLabel()
    {
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 25).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        title.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    func setupImageView()
    {
        addSubview(imageIV)
        let profileImageDimension: CGFloat = 60
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        imageIV.layer.cornerRadius = profileImageDimension / 2
        imageIV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        activateLabelModus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


