//
//  CartVC.swift
//  Tasfya
//
//  Created by Amr on 08/09/2021.
//

import UIKit

class CartVC: BaseVC {
    
    var orders = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    @IBOutlet weak var CartTableView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartTableView.delegate = self
        CartTableView.dataSource = self
        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()
    }
    
    func register() {
        CartTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        CartTableView.register(UINib(nibName: "ExploreCell", bundle: nil), forCellReuseIdentifier: "ExploreCell")
    }
    
    @IBAction func checkoutBtnTapped(_ sender: Any) {
        self.navigationController?.pushViewController(FirstCheckOutVC(), animated: true)
    }
    
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return orders.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
            cell.delegate = self
            cell.remove = { [weak self] in
                self?.CartTableView.performBatchUpdates({
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    self?.orders.remove(at: indexPath.row)
                }) { (finished) in
                    self?.CartTableView.reloadData()
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 240
        case 1:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CartTableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case [0,0]:
            return
        case [1,0]:
            self.navigationController?.pushViewController(ShopVC(), animated: true)
            print("selected")
        default:
            return
        }
    }
    
}

extension CartVC: ButtonInsideTableViewCellDelegate {
    
    func didButtonPressed() {
        self.navigationController?.pushViewController(ProductDetailsVC(), animated: true)
    }
    
}
