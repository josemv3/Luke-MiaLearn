//
//  MiaTalksCell.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit

class MiaTalksCell: UICollectionViewCell {
    @IBOutlet var miaTalkCellLabel: UILabel!
    @IBOutlet weak var miaTalksView: UIImageView!

    static let reuseidentifier = String(describing: MiaTalksCell.self)
}