//
//  LWLDetailHeader.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/28/22.
//

import UIKit

class LWLDetailHeader: UICollectionReusableView {
    
    let lwlHeaderImage = UIImageView()
    let lwlHeaderLabel = UILabel()
    
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
        
        lwlHeaderImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lwlHeaderImage)
        
        NSLayoutConstraint.activate([
            lwlHeaderImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lwlHeaderImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            lwlHeaderImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            lwlHeaderImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
        
        lwlHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lwlHeaderLabel)

        NSLayoutConstraint.activate([
            lwlHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lwlHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            lwlHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 250),
            lwlHeaderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)

        ])
        
      }
    
    
}
