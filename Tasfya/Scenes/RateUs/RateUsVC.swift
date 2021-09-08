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
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "https://apps.apple.com/eg/app/endo/id1568290410") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func rateBtnTapped(_ sender: Any) {
        rateApp()
    }
    
    @IBAction func notNowBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
