//
//  MainCVCell.swift
//  Tasfya
//
//  Created by Amr on 31/08/2021.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    let likedImg = #imageLiteral(resourceName: "likedPhoto")
    let unlikeImg = #imageLiteral(resourceName: "unlikePhoto")
    var notSelected = true
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var brandNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        if notSelected {
            likeBtn.setImage(likedImg, for: .normal)
        } else {
            likeBtn.setImage(unlikeImg, for: .normal)
        }
        notSelected = !notSelected
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
    }
    
}
