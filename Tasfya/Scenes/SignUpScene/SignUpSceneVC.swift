//
//  SignUpSceneVC.swift
//  Tasfya
//
//  Created by Amr on 19/09/2021.
//

import UIKit

class SignUpSceneVC: BaseVC {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: true)
        self.navigationItem.rightBarButtonItems?.removeAll()
    }
    
    @IBAction func editImageTapped(_ sender: Any) {
    }
    
    @IBAction func termsBtnTapped(_ sender: Any) {
    }
    
    @IBAction func privacyBtnTapped(_ sender: Any) {
    }
    
    @IBAction func refundBtnTapped(_ sender: Any) {
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
    }
    
}
