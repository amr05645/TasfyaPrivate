//
//  LoginVC.swift
//  Tasfya
//
//  Created by Amr on 4/6/21.
//

import UIKit

class LoginVC: UIViewController {
    
    var delegate: NavigationDelegate?
	
	@IBOutlet weak var flagImg: UIImageView!
	@IBOutlet weak var countryCodeTF: PickerTF!
	@IBOutlet weak var phoneNumperTF: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func done(_ sender: UITextField) {
		sender.resignFirstResponder()
	}
	
	@IBAction func countryCodeBtn(_ sender: Any) {
		countryCodeTF.becomeFirstResponder()
	}
	
	@IBAction func sendCodeBtn(_ sender: Any) {
        let vc = VerifyVC()
        self.addChild(vc)
        vc.view.frame = self.view.bounds
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @IBAction func fastOrderTapped(_ sender: Any) {
        delegate?.goto(FillInfoVC())
        self.dismiss(animated: true, completion: nil)
    }
    
}
