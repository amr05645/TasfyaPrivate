//
//  MyAccountVC.swift
//  Tasfya
//
//  Created by Amr on 05/09/2021.
//

import UIKit
import PKHUD

class MyAccountVC: BaseVC {
    
    var registerModel: Register?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    private var navVC: UINavigationController!
    
    var imagePicker: ImagePicker!
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        showUserData(user: registerModel)
        setDatePicker()
    }
    
    func showUserData(user: Register?) {
        guard let data = UserProfileCache.get()?.data else { return }
        for userdata in data {
            let url = "http://yousry.drayman.co/"
            let imageURL = userdata.customersPicture ?? ""
            let finalUrl = url + imageURL
            self.userImage.showImage(url: finalUrl, cornerRadius: 0)
            self.userNameTF.text = userdata.customersFirstname
            self.lastNameTF.text = userdata.customersLastname
            self.phoneNumberTF.text = userdata.customersTelephone
            self.currentPasswordTF.text = userdata.customersPassword
        }
    }
    
    func setDatePicker() {
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        dateTF.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        dateTF.inputAccessoryView = toolBar
    }
    
    @objc func datePickerDone() {
        dateTF.resignFirstResponder()
    }
    
    @objc func dateChanged() {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        dateTF.text = "\(selectedDate)"
    }
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        HUD.flash(.success)
//        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension MyAccountVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        userImage.image = image
    }
}
