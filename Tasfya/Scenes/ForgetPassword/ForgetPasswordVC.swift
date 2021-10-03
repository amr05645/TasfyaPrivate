//
//  ForgetPasswordVC.swift
//  Tasfya
//
//  Created by BMS on 27/09/2021.
//

import UIKit
import Alamofire

class ForgetPasswordVC: UIViewController {
    var baseUrl = "https://yousry.drayman.co/"
        
    @IBOutlet weak var emailIV: UIImageView!
    
    @IBOutlet weak var emailTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailIV.image = UIImage(named: "emailIcon")
    }
    
    func callPostApi(){
        let parameter = ["customers_email_address": emailTF.text]
        self.showProgress()
        AF.request(self.baseUrl + "processForgotPassword", method: .post, parameters: parameter, encoder: URLEncodedFormParameterEncoder.default,  headers:nil , interceptor: nil).response{
            response in
            guard let data = response.data else{return}
            do {
                let model = try JSONDecoder().decode(ForgetPassword.self, from: data)
                if model.success == "1" {
                    self.showAlert(with: model.message )

                    self.view.window?.rootViewController = setRootVC(to: LoginSceneVC())
                               }
                            else{
                                self.showAlert(with: model.message )
                               }
                          } catch {
                        print("error: \(error)")
                         }
                        }
                        }

    @IBAction func sendEmail(_ sender: Any) {
        callPostApi()
        
    }
    
    @IBAction func closeScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
