//
//  File.swift
//  MedicalMonitoring
//
//  Created by ema on 29.07.20.
//  Copyright © 2020 ema. All rights reserved.
//
//


import UIKit

class ListElement : UITableViewCell {
    
    // MARK: - Init
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
        editvalue.font = UIFont.systemFont(ofSize: 13)
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


