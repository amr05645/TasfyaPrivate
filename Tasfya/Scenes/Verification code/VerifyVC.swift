//
//  VerifyVC.swift
//  Tasfya
//
//  Created by Amr on 4/6/21.
//

import UIKit
import KWVerificationCodeView

class VerifyVC: UIViewController{
	
	var cowntdownTimer: Timer!
	var totalTime = 5
	var btnTitle = "Send again in 50 sec "
	var attributedTitle = NSMutableAttributedString()
	
	
	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var verifingTF: KWVerificationCodeView!
	@IBOutlet weak var sendAgainBtn: UIButton!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		verifingTF.textColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
		verifingTF.underlineColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
		startTimer()
		setAttributedBtn()
	}
    
    @IBAction func sendCodeBtn(_ sender: Any) {
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        CurrentUser.login()
        self.navigationController?.pushViewController(HomeScreenVC(), animated: true)
        self.dismiss(animated: true, completion: nil)
    }
	
	
	func startTimer() {
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {cowntdownTimer in
			if self.totalTime != 0 {
				self.sendAgainBtn.isEnabled = false
				self.totalTime -= 1
				self.btnTitle = "Send again in \(self.totalTime) sec "
				self.setAttributedBtn()
			} else {
				cowntdownTimer.invalidate()
				self.sendAgainBtn.isEnabled = true
			}
		})
	}
	
	
	func setAttributedBtn() {
		btnTitle = "Send again in \(totalTime) sec "
		attributedTitle = NSMutableAttributedString(string: btnTitle, attributes: [NSAttributedString.Key.font:UIFont(name: "System Font Regular",size: 20)!])
		
		attributedTitle.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1), range: NSRange(location: 0, length: 13))
		
		attributedTitle.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 14, length: 6))
		
		attributedTitle.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 14, length: 6))
		
		countLabel.attributedText = attributedTitle
	}
	
}


