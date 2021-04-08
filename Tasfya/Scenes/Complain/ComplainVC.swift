//
//  ComplainVC.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import UIKit

class ComplainVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var complainLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTV.delegate = self
    }

    @IBAction func sendTapped(_ sender: Any) {
    }
    
}

extension ComplainVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        complainLabel.isHidden = !(textView.text.isEmpty)
    }
}
