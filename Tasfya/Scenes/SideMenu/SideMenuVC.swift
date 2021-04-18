//
//  SideMenuVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

class SideMenuVC: UIViewController {
    
    var rootVC: UIViewController?
    private var navVC: UINavigationController!
    
    let sideMenuTitles = [Constants.sideMenuTitles.home, Constants.sideMenuTitles.profile, Constants.sideMenuTitles.settings, Constants.sideMenuTitles.location, Constants.sideMenuTitles.language, Constants.sideMenuTitles.contactUs, Constants.sideMenuTitles.cart, Constants.sideMenuTitles.orders, Constants.sideMenuTitles.country]
    
    let sidemMenuIcons: [String : UIImage] = [Constants.sideMenuTitles.home: #imageLiteral(resourceName: "LoginImg"), Constants.sideMenuTitles.profile : #imageLiteral(resourceName: "smallSideMenuProfileImage"), Constants.sideMenuTitles.settings: #imageLiteral(resourceName: "smallSettingsImage"), Constants.sideMenuTitles.location: #imageLiteral(resourceName: "sideMenuLocation"), Constants.sideMenuTitles.language: #imageLiteral(resourceName: "sideMenulanguage"), Constants.sideMenuTitles.contactUs: #imageLiteral(resourceName: "sideMenuContact"), Constants.sideMenuTitles.cart: #imageLiteral(resourceName: "cart"), Constants.sideMenuTitles.orders: #imageLiteral(resourceName: "orders"), Constants.sideMenuTitles.country: #imageLiteral(resourceName: "country")]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dimeView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenueLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRoot()
        setTableView()
        addTapGesture()
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
        self.addChild(navVC)
        navVC.view.frame = containerView.bounds
        self.containerView.addSubview(navVC.view)
        navVC.didMove(toParent: self)
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
        case .left:
            showSideMenu()
        case .right:
            hideSideMenu()
        default:
            return
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
        case Constants.sideMenuTitles.profile:
            navVC.pushViewController(AccountSettingsVC(), animated: true)
        case Constants.sideMenuTitles.settings:
            navVC.pushViewController(SettingsVC(), animated: true)
        case Constants.sideMenuTitles.location:
            navVC.pushViewController(AddressesVC(), animated: true)
        case Constants.sideMenuTitles.contactUs:
            navVC.pushViewController(ContactUsVC(), animated: true)
        case Constants.sideMenuTitles.cart:
            navVC.pushViewController(CartVC(), animated: true)
        case Constants.sideMenuTitles.orders:
            navVC.pushViewController(OrdersVC(), animated: true)
        default:
            return
        }
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
        sideMenueLeading.constant = -sideMenuView.bounds.width
        
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
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
