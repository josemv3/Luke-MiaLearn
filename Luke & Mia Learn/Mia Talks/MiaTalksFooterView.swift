//
//  MiaTalksFooterView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/21/22.
//

import UIKit

class MiaTalksFooterView: UICollectionReusableView {
    
    let leftFooterBtn = UIButton()
    let middleFooterBtn = UIButton()
    let rightFooterButton = UIButton()
    var soundType = "2"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func configure(text: String, image: UIImage) {
        // Update label text and image here...
    }
    
    func setupViews() {
        
        //Left Button
        leftFooterBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftFooterBtn)
        leftFooterBtn.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftFooterBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            leftFooterBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -245),
            leftFooterBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            leftFooterBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            
        ])
        leftFooterBtn.backgroundColor = UIColor(named: "miaTalksAltBG")
        leftFooterBtn.setTitle("alien", for: .normal) //wont go to view when this is not commented out?
        leftFooterBtn.contentHorizontalAlignment = .center
        leftFooterBtn.setTitleColor(UIColor(named: "miaTalksBlueGreen"), for: .normal)
        leftFooterBtn.setImage(UIImage(named: "alien"), for: .normal)
        
        //middle Button
        middleFooterBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(middleFooterBtn)
        middleFooterBtn.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            middleFooterBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150),
            middleFooterBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -155),
            middleFooterBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            middleFooterBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        middleFooterBtn.backgroundColor = UIColor(named: "miaTalksAltBG")
        middleFooterBtn.setTitle("human", for: .normal) //wont go to view when this is not commented out?
        middleFooterBtn.contentHorizontalAlignment = .center
        middleFooterBtn.setTitleColor(UIColor(named: "miaTalksBlueGreen"), for: .normal)
        middleFooterBtn.setImage(UIImage(named: "human"), for: .normal)
        
        //Right button
        rightFooterButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightFooterButton)
        rightFooterButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rightFooterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 240),
            rightFooterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -65),
            rightFooterButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            rightFooterButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        rightFooterButton.backgroundColor = UIColor(named: "miaTalksAltBG")
        rightFooterButton.setTitle("droid", for: .normal)
        rightFooterButton.contentHorizontalAlignment = .center
        rightFooterButton.setImage(UIImage(named: "droid"), for: .normal)
    }
    
    
    @objc private func action(sender: UIButton) {
        clearUI()
        
        //let vc = MiaTalksController()
        //vc.soundTypeSelected = sender.title(for: .selected)!
        
        sender.backgroundColor = .systemGray
        soundType = sender.title(for: .selected)!
        print("ST Cell", soundType)
        //print(sender.title(for: .selected)!)
    }
    
    func clearUI() {
        leftFooterBtn.backgroundColor = UIColor(named: "miaTalksAltBG")
        middleFooterBtn.backgroundColor = UIColor(named: "miaTalksAltBG")
        rightFooterButton.backgroundColor = UIColor(named: "miaTalksAltBG")
    }
}
