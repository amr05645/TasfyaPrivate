//
//  CartCell.swift
//  Tasfya
//
//  Created by Amr on 08/09/2021.
//

import UIKit

class CartCell: UITableViewCell {
    
    var remove: (() -> ())?
    
    var priceChanged: ((Float) -> ())?
    
    var total: Float = 0.0
    
    var count: Int? {
        didSet {
            countLbl.text = "\(count ?? 0)"
        }
    }
    
    var max = 10
    
    var delegate: ButtonInsideTableViewCellDelegate?
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productSizeLbl: UILabel!
    @IBOutlet weak var productColorLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count = 1
        self.priceChanged = { [weak self] value in
            self?.total += value
            self?.totalPriceLbl.text = "\(self?.total ?? 0)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func minusBtnTapped(_ sender: Any) {
        guard count! > 1 else {return}
        count! -= 1
        priceChanged?(Float(-count! * 123))
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
        guard count! < max else {return}
        count! += 1
        priceChanged?(Float(count! * 123))
    }
    
    @IBAction func viewBtnTapped(_ sender: Any) {
        delegate?.didButtonPressed()
    }
    
    @IBAction func removeBtnTapped(_ sender: Any) {
        remove?()
    }
    
}

protocol ButtonInsideTableViewCellDelegate {
    func didButtonPressed()
}
