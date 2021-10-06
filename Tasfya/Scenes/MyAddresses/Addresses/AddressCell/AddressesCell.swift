//
//  AddressesCell.swift
//  Tasfya
//
//  Created by BMS on 03/10/2021.
//

import UIKit

class AddressesCell: UITableViewCell {

    @IBOutlet weak var customerFullName: UILabel!
    
    @IBOutlet weak var customerAddresses: UILabel!
    
    
    func configure(data : AddressesData?){
        
 let fullName = (data?.firstname ?? "") + (data?.lastname ?? "")
        customerFullName.text = fullName
        
        let firstAddress  = (data?.street ?? "" )+(",")
  let lastAddress = (data?.city ?? "") + (",")+(data?.countryName ?? "")
  let fullAddress = firstAddress+lastAddress
    print(fullAddress)
  customerAddresses.text = fullAddress
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
