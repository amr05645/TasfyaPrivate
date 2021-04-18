//
//  BrandCell.swift
//  Tasfya
//
//  Created by Amr on 4/13/21.
//

import UIKit

class BrandCell: UICollectionViewCell {

	@IBOutlet weak var brandPhotoImg: UIImageView!
	@IBOutlet weak var newPriceLbl: UILabel!
	@IBOutlet weak var oldPriceLbl: UILabel!
	@IBOutlet weak var brandLogoImg: UIImageView!
	@IBOutlet weak var brandNameLbl: UILabel!
	@IBOutlet weak var addproductBtn: UIButton!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	@IBAction func AddProduct(_ sender: Any) {
	}
	

}
