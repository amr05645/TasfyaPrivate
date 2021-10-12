//
//  AllAddressesVC.swift
//  Tasfya
//
//  Created by BMS on 03/10/2021.
//

import UIKit

class AllAddressesVC: UIViewController {
    
    var customerId :Int?
    var notSelected = true
    var selectedIndex = 0

    let radioOn = #imageLiteral(resourceName: "radioOn")
    let radioOff = #imageLiteral(resourceName: "radioOff")
    
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
        getCustomerId()

    }
    
    

    
    func getCustomerId(){
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            customerId = Int(userdata.customersID)
        }
        callPostApi()

    }
    
    func registerTableView(){
        let nib = UINib(nibName: "AddressesCell", bundle: nil)
        addressesTableView.register(nib, forCellReuseIdentifier: "AddressesCell")
        addressesTableView.delegate = self
        addressesTableView.dataSource = self
        addressesTableView.allowsMultipleSelection = false
    }
    
    // call API to get All Addresses.....
    
    func callPostApi(){
        let parameter = ["customers_id": self.customerId]
        let service = Service.init(baseUrl: baseUrl)
        service.getAllAddresses(endPoint: "getAllAddress",parameter: parameter as [String : Any],  model: "AllAddresses")
        service.completionHandler{[weak self] (category, status, message) in
            if status {
                guard let  dataModel = category else {return}
                self?.AllAddressModel = dataModel as? AllAddresses
                print(self?.customerId)
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
  
        cell.selectAddress = { [weak self]  value in
            if value == true {
                self?.selectedIndex = indexPath.row
                self?.updateUserAddress(data: self!.AllAddressModel!.data![self!.selectedIndex])
             //   UserAddress.save(self!.AllAddressModel!.data![self!.selectedIndex])
                tableView.reloadData()
            }
        }
      
     if selectedIndex == indexPath.row{
        cell.radioButton.setImage(radioOn, for: .normal)
      
      }
        else{
            cell.radioButton.setImage(radioOff, for: .normal)
        }
        
          cell.configure(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.00
    }

    func updateUserAddress(data : AddressesData){
        let addressId = data.addressID
        let parameter = ["customers_id": customerId ?? "", "address_book_id" : addressId ?? ""] as [String : Any]
        let service = Service.init(baseUrl: baseUrl)
        service.updateDefaultAddress(endPoint: "updateDefaultAddress",parameter: parameter,  model: "UpdateAddress")
        service.completionHandler{[weak self] (category, status, message) in
            if status {
                guard let  dataModel = category else {return}
                print(dataModel ?? 0)
            }
        }
    }
    
    
    
    
    
    
}
