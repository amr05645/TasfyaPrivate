//
//  CartVC.swift
//  
//
//  Created by Elsaadany on 13/04/2021.
//

import UIKit

class CartVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: CartCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CartCell.reuseIdentifier)
    }
    
    @IBAction func buyTapped(_ sender: Any) {
        if CurrentUser.logged {
            let vc = AddressesVC()
            vc.checkout = true
            self.navigationController?.pushViewController(vc, animated: true)
            #warning("handle navigation for logged in user but with no data provided")
        } else {
            let vc = LoginVC()
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseIdentifier, for: indexPath) as! CartCell
        return cell
    }
}

extension CartVC: NavigationDelegate {
    func goto(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
