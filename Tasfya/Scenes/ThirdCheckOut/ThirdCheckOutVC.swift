//
//  ThirdCheckOutVC.swift
//  Tasfya
//
//  Created by Amr on 11/09/2021.
//

import UIKit

class ThirdCheckOutVC: BaseVC {
    
    enum ShippingOptions: String {
        case freeShipping
        case localPickup
        case flatRate
    }
    
    var shippingOptions: ShippingOptions?
    
    @IBOutlet weak var freeShippingImage: UIImageView!
    @IBOutlet weak var localPickupImage: UIImageView!
    @IBOutlet weak var flatRateImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShippingStatus(to: .freeShipping)
        self.navigationItem.setLeftBarButton(nil, animated: true)
    }
    
    func setShippingStatus(to option: ShippingOptions) {
        configureAgeViews(to: option)
        self.shippingOptions = option
    }
    
    func configureAgeViews(to option: ShippingOptions) {
        let radioOn = #imageLiteral(resourceName: "radioOn")
        let radioOff = #imageLiteral(resourceName: "radioOff")
        freeShippingImage.image = option == .freeShipping ? radioOn : radioOff
        localPickupImage.image = option == .localPickup ? radioOn : radioOff
        flatRateImage.image = option == .flatRate ? radioOn : radioOff
    }
    
    @IBAction func freeShippingTapped(_ sender: Any) {
        setShippingStatus(to: .freeShipping)
    }
    
    @IBAction func localPickupTapped(_ sender: Any) {
        setShippingStatus(to: .localPickup)
    }
    
    @IBAction func flatRateTapped(_ sender: Any) {
        setShippingStatus(to: .flatRate)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let vc = OrderDetailsVC()
        vc.showCoupon = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
