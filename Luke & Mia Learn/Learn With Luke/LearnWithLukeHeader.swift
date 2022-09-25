//
//  LearnWithLukeHeader.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit

class LearnWithLukeHeader: UICollectionReusableView {
    var label = UILabel()
    
    override func layoutSubviews() {
      label.translatesAutoresizingMaskIntoConstraints = false
      addSubview(label)
      
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        
     
      ])
    }
}
