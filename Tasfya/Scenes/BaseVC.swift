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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightButtons()
        setSideMenuBtn()
        showLanguageBtn()
        showLogo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BaseVC.delegate?.addGestures()
    }
    
    func showLogo() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "logoImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
        navigationItem.titleView = imageView
    }
    
    func showLanguageBtn() {
        langBtn.setTitleColor(#colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1), for: .normal)
        switch selectedLanguage {
        case "ar":
            langBtn.setTitle("En", for: .normal)
        case "en":
            langBtn.setTitle("ع", for: .normal)
        default:
            return
        }
    }
    
    func setRightButtons() {
        self.navigationItem.rightBarButtonItems = [setSearchBtn(), setLanguageBtn(), setCartBtn()]
    }
    
    private func setSideMenuBtn()  {
        let menuBtn = UIButton()
        menuBtn.setImage(#imageLiteral(resourceName: "sideMenuBtn"), for: .normal)
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBtn.widthAnchor.constraint(equalToConstant: 18),
            menuBtn.heightAnchor.constraint(equalTo: menuBtn.widthAnchor)
        ])
        
        menuBtn.addTarget(self, action: #selector(sideMenuTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
    }
    
    func setCartBtn() -> UIBarButtonItem {
        let cartImage = UIImageView(image: #imageLiteral(resourceName: "shopIcon"))
        cartImage.imageTint = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
        let cartBtn = UIButton()
        cartBtn.addSubview(cartImage)
        
        cartImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartImage.widthAnchor.constraint(equalToConstant: 18),
            cartImage.heightAnchor.constraint(equalTo: cartImage.widthAnchor),
            cartImage.centerXAnchor.constraint(equalTo: cartBtn.centerXAnchor),
            cartImage.centerYAnchor.constraint(equalTo: cartBtn.centerYAnchor)
        ])
        
        cartBtn.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        
        return UIBarButtonItem(customView: cartBtn)
    }
    
    func setSearchBtn() -> UIBarButtonItem {
        let searchImage = UIImageView(image: #imageLiteral(resourceName: "searchIcon"))
        searchImage.imageTint = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
        let searchBtn = UIButton()
        searchBtn.addSubview(searchImage)
        
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchImage.widthAnchor.constraint(equalToConstant: 18),
            searchImage.heightAnchor.constraint(equalTo: searchImage.widthAnchor),
            searchImage.centerXAnchor.constraint(equalTo: searchBtn.centerXAnchor),
            searchImage.centerYAnchor.constraint(equalTo: searchBtn.centerYAnchor)
        ])
        
        searchBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        return UIBarButtonItem(customView: searchBtn)
    }
    
    @objc private func searchTapped() {
        self.navigationController?.pushViewController(SearchVC(), animated: true)
    }
    
    private func setLanguageBtn() -> UIBarButtonItem {
        
        langBtn.addTarget(self, action: #selector(langBtnTapped), for: .touchUpInside)
        langBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            langBtn.widthAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        return UIBarButtonItem(customView: langBtn)
    }
    
    @objc private func sideMenuTapped() {
        BaseVC.delegate?.showSideMenu()
    }
    
    @objc private func cartTapped() {
        self.navigationController?.pushViewController(CartVC(), animated: true)
    }
    
    @objc private func langBtnTapped() {
        
        self.showAlert(message: Constants.messages.langAlert) {
            switch self.selectedLanguage {
            case "ar":
                LanguageHandler.changeLanguage(to: "en")
            case "en":
                LanguageHandler.changeLanguage(to: "ar")
            default:
                return
            }
        }
    }
}
