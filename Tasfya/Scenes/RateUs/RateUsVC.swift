//
//  RateUsVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit
import StoreKit

class RateUsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: false)
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    @IBAction func rateBtnTapped(_ sender: Any) {
        rateApp()
    }
    
    @IBAction func notNowBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
