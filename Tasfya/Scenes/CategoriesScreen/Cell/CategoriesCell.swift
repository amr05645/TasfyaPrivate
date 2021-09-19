//
//  CategoriesCell.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(category: Datum?){
        categoryNameLbl.text = category?.name
        productCountLbl.text = "\(String(describing: category!.totalProducts!)) products"
        let url = "http://yousry.drayman.co/"
        let imageURL = category?.image ?? ""
        let finalUrl = url + imageURL
        categoryImg.showImage(url: finalUrl, cornerRadius: 0)
    }
    
}
