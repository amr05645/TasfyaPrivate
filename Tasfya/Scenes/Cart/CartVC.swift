//
//  CartVC.swift
//  Tasfya
//
//  Created by Amr on 08/09/2021.
//

import UIKit
import RealmSwift

class CartVC: BaseVC {
    
    var orders = [Product]()
    let realm = try! Realm()
    let realmServices = RealmServices.shared
    @IBOutlet weak var CartTableView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartTableView.delegate = self
        CartTableView.dataSource = self
        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()
    }
    override func viewWillAppear(_ animated: Bool) {
        getCustomerOrder()
    }
    func getCustomerOrder(){
        guard let currentCustomer = realm.object(ofType: Customer.self, forPrimaryKey: "rania")
        else{return}
       orders = realmServices.getAllProduct(currentCustomer)
        print(orders)
        CartTableView.reloadData()
        
        
    }
    func register() {
        CartTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        CartTableView.register(UINib(nibName: "ExploreCell", bundle: nil), forCellReuseIdentifier: "ExploreCell")
    }
    
    @IBAction func checkoutBtnTapped(_ sender: Any) {
      //  if CurrentUser.logged {
            self.navigationController?.pushViewController(FirstCheckOutVC(), animated: true)
       // } else {
       //     self.navigationController?.pushViewController(LoginSceneVC(), animated: true)
       // }
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
            let index = indexPath.row
            let data = orders[indexPath.row]
            cell.setupCellData(order: data)
            cell.countClicked = { [weak self] value in
                let currentCustomer = self?.realm.object(ofType: Customer.self, forPrimaryKey: "rania")
                self?.realmServices.updateProduct(customer: currentCustomer!, index: index, count: ("\(value)"))
            }
            
            cell.remove = { [weak self] in
                self?.CartTableView.performBatchUpdates({
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    self?.orders.remove(at: indexPath.row)
                    self?.realmServices.daleteProduct(data)
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
