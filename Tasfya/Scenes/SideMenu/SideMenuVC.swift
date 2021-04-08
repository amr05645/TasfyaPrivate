//
//  SideMenuVC.swift
//  Tasfya
//
//  Created by Elsaadany on 07/04/2021.
//

import UIKit

class SideMenuVC: UIViewController {
    
    var rootVC: UIViewController?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dimeView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var sideMenuLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRoot()
        dimeView.isHidden = true
        sideMenuLeading.constant = -sideMenuView.bounds.width
        tableView.delegate = self
        tableView.dataSource = self
        register()
    }
    
    private func register() {
        tableView.register(UINib(nibName: SideMenuCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SideMenuCell.reuseIdentifier)
    }
    
    private func addRoot() {
        let navVC = UINavigationController(rootViewController: self.rootVC!)
        self.addChild(navVC)
        navVC.view.frame = containerView.bounds
        self.containerView.addSubview(navVC.view)
        navVC.didMove(toParent: self)
    }
}

extension SideMenuVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier, for: indexPath) as! SideMenuCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 8
    }
}
