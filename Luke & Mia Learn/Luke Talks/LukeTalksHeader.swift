//
//  LukeTalksHeader.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 1/3/23.
//

import UIKit

class LukeTalksHeader: UICollectionReusableView {
    let LukeTalksHeaderImage = UIImageView()
    let LukeTalksHeaderLabel = UILabel()
    
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
        
        LukeTalksHeaderImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(LukeTalksHeaderImage)
        
        NSLayoutConstraint.activate([
            LukeTalksHeaderImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            LukeTalksHeaderImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            LukeTalksHeaderImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            LukeTalksHeaderImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
        
        LukeTalksHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(LukeTalksHeaderLabel)

        NSLayoutConstraint.activate([
            LukeTalksHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            LukeTalksHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            LukeTalksHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 250),
            LukeTalksHeaderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
      }
}
