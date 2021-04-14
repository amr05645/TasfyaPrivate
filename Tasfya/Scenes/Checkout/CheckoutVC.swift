//
//  CheckoutVC.swift
//  Tasfya
//
//  Created by Elsaadany on 14/04/2021.
//

import UIKit

class CheckoutVC: UIViewController {
    
    enum PaymentOptions {
        case cash
        case online
    }
    
    @IBOutlet weak var cashImage: UIImageView!
    @IBOutlet weak var onlineImage: UIImageView!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setPayment(to: .cash)
    }

    func setPayment(to option: PaymentOptions) {
        configurePaymentViews(to: option)
    }

    func configurePaymentViews(to option: PaymentOptions) {
        let radioOn = Constants.images.whiteRadioOn
        let radioOff = Constants.images.radioOff
        let colorOn = UIColor.white
        let colorOff = Constants.colors.placeHolder

        cashImage.image = option == .cash ? radioOn : radioOff
        cashLabel.textColor = option == .cash ? colorOn : colorOff
        onlineImage.image = option == .online ? radioOn : radioOff
        onlineLabel.textColor = option == .online ? colorOn : colorOff
    }
    
    
    @IBAction func cashTapped(_ sender: Any) {
        setPayment(to: .cash)
    }

    @IBAction func onlineTapped(_ sender: Any) {
        setPayment(to: .online)
    }
    
    @IBAction func checkoutTapped(_ sender: Any) {
    }
}
