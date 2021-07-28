//
//  NotLoggedVC.swift
//  Tasfya
//
//  Created by Amr on 4/5/21.
//

import UIKit

class NotLoggedVC: UIViewController {
    
    let vc = LoginVC()
	
	override func viewDidLoad() {
		super.viewDidLoad()
        vc.delegate = self
	}
	
	@IBAction func createAccountBtn(_ sender: Any) {
        self.present(vc, animated: true, completion: nil)
	}
	
	@IBAction func continuAsGuestBtn(_ sender: Any) {
        self.navigationController?.pushViewController(HomeScreenVC(), animated: true)
	}
	
	
}

extension NotLoggedVC: NavigationDelegate {
    func goto(_ viewController: UIViewController) {
        self.present(FillInfoVC(), animated: true, completion: nil)
    }
}
