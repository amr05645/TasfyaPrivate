//
//  LoginVC.swift
//  Tasfya
//
//  Created by Amr on 4/6/21.
//

import UIKit
import PKHUD
import FirebaseAuth
import AuthenticationServices

class LoginVC: UIViewController {
    
    var delegate: NavigationDelegate?
	
	@IBOutlet weak var flagImg: UIImageView!
	@IBOutlet weak var countryCodeTF: PickerTF!
	@IBOutlet weak var phoneNumperTF: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        setCodeOptions()
	}
    
    func phoneLogin() {
        self.showProgress()
        PhoneAuthProvider.provider().verifyPhoneNumber("\(countryCodeTF.text ?? "")\(phoneNumperTF.text ?? "")" , uiDelegate: nil) { (verificationID, error) in
            self.hideProgress()
            if let error = error {
                HUD.flash(.label("\(error.localizedDescription)"), delay: 1)
                print(error.localizedDescription)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
        navigationController?.pushViewController(VerifyVC(), animated: true)
    }
    
    private func setCodeOptions() {
        let code = ["+20", "+965"]
        countryCodeTF.setInputPickerData(to: code)
    }
	
	@IBAction func done(_ sender: UITextField) {
		sender.resignFirstResponder()
	}
	
	@IBAction func countryCodeBtn(_ sender: Any) {
		countryCodeTF.becomeFirstResponder()
	}
	
	@IBAction func sendCodeBtn(_ sender: Any) {
        phoneLogin()
    }
    
    @IBAction func fastOrderTapped(_ sender: Any) {
        delegate?.goto(FillInfoVC())
        self.dismiss(animated: true, completion: nil)
    }
    
}
