//
//  OrderDetailsVC.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import UIKit
import RealmSwift

class OrderDetailsVC: BaseVC {
    var total : Float = 0.0
    var addressData : AddressesData?
     var AllAddressModel : AllAddresses?
    let baseUrl = "http://yousry.drayman.co/"
    var showCoupon = false
    var product = [Product]()
    let realm = try! Realm()
    let realmServices = RealmServices.shared
    var shipingMethod : String?
    var customerId : Int?
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCustomerId()
        TableView.delegate = self
        TableView.dataSource = self
        self.navigationItem.setLeftBarButton(nil, animated: true)
        register()
    }
    override func viewWillAppear(_ animated: Bool) {
        getCustomerOrder()

    }
    func getCustomerOrder(){
        guard let currentCustomer = realm.object(ofType: Customer.self, forPrimaryKey: String("\(customerId)"))
        else{return}
       product = realmServices.getAllProduct(currentCustomer)
        calTotalPrice()
        self.TableView.reloadData()
    }
    
    
    
    
    func getCustomerId(){
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            customerId = Int(userdata.customersID)
        }
        callPostApi()
    }
    func calTotalPrice(){
        for item in product{
            total = total + Float("\(item.ProductPrice!)")!
        }
        print(total)
        
    }
    
    
    func callPostApi(){
        let parameter = ["customers_id": customerId]
        let service = Service.init(baseUrl: baseUrl)
        service.getAllAddresses(endPoint: "getAllAddress",parameter: parameter as [String : Any],  model: "AllAddresses")
        service.completionHandler{[weak self] (category, status, message) in
            if status {
                guard let  dataModel = category else {return}
                self?.AllAddressModel = dataModel as? AllAddresses
                print(self?.AllAddressModel ?? 0)
                self?.TableView.reloadData()
            }
        }
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
        self.navigationController?.pushViewController(EndOrderVC(), animated: true)
    }
    
}

extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return showCoupon ? 8 : 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return product.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath) as! BillingCell
            addressData = AllAddressModel?.data?[0]
            cell.addressLbl.text = addressData?.street ?? ""
            cell.cityLbl.text = addressData?.city
            cell.zoneLbl.text = addressData?.zoneCode
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath) as! BillingCell
            addressData = AllAddressModel?.data?[0]
            cell.addressLbl.text = addressData?.street ?? ""
            cell.cityLbl.text = addressData?.city
            cell.zoneLbl.text = addressData?.zoneCode
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillingCell", for: indexPath) as! BillingCell
            cell.cityLbl.text = shipingMethod
            cell.zoneLbl.isHidden = true
            cell.addressLbl.isHidden = true
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
            let data = product[indexPath.row]
            cell.setupCellData(order: data)
           
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtotalCell", for: indexPath) as! SubtotalCell
            
            cell.totalLbl.text = String("\(total)")
            return cell
            
        case 5:
            switch showCoupon {
            case true:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CoponeCell", for: indexPath) as! CoponeCell
                cell.applyBtn.isHidden = false
                cell.coponeTF.placeholder = "Copone Code"
                return cell
            case false:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
                return cell
            }
            
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
