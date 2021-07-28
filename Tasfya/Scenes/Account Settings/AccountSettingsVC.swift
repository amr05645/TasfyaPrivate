//
//  AccountSettingsVC.swift
//  Tasfya
//
//  Created by Amr on 4/4/21.
//

import UIKit

class AccountSettingsVC: UIViewController {
	
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
	@IBOutlet weak var phonenumberTF: UITextField!
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var genderTF: UITextField!
	@IBOutlet weak var countryTF: UITextField!
    
    var imagePicker: ImagePicker!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
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
        usernameTF.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        phonenumberTF.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        emailTF.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        genderTF.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        countryTF.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
	}
    
    @IBAction func saveButtonTabbed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonTabbed(_ sender: Any) {
        usernameTF.isUserInteractionEnabled = false
        phonenumberTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
        genderTF.isUserInteractionEnabled = false
        countryTF.isUserInteractionEnabled = false
        usernameTF.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        phonenumberTF.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        emailTF.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        genderTF.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        countryTF.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func uploadImagePressed(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}

extension AccountSettingsVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        profileImg.image = image
    }
}
