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
//        self.navigationItem.setLeftBarButton(nil, animated: false)
    }
    
    @IBAction func officialBtnTapped(_ sender: Any) {
        print("official")
    }
    
    @IBAction func privacyBtnTapped(_ sender: Any) {
        let vc = AllPagesVC()
        vc.pageNo = 1
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func refundBtnTapped(_ sender: Any) {
        let vc = AllPagesVC()
        vc.pageNo = 3
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func termsBtnTapped(_ sender: Any) {
        let vc = AllPagesVC()
        vc.pageNo = 2
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
