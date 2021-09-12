//
//  SubtotalCell.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import UIKit

class SubtotalCell: UITableViewCell {
    
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
