//
//  MiaTalksFooterView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/21/22.
//

import UIKit

class MiaTalksFooterView: UICollectionReusableView {
        
    override func layoutSubviews() {
        
        //Left Button
        let leftFooterBtn = UIButton()
        leftFooterBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftFooterBtn)
        leftFooterBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            leftFooterBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            leftFooterBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -245),
            leftFooterBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            leftFooterBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            
        ])
        leftFooterBtn.backgroundColor = UIColor(named: "miaTalksAltBG")
        //labelButtonOne.setTitle("Left", for: .normal) wont go to view when this is not commented out?
        leftFooterBtn.contentHorizontalAlignment = .center
        leftFooterBtn.setTitleColor(UIColor(named: "miaTalksBlueGreen"), for: .normal)
        //labelButtonOne.setImage(UIImage(named: "apple"), for: .normal)
        
        //Left Image
        let leftImage = UIImageView()
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftImage)
        
        NSLayoutConstraint.activate([
            leftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            leftImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -245),
            leftImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            leftImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        leftImage.backgroundColor = UIColor(named: "miaTalksAltBG")
        leftImage.image = UIImage(named: "humanFace")
        
        //Middle Label
        let labelFooter = UILabel()
        labelFooter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelFooter)
        
        NSLayoutConstraint.activate([
            labelFooter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150),
            labelFooter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -155),
            labelFooter.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            labelFooter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        labelFooter.backgroundColor = UIColor(named: "miaTalksAltBG")
        labelFooter.textAlignment = .center
        labelFooter.text = "Hello"
        
        //Middle Image
        let middleImage = UIImageView()
        middleImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(middleImage)
        
        NSLayoutConstraint.activate([
            middleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150),
            middleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -155),
            middleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            middleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        middleImage.backgroundColor = UIColor(named: "miaTalksAltBG")
        middleImage.image = UIImage(named: "alienFace")
        
        //right ImageView
        let rightImage = UIImageView()
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightImage)
        
        NSLayoutConstraint.activate([
            rightImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 240),
            rightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -65),
            rightImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            rightImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        rightImage.backgroundColor = UIColor(named: "miaTalksAltBG")
        rightImage.image = UIImage(named: "robotFace")
        
    }
    @objc func didTapButton() {
        print("yes")
    }
}
