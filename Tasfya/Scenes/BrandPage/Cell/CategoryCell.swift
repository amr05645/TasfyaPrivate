//
//  CategoryCell.swift
//  Tasfya
//
//  Created by Amr on 4/15/21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
	
	override var isSelected: Bool {
		didSet {
			self.categoryLbl.textColor = isSelected ? .white : Constants.colors.selectionColor
		}
	}
	
	@IBOutlet weak var categoryLbl: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
