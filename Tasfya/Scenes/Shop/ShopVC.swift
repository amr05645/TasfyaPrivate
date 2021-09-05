//
//  ShopVC.swift
//  Tasfya
//
//  Created by Amr on 05/09/2021.
//

import UIKit

class ShopVC: BaseVC {
    
    let vc = PagingControlVC()
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        containerView.constrainToEdges(vc.view)
    }
}
