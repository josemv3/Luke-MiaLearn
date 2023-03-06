//
//  MiaTalksHeaderView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/26/22.
//

import UIKit

class MiaTalksHeaderView: UICollectionReusableView {
    
    let miaTalksHeaderLabel = UILabel()
    
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
        miaTalksHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(miaTalksHeaderLabel)
        
        NSLayoutConstraint.activate([
            miaTalksHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            miaTalksHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            miaTalksHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            miaTalksHeaderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
      }
}
