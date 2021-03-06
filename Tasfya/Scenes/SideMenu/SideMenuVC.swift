//
//  SideMenuVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit
import StoreKit

class SideMenuVC: UIViewController {
    
    var rootVC: UIViewController?
    private var navVC: UINavigationController!
    
    var selectedLanguage = LanguageHandler.getLanguage()
    
    private var sideMenuTitles = [Constants.sideMenuTitles.home, Constants.sideMenuTitles.categories, Constants.sideMenuTitles.shop, Constants.sideMenuTitles.myAccount, Constants.sideMenuTitles.myOrders, Constants.sideMenuTitles.myAddresses, Constants.sideMenuTitles.myFavorites, Constants.sideMenuTitles.contactUs, Constants.sideMenuTitles.about,
        Constants.sideMenuTitles.shareApp, Constants.sideMenuTitles.rateApp,
        Constants.sideMenuTitles.settings,Constants.sideMenuTitles.login]
    
    private let sidemMenuIcons: [String : UIImage] = [Constants.sideMenuTitles.home: #imageLiteral(resourceName: "homeIcon"), Constants.sideMenuTitles.categories : #imageLiteral(resourceName: "categoriesIcon"), Constants.sideMenuTitles.shop: #imageLiteral(resourceName: "shopIcon"), Constants.sideMenuTitles.myAccount: #imageLiteral(resourceName: "myaccountIcon"), Constants.sideMenuTitles.myOrders: #imageLiteral(resourceName: "myorderIcon"), Constants.sideMenuTitles.myAddresses: #imageLiteral(resourceName: "myAddressIcon"), Constants.sideMenuTitles.myFavorites: #imageLiteral(resourceName: "myfavoriteIcon"), Constants.sideMenuTitles.contactUs: #imageLiteral(resourceName: "contactUsIcon"), Constants.sideMenuTitles.about: #imageLiteral(resourceName: "aboutIcon"),
        Constants.sideMenuTitles.shareApp: #imageLiteral(resourceName: "shareIcon"), Constants.sideMenuTitles.rateApp: #imageLiteral(resourceName: "rateIcon"), Constants.sideMenuTitles.settings: #imageLiteral(resourceName: "settingsIcon"), Constants.sideMenuTitles.login: #imageLiteral(resourceName: "logoutIcon")]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dimeView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenueLeading: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var UserMailLabel: UILabel!
    var loginModel : Login?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRoot()
        setTableView()
        addTapGesture()
        configureSidemenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureSidemenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showUserData(user: loginModel)
    }
    
    
    func showUserData(user: Login?) {
    
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            userNameLabel.text = userdata.customersFirstname + userdata.customersLastname
            UserMailLabel.text = userdata.customersEmailAddress
        }
        
        
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        register()
    }
    
    private func register() {
        tableView.register(UINib(nibName: SideMenuCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SideMenuCell.reuseIdentifier)
    }
    
    private func addRoot() {
        navVC = UINavigationController(rootViewController: rootVC!)
        navVC.delegate = self
        navVC.navigationBar.backgroundColor = .clear
        navVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        navVC.navigationBar.shadowImage = UIImage()
        // Sets the translucent background color
        navVC.navigationBar.tintColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1) ]
        
        self.addChild(navVC)
        navVC.view.frame = containerView.bounds
        self.containerView.addSubview(navVC.view)
        navVC.didMove(toParent: self)
    }
    
    private func configureSidemenu() {
        sideMenuTitles.removeLast()
        if CurrentUser.logged {
            sideMenuTitles.append(Constants.sideMenuTitles.logout)
        } else {
            sideMenuTitles.append(Constants.sideMenuTitles.login)
        }
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        dimeView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        hideSideMenu()
    }
    
    private func addSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            LanguageHandler.getLanguage() == "en" ? showSideMenu() : hideSideMenu()
        case .left:
            LanguageHandler.getLanguage() == "en" ? hideSideMenu() : showSideMenu()
        default:
            return
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func shareApp(_ sender: UIButton) {
        let textToShare = "Check out my app"
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let myWebsite = URL(string: "https://apps.apple.com/eg/app/endo/id1568290410") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "logoTasfya")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
}

extension SideMenuVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideMenuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier, for: indexPath) as! SideMenuCell
        let title = sideMenuTitles[indexPath.row]
        cell.configure(title: title, icon: sidemMenuIcons[title])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.gestureRecognizers?.removeAll()
        let cell = tableView.cellForRow(at: indexPath) as? SideMenuCell
        cell?.highLight(status: true)
        hideSideMenu()
        switch sideMenuTitles[indexPath.row] {
        case Constants.sideMenuTitles.home:
            navVC.popToRootViewController(animated: true)
        case Constants.sideMenuTitles.categories:
            navVC.pushViewController(CategoriesVC(), animated: true)
        case Constants.sideMenuTitles.shop:
            navVC.pushViewController(ShopVC(), animated: true)
        case Constants.sideMenuTitles.myAccount:
            if CurrentUser.logged {
                navVC.pushViewController(MyAccountVC(), animated: true)
            } else {
                navVC.pushViewController(LoginSceneVC(), animated: true)
            }
        case Constants.sideMenuTitles.myOrders:
            if CurrentUser.logged {
                navVC.pushViewController(MyOrdersVC(), animated: true)
            } else {
                navVC.pushViewController(LoginSceneVC(), animated: true)
            }
        case Constants.sideMenuTitles.myAddresses:
     if CurrentUser.logged {
        if DefaultAddress.defaultAddress == true {
            navVC.pushViewController(AllAddressesVC(), animated: true)

        }
        else{
            navVC.pushViewController(MyAddressesVC(), animated: true)
             }
          }
     else {
                
           navVC.pushViewController(LoginSceneVC(), animated: true)
         }
        case Constants.sideMenuTitles.myFavorites:
           if CurrentUser.logged {
                navVC.pushViewController(MyFavoritesVC(), animated: true)
           } else {
              navVC.pushViewController(LoginSceneVC(), animated: true)
           }
        case Constants.sideMenuTitles.contactUs:
            navVC.pushViewController(ContactUsVC(), animated: true)
        case Constants.sideMenuTitles.about:
            navVC.pushViewController(AboutUsVC(), animated: true)
        case Constants.sideMenuTitles.shareApp:
            shareApp(UIButton())
        case Constants.sideMenuTitles.rateApp:
            rateApp()
        case Constants.sideMenuTitles.settings:
            navVC.pushViewController(SettingsCV(), animated: true)
        case Constants.sideMenuTitles.login:
            let vc = LoginSceneVC()
            LoginSceneVC.delegate = self
            navVC.pushViewController(vc, animated: true)
        case Constants.sideMenuTitles.logout:
            CurrentUser.logout()
            UserLoginCache.remove()
            hideUserData()
        default:
            return
        }
    }
    func hideUserData(){
        userNameLabel.text = "User Name"
        UserMailLabel.text = "User Mail"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(sideMenuTitles.count)
    }
}

extension SideMenuVC: SideMenuDelegate {
    func addGestures() {
        addSwipeGestures()
    }
    
    func showSideMenu() {
        tableView.reloadData()
        dimeView.isHidden = false
        sideMenueLeading.constant = sideMenuView.bounds.width
        
        UIView.animate(withDuration: 0.3,
                       delay: 0, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideSideMenu() {
        dimeView.isHidden = true
        sideMenueLeading.constant = 0
        
        UIView.animate(withDuration: 0.2,
                       delay: 0, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SideMenuVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

extension SideMenuVC: NavigationDelegate {
    func goto(_ viewController: UIViewController) {
        self.navVC.pushViewController(viewController, animated: true)
    }
}
