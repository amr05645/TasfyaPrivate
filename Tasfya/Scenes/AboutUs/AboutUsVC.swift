//
//  AboutUsVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class AboutUsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: false)
    }
    
    @IBAction func officialBtnTapped(_ sender: Any) {
        print("official")
    }
    
    @IBAction func privacyBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func refundBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func termsBtnTapped(_ sender: Any) {
        
    }
    
    
}
