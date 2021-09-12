//
//  OrderDetailsVC.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import UIKit

class OrderDetailsVC: BaseVC {
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        self.navigationItem.setLeftBarButton(nil, animated: true)
        register()
    }
    
    func register() {
        TableView.register(UINib(nibName: "BillingCell", bundle: nil), forCellReuseIdentifier: "BillingCell")
        TableView.register(UINib(nibName: "ProductsCell", bundle: nil), forCellReuseIdentifier: "ProductsCell")
        TableView.register(UINib(nibName: "SubtotalCell", bundle: nil), forCellReuseIdentifier: "SubtotalCell")
        TableView.register(UINib(nibName: "CoponeCell", bundle: nil), forCellReuseIdentifier: "CoponeCell")
        TableView.register(UINib(nibName: "PaymentMethodCell", bundle: nil), forCellReuseIdentifier: "PaymentMethodCell")
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func orderNowTapped(_ sender: Any) {
        
    }
    
}

extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath) as! BillingCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath) as! BillingCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath) as! BillingCell
            cell.zoneLbl.isHidden = true
            cell.addressLbl.isHidden = true
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtotalCell", for: indexPath) as! SubtotalCell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoponeCell", for: indexPath) as! CoponeCell
            cell.applyBtn.isHidden = false
            cell.coponeTF.placeholder = "Copone Code"
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoponeCell", for: indexPath) as! CoponeCell
            cell.applyBtn.isHidden = true
            cell.coponeTF.placeholder = "order notes"
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 40
        case 3:
            return 160
        case 4:
            return 160
        case 5:
            return 50
        case 6:
            return 50
        case 7:
            return 40
        default:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = SectionHeader()
        view.backgroundColor = .lightGray
        
        switch section {
        case 0:
            view.label.text = "Billing Address"
        case 1:
            view.label.text = "Shipping Address"
        case 2:
            view.label.text = "Shipping Method"
        case 3:
            view.label.text = "Products"
        case 4:
            view.label.text = "SubTotal"
        case 5:
            view.isHidden = true
        case 6:
            view.label.text = "Order Notes"
            view.button.isHidden = true
        case 7:
            view.isHidden = true
        default:
            break
        }
        return view
    }
    
}
