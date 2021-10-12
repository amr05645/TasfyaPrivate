//
//  LoginSceneVC.swift
//  Tasfya
//
//  Created by Amr on 19/09/2021.
//

import UIKit
import Alamofire
class LoginSceneVC: BaseVC {
    
    var baseUrl = "https://yousry.drayman.co/"
    var loginModel :Login?
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: true)
        self.navigationItem.rightBarButtonItems?.removeAll()
        
    }
    
    func callPostApi(){
        self.showProgress()
        let parameter = ["customers_email_address": emailTF.text, "customers_password": passwordTF.text]
        AF.request(self.baseUrl + "processLogin", method: .post, parameters: parameter, encoder: URLEncodedFormParameterEncoder.default,  headers:nil , interceptor: nil).response{
            response in
            guard let data = response.data else{return}
            do {
                let model = try JSONDecoder().decode(Login.self, from: data)
                if model.success == "1" {
                    self.view.window?.rootViewController = setRootVC(to: HomeScreenVC())
                    CurrentUser.login()
                    UserLoginCache.save(model)
                               }
                            else{
                                self.showAlert(with: model.message )
                               }
                
            } catch {
                   print("error: \(error)")
               }
        }
    } 
    @IBAction func loginTapped(_ sender: Any) {
    callPostApi()
        
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
        self.navigationController?.present(ForgetPasswordVC(), animated: true, completion: nil)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.navigationController?.pushViewController(SignUpSceneVC(), animated: true)
    }
    
}
