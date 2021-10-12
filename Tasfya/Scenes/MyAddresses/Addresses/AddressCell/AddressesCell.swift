//
//  AddressesCell.swift
//  Tasfya
//
//  Created by BMS on 03/10/2021.
//

import UIKit

class AddressesCell: UITableViewCell {

    var selectAddress : ((Bool) -> ())?
    let radioOn = #imageLiteral(resourceName: "radioOn")
    let radioOff = #imageLiteral(resourceName: "radioOff")
    var notSelected = true
    @IBOutlet weak var customerFullName: UILabel!
    @IBOutlet weak var customerAddresses: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
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
    
    @IBAction func selectAddressButton(_ sender: Any) {
        if notSelected {
           // radioButton.setImage(radioOn, for: .normal)
            selectAddress?(true)
            notSelected = false
        }
        else{
          //  radioButton.setImage(radioOff, for: .normal)
            selectAddress?(false)
            notSelected = true
        }
    }
}
