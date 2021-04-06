//
//  AddressCell.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import UIKit

class AddressCell: UICollectionViewCell, ReusableView {
    
    var remove: ((Int) -> ())?
    var index: Int?
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? Constants.colors.selectionColor : Constants.colors.defaultColor
        }
    }

    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var countryCityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        guard let index = index else { return }
        remove?(index)
    }
}
