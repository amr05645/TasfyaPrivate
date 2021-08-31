//
//  SideMenuCell.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

class SideMenuCell: UITableViewCell, ReusableView {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(title: String, icon: UIImage?) {
        self.titleLabel.text = title
        self.icon.image = icon
        self.highLight(status: false)
    }
    
    func highLight(status: Bool) {
        self.icon.imageTint = status ? .white : #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
        self.titleLabel.textColor = status ? .white : #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
    }
}
