//
//  MiaTalksCell.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit

class MiaTalksCell: UICollectionViewCell {
    
    @IBOutlet var miaTalkCellLabel: UILabel!
    @IBOutlet weak var miaTalksButton: UIButton!
    var buttonaNameTapped = ""
    
    
//    @IBAction func miaTalksButtonTap(_ sender: UIButton) {
//        sender.alpha = 0.5
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//        sender.alpha = 1.0
//        print(self.miaTalkCellLabel.text ?? "error") //letter
//        }
//        print("button title", miaTalksButton.image(for: .normal)!)
        //buttonaNameTapped = sender.titleLabel?.text ?? "banana"
        //print(buttonaNameTapped)
    //}
}
//remove the button pushButton from the cell. Go back to didSelectItemAt.
