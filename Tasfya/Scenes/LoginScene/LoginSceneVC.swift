//
//  LoginSceneVC.swift
//  Tasfya
//
//  Created by Amr on 19/09/2021.
//

import UIKit

class LoginSceneVC: BaseVC {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: true)
        self.navigationItem.rightBarButtonItems?.removeAll()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.navigationController?.pushViewController(SignUpSceneVC(), animated: true)
    }
    
}
