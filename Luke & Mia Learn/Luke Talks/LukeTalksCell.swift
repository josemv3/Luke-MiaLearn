//
//  LukeTalksCell.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 1/2/23.
//

import UIKit

class LukeTalksCell: UICollectionViewCell {
    static let reuseidentifier = String(describing: LukeTalksCell.self)
    
    @IBOutlet weak var lukeTalksCellLabel: UILabel!
    
    @IBOutlet weak var lukeTalksCellImage: UIImageView!
}
