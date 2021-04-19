//
//  BaseVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

class BaseVC: UIViewController {
    
    static weak var delegate: SideMenuDelegate?
    var selectedLanguage = LanguageHandler.getLanguage()
    let langBtn = UIButton()
//    private var languageTF: PickerTF?

    override func viewDidLoad() {
        super.viewDidLoad()
        setSideMenuBtn()
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
        langBtn.setTitleColor(#colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1), for: .normal)
        switch selectedLanguage {
        case .ar:
            langBtn.setTitle("En", for: .normal)
        case .en:
            langBtn.setTitle("عربي", for: .normal)
        default:
            return
        }
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
        
        langBtn.addTarget(self, action: #selector(langBtnTapped), for: .touchUpInside)
        langBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            langBtn.widthAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: langBtn)
    }
    
    @objc private func sideMenuTapped() {
        BaseVC.delegate?.showSideMenu()
    }
    
    @objc private func langBtnTapped() {
        
        self.showAlert(message: Constants.messages.langAlert) {
            switch self.selectedLanguage {
            case .ar:
                LanguageHandler.changeLanguage(to: .en)
            case .en:
                LanguageHandler.changeLanguage(to: .ar)
            default:
                return
            }
        }
    }
}
