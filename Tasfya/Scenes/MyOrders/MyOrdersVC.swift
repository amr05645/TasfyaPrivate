//
//  MyOrdersVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class MyOrdersVC: BaseVC {
    
    @IBOutlet weak var OrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderTableView.delegate = self
        OrderTableView.dataSource = self
        register()
    }
    
    func register() {
        OrderTableView.register(UINib(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
    }
    
}

extension MyOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as! OrdersCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OrderTableView.deselectRow(at: indexPath, animated: true)
        print("selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
