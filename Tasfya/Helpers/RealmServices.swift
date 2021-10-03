//
//  RealmServices.swift
//  Tasfya
//
//  Created by BMS on 20/09/2021.
//

import RealmSwift
class RealmServices {
    
    static let shared = RealmServices()
       init() {
         }
    
    func addNewCustomer(customerId : String){
        
        let realm = try! Realm()
        let customer = Customer()
        customer.CustomerId = customerId
        try! realm.write{
            realm.add(customer)
        }
   //     addCart(user: user)

    }
    func addProducts(customer : Customer, data: [Product]){
        for item in data {
       let realm = try! Realm()
        try! realm.write{
            customer.customerData.append(item)
        }
        }
    }
    
    func addProduct( customer : Customer, product: Product){
       let realm = try! Realm()
        try! realm.write{
            customer.customerData.append(product)
        }
    }
    
    //method to update product
    
    func updateProduct( customer : Customer , index : Int, count: String){
        let realm = try! Realm()
      try! realm.write{
        customer.customerData[index].ProductCount = count
        }
    }
    
    func checkCurrentCustomer(customerId : String) -> Bool {
        let realm = try! Realm()
        guard realm.object(ofType: Customer.self, forPrimaryKey: customerId) != nil
        else{return false}
        return true
    }
   
    
    func getAllProduct( _ customer : Customer) -> [Product]{
        let data = customer.customerData
        return data.map({$0})
    }
    
    func  daleteProduct(_ product  : Product) {
        let realm = try! Realm()
        try! realm.write{
            realm.delete(product)
        }
    }
    
    func clearCustomerData(_ customer : Customer){
        
        let realm = try! Realm()
        let data = customer.customerData
        for item in data {
            try! realm.write{
                realm.delete(item)
            }
        }
    }

}
