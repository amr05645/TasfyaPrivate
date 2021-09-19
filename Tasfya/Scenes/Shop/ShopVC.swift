//
//  ShopVC.swift
//  Tasfya
//
//  Created by Amr on 05/09/2021.
//

import UIKit

class ShopVC: BaseVC {
    
    let vc = PagingControlVC()
    var catId: String?
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.catId = catId
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        containerView.constrainToEdges(vc.view)
        //        self.navigationItem.setLeftBarButton(nil, animated: false)
    }
}
