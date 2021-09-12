//
//  CoponeCell.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import UIKit

class CoponeCell: UITableViewCell {
    
    @IBOutlet weak var coponeTF: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func applyBtnTapped(_ sender: Any) {
    }
    
    
}
