//
//  EndOrderVC.swift
//  Tasfya
//
//  Created by Amr on 13/09/2021.
//

import UIKit

class EndOrderVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func orderStatusTapped(_ sender: Any) {
        self.navigationController?.pushViewController(MyOrdersVC(), animated: true)
    }
    
    @IBAction func continuShoppingTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
