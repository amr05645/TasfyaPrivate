//
//  SignUpSceneVC.swift
//  Tasfya
//
//  Created by Amr on 19/09/2021.
//

import UIKit
import Alamofire
import PKHUD

class SignUpSceneVC: BaseVC {
    
    var imagePicker: ImagePicker!
    var registerModel: Register?
    
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
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func sendUserData(){
        
        self.showProgress()
        let firstName = self.firstNameTF.text
        let lastName = self.lastNameTF.text
        let email = self.emailTF.text
        let password = self.passwordTF.text
        let phoneNumber = self.phoneNumberTF.text
        
        let parameter = ["customers_firstname": firstName ?? "", "customers_lastname": lastName ?? "", "customers_email_address": email ?? "", "customers_password": password ?? "", "customers_telephone": phoneNumber ?? ""]
        var image = UIImage()
        image = self.userImage.image ?? #imageLiteral(resourceName: "userImage")
        let imageData =  image.jpegData(compressionQuality: 0.50)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "customers_picture", fileName: "images.jpeg", mimeType: "images.jpeg")
            for (key, value) in parameter {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        },  to: "https://yousry.drayman.co/processRegistration").response
        { [weak self] response in
            guard let data = response.data else {return}
            do {
                let model =  try JSONDecoder().decode(Register.self, from: data)
                self?.hideProgress()
                DispatchQueue.main.async {
                    self?.registerModel = model
                //    UserProfileCache.save(self?.registerModel)
                //    self?.view.window?.rootViewController = setRootVC(to: HomeScreenVC())
                    self?.view.window?.rootViewController = setRootVC(to: LoginSceneVC())
                }
            } catch {
                self?.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    @IBAction func editImageTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func termsBtnTapped(_ sender: Any) {
    }
    
    @IBAction func privacyBtnTapped(_ sender: Any) {
    }
    
    @IBAction func refundBtnTapped(_ sender: Any) {
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        guard dataExist(in: [firstNameTF, lastNameTF, emailTF, passwordTF, phoneNumberTF]) else {
            self.showAlert(with: Constants.details.emptyTF)
            return
        }
        sendUserData()
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SignUpSceneVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        userImage.image = image
    }
}
