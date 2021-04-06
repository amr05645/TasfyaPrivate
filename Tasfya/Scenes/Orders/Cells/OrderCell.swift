//
//  OrderCell.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import UIKit

class OrderCell: UICollectionViewCell, ReusableView {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure() {
        idLabel.text = "\(Constants.titles.orderID) : \("")"
        dateLabel.text = "\(Constants.titles.orderDate) : \("")"
        statusLabel.text = "\(Constants.titles.orderStatus) : \("")"
    }

}
