//
//  CreateAccount.swift
//  Tasfya
//
//  Created by Elsaadany on 04/04/2021.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var maleRadioImage: UIImageView!
    @IBOutlet weak var femaleRadioImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func maleTapped(_ sender: Any) {
        maleRadioImage.image = Constants.images.radioOn
        femaleRadioImage.image = Constants.images.radioOff
    }
    
    @IBAction func femaleTapped(_ sender: Any) {
        maleRadioImage.image = Constants.images.radioOff
        femaleRadioImage.image = Constants.images.radioOn
    }
}
