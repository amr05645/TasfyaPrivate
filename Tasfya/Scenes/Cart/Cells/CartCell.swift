//
//  CartCell.swift
//  Tasfya
//
//  Created by Elsaadany on 13/04/2021.
//

import UIKit

class CartCell: UITableViewCell, ReusableView {
    
    var count: Int? {
        didSet {
            countLabel.text = "\(count ?? 0)"
            priceLable.text = "\(count! * 600) EGP"
        }
    }
    
    var max = 3
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count = 1
        countLabel.text = "\(count ?? 0)"
        colorView.backgroundColor = .red
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func plusTapped(_ sender: Any) {
        guard count! < max else {return}
            count! += 1
    }
    
    
    @IBAction func minusTapped(_ sender: Any) {
        guard count! > 1 else {return}
            count! -= 1
    }
}
