//
//  OrderProductsCell.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import UIKit

class ProductsCell: UITableViewCell {
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPricetLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
