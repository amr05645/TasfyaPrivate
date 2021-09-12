//
//  BillingCell.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import UIKit

class BillingCell: UITableViewCell {
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
