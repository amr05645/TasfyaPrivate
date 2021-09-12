//
//  OrdersCell.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class OrdersCell: UITableViewCell {
    
    var callBack: (() -> ())?
    
    @IBOutlet weak var orderIDLbl: UILabel!
    @IBOutlet weak var numOfProductLbl: UILabel!
    @IBOutlet weak var checkoutPriceLbl: UILabel!
    @IBOutlet weak var orderStatusLbl: UILabel!
    @IBOutlet weak var orderDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewBtnTapped(_ sender: Any) {
        callBack?()
    }
    
}
