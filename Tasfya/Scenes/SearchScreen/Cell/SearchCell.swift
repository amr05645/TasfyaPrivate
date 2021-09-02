//
//  SearchCell.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var categoryIconImage: UIImageView!
    @IBOutlet weak var categoryNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
