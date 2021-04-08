//
//  ContactUsVC.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import UIKit

class ContactUsVC: UIViewController {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func phoneTapped(_ sender: Any) {
    }
    
    @IBAction func mailTapped(_ sender: Any) {
    }
    
    @IBAction func complainTapped(_ sender: Any) {
        self.navigationController?.pushViewController(ComplainVC(), animated: true)
    }
}
