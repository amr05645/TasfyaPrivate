//
//  AllAddressesVC.swift
//  Tasfya
//
//  Created by BMS on 03/10/2021.
//

import UIKit

class AllAddressesVC: UIViewController {
    var AllAddressModel : AllAddresses? {
        didSet {
            DispatchQueue.main.async {
                self.addressesTableView.reloadData()
            }
        }
    }
    let baseUrl = "http://yousry.drayman.co/"
    @IBOutlet weak var addressesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        callPostApi()
    }
    
    func registerTableView(){
        let nib = UINib(nibName: "AddressesCell", bundle: nil)
        addressesTableView.register(nib, forCellReuseIdentifier: "AddressesCell")
        addressesTableView.delegate = self
        addressesTableView.dataSource = self
    }
    
    // call API to get All Addresses.....
    
    func callPostApi(){
        let parameter = ["customers_id": 3]
        let service = Service.init(baseUrl: baseUrl)
        service.getAllAddresses(endPoint: "getAllAddress",parameter: parameter,  model: "AllAddresses")
        service.completionHandler{[weak self] (category, status, message) in
            if status {
                guard let  dataModel = category else {return}
                self?.AllAddressModel = dataModel as? AllAddresses
                print(self?.AllAddressModel ?? 0)
            }
        }
    }
}


extension AllAddressesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllAddressModel?.data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressesCell", for: indexPath) as! AddressesCell
        
     let data = AllAddressModel?.data?[indexPath.row] 
        

          cell.configure(data: data)
  //      cell.customerFullName.text = "\((data?.firstname ?? "") + (data?.lastname ?? ""))"
  //      cell.customerAddresses.text = data?.defaultAddress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.00
    }
    
    
}
