//
//  SettingsCV.swift
//  Tasfya
//
//  Created by Amr on 07/09/2021.
//

import UIKit
import StoreKit

class SettingsCV: BaseVC {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func editProfileBtnTapped(_ sender: Any) {
        self.navigationController?.pushViewController(MyAccountVC(), animated: true)
    }
    
    @IBAction func localNotifySwitchTapped(_ sender: Any) {
    }
    
    @IBAction func pushNotifySwitchTapped(_ sender: Any) {
    }
    
    @IBAction func selectLangBtnTapped(_ sender: Any) {
        self.showAlert(message: Constants.messages.langAlert) {
            switch self.selectedLanguage {
            case "ar":
                LanguageHandler.changeLanguage(to: "en")
            case "en":
                LanguageHandler.changeLanguage(to: "ar")
            default:
                return
            }
        }
    }
    
    @IBAction func officialWebBtnTapped(_ sender: Any) {
    }
    
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        let textToShare = "Check out my app"
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let myWebsite = URL(string: "https://apps.apple.com/eg/app/endo/id1568290410") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "logoTasfya")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func rateBtnTapped(_ sender: Any) {
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
    
    @IBAction func privacyBtnTapped(_ sender: Any) {
    }
    
    @IBAction func returnPolicyBtnTapped(_ sender: Any) {
    }
    
    @IBAction func termsOfServiceBtnTapped(_ sender: Any) {
    }
    
}
