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
