//
//  BaseVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setSideMenuBtn()
    }
    
    func showLogo() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "tasfyaLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
        navigationItem.titleView = imageView
    }
    
    private func setSideMenuBtn() {
        let leftBtn = UIButton()
        leftBtn.setImage(#imageLiteral(resourceName: "sideMenuBtn"), for: .normal)
        leftBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftBtn.widthAnchor.constraint(equalToConstant: 18),
            leftBtn.heightAnchor.constraint(equalTo: leftBtn.widthAnchor)
        ])
        
        leftBtn.addTarget(self, action: #selector(sideMenuTapped), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    @objc private func sideMenuTapped() {
        
    }

}
