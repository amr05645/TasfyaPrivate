//
//  SetRootVC.swift
//  Tasfya
//
//  Created by Elsaadany on 11/04/2021.
//

import UIKit

func setRootVC(to viewController: UIViewController) -> UIViewController {
    let vc = viewController
    let sideMenu = SideMenuVC()
    if let vc = vc as? BaseVC {
        vc.delegate = sideMenu
    }
    sideMenu.rootVC = vc
    return sideMenu
}
