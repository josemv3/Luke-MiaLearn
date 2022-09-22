//
//  MiaTalksFooterView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/21/22.
//

import UIKit

class MiaTalksFooterView: UICollectionReusableView {
        
    override func layoutSubviews() {
//        let labelButtonOne = UIButton()
//        
//        labelButtonOne.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(labelButtonOne)
//        
//        NSLayoutConstraint.activate([
//            labelButtonOne.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75),
//            labelButtonOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200),
//            labelButtonOne.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            labelButtonOne.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
//        ])
//        labelButtonOne.backgroundColor = .red
//        labelButtonOne.setTitle("Left", for: .normal)
//        //labelButtonOne.contentHorizontalAlignment = .center
//        labelButtonOne.setTitleColor(.black, for: .normal)
        
        let labelFooter = UILabel()
        labelFooter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelFooter)
        
        NSLayoutConstraint.activate([
            labelFooter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150),
            labelFooter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
            labelFooter.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            labelFooter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
        ])
        labelFooter.backgroundColor = UIColor(named: "miaTalksBlueGreen")
        labelFooter.textAlignment = .center
        labelFooter.text = "Hello"
    }
}
