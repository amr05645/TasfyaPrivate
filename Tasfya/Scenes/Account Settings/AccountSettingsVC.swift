//
//  AccountSettingsVC.swift
//  Tasfya
//
//  Created by Amr on 4/4/21.
//

import UIKit

class AccountSettingsVC: UIViewController {
	
	@IBOutlet weak var usernameTF: UITextField!
	@IBOutlet weak var phonenumberTF: UITextField!
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var genderTF: UITextField!
	@IBOutlet weak var countryTF: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func addAdressesBtn(_ sender: Any) {
	}
	
	@IBAction func deleteAccountBtn(_ sender: Any) {
	}
	
	@IBAction func editinformation(_ sender: Any) {
		usernameTF.isUserInteractionEnabled = true
		phonenumberTF.isUserInteractionEnabled = true
		emailTF.isUserInteractionEnabled = true
		genderTF.isUserInteractionEnabled = true
		countryTF.isUserInteractionEnabled = true
	}
	
}
