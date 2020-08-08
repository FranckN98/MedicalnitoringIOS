//
//  DateCell.swift
//  MedicalMonitoring
//
//  Created by ema on 08.08.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell
{
   
        
        // MARK: - Init
      
        var safeArea: UILayoutGuide!
        let title = UILabel()
        var value = UILabel()
        var DateStack = UIStackView()
      
        
     
        func setupViews()
        {
            safeArea = layoutMarginsGuide
            setupImageView(month: "01", day: "01")
            setupTitleLabel()
            setupValue()
         
            
        }
        func setupValue()
        {
            addSubview(value)
            value.translatesAutoresizingMaskIntoConstraints = false
            value.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
            value.topAnchor.constraint(equalTo: title.bottomAnchor, constant:8 ).isActive = true
            value.font = UIFont.systemFont(ofSize: 13)
        }
        
      
        
        
        func setupTitleLabel()
        {
            addSubview(title)
            
            title.translatesAutoresizingMaskIntoConstraints = false
            title.leadingAnchor.constraint(equalTo: DateStack.trailingAnchor, constant: 25).isActive = true
            title.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
            title.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        func setupImageView(month:String, day:String)
        {
            
            
            addSubview(DateStack)
            DateStack.backgroundColor = .orange
            DateStack.axis = .vertical
            let profileImageDimension: CGFloat = 60
            DateStack.translatesAutoresizingMaskIntoConstraints = false
            DateStack.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
            DateStack.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
            DateStack.layer.cornerRadius = profileImageDimension / 2
            DateStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            DateStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        }
        
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
          
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    
    
}
