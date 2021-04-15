//
//  LoginVC.swift
//  Tasfya
//
//  Created by Amr on 4/6/21.
//

import UIKit

class LoginVC: UIViewController {
	
	@IBOutlet weak var flagImg: UIImageView!
	@IBOutlet weak var countryCodeTF: PickerTF!
	@IBOutlet weak var phoneNumperTF: UITextField!
	
	@IBAction func done(_ sender: UITextField) {
		sender.resignFirstResponder()
	}
	
	@IBAction func countryCodeBtn(_ sender: Any) {
		countryCodeTF.becomeFirstResponder()
	}
	
	@IBAction func sendCodeBtn(_ sender: Any) {
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
