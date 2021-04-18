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
    sideMenu.rootVC = vc
    BaseVC.delegate = sideMenu
    return sideMenu
}
