//
//  OrderDetailsVC.swift
//  Tasfya
//
//  Created by Elsaadany on 13/04/2021.
//

import UIKit

class OrderDetailsVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: OrderDetailsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OrderDetailsCell.reuseIdentifier)
    }

}

extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailsCell.reuseIdentifier, for: indexPath) as! OrderDetailsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
