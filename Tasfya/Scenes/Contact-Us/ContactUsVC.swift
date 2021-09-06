//
//  ContactUsVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class ContactUsVC: BaseVC {
    
    @IBOutlet weak var fulNameTF: PickerTF!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var textMessageTV: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
    }
    
}
