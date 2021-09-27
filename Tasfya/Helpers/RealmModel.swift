//
//  RealmModel.swift
//  Tasfya
//
//  Created by BMS on 20/09/2021.
//


import Foundation
import RealmSwift

class Product : Object {
    
    //@objc  dynamic var ProductId : String?
    @objc  dynamic var ProductIV : String?
    @objc  dynamic var ProductName : String?
    @objc  dynamic var categoryName : String?
    @objc  dynamic var ProductPrice : String?
    @objc  dynamic var ProductSize : String?
    @objc  dynamic var ProductColor : String?
//    @objc  dynamic var ProductCount : String?
//    
//    override class func primaryKey() -> String? {
//        return "ProductId"
//    }
}
 
class Customer: Object{
    @objc dynamic var  CustomerId = UUID().uuidString
     let customerData = List<Product>()
    override class func primaryKey() -> String? {
        return "CustomerId"
    }
}

