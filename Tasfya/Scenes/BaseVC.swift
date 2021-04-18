//
//  BaseVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

class BaseVC: UIViewController {
    
    static weak var delegate: SideMenuDelegate?
    private var languageTF: PickerTF?

    override func viewDidLoad() {
        super.viewDidLoad()
        setSideMenuBtn()
        navigationItem.backButtonTitle = ""
        self.showLogo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BaseVC.delegate?.addGestures()
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
    
    func showLanguageBtn() {
        let languages = ["En","عربي"]
        self.languageTF = PickerTF()
        languageTF?.setInputPickerData(to: languages)
        setLanguageBtn()
    }
    
    private func setSideMenuBtn() {
        let menuBtn = UIButton()
        menuBtn.setImage(#imageLiteral(resourceName: "sideMenuBtn"), for: .normal)
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBtn.widthAnchor.constraint(equalToConstant: 18),
            menuBtn.heightAnchor.constraint(equalTo: menuBtn.widthAnchor)
        ])
        
        menuBtn.addTarget(self, action: #selector(sideMenuTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
    }
    
    private func setLanguageBtn() {
        languageTF?.text = "عربي"
        languageTF?.textAlignment = .right
        languageTF?.textColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
        languageTF?.font = languageTF!.font!.withSize(15)
        languageTF?.tintColor = .clear
        languageTF?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languageTF!.widthAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: languageTF!)
    }
    
    @objc private func sideMenuTapped() {
        BaseVC.delegate?.showSideMenu()
    }
}
