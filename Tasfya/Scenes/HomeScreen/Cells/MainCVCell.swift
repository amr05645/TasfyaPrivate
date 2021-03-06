//
//  MainCVCell.swift
//  Tasfya
//
//  Created by Amr on 31/08/2021.
//

import UIKit
import RealmSwift

class MainCVCell: UICollectionViewCell {
    var customerId : Int?
    let realmServices = RealmServices.shared
    let realm = try! Realm()
    var likesModel: LikesModel?
    var id: String?
    
    var baseUrl = "https://yousry.drayman.co/"
    
    let likedImg = #imageLiteral(resourceName: "likedPhoto")
    let unlikeImg = #imageLiteral(resourceName: "unlikePhoto")
    var notSelected = true
    var productData : ProductData?
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var brandNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(product: ProductData?){
        productData = product
           
        brandNameLbl.text = product?.productsName
        priceLbl.text = product?.productsPrice
        id = product?.productsID
        let url = "http://yousry.drayman.co/"
        let imageURL = product?.productsImage ?? ""
        let finalUrl = url + imageURL
        productImage.showImage(url: finalUrl, cornerRadius: 0)
        
        if product?.isLiked == "0" {
            likeBtn.setImage(unlikeImg, for: .normal)
        } else {
            likeBtn.setImage(likedImg, for: .normal)
        }
    }
    
    func callPostApi() {
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            customerId = Int(userdata.customersID)
        }
        
        guard let id = self.id else {return}
        let parameter = ["liked_product_id": id, "liked_customers_id": String("\(customerId)")]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getLikes(endPoint: "likeProduct",parameter: parameter,  model: "LikesModel")
        service.completionHandler{ [weak self](product, status, message) in
            
            if status {
                guard let  dataModel = product else {return}
                self?.likesModel = dataModel as? LikesModel
            }
        }
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        if notSelected {
            likeBtn.setImage(likedImg, for: .normal)
            callPostApi()
            
        } else {
            likeBtn.setImage(unlikeImg, for: .normal)
        }
        notSelected = !notSelected
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            customerId = Int(userdata.customersID)
        }
        
        if realmServices.checkCurrentCustomer(customerId: String("\(customerId)")) {
            guard let currentCustomer = realm.object(ofType: Customer.self, forPrimaryKey: String("\(customerId)"))
            else{return}
            let customerProduct = Product()
            customerProduct.ProductName = productData?.productsName ?? ""
            customerProduct.ProductIV = productData?.productsImage ?? ""
            customerProduct.categoryName = productData?.categoriesName ?? ""
            customerProduct.ProductPrice = productData?.productsPrice ?? ""
            customerProduct.ProductColor = ""
            customerProduct.ProductSize = ""
            customerProduct.ProductCount = ("\(1)")
           realmServices.addProduct(customer: currentCustomer, product: customerProduct)
            
        }
        else{
            
            let customerProduct = Product()
            customerProduct.ProductName = productData?.productsName ?? ""
            customerProduct.ProductIV = productData?.productsImage ?? ""
            customerProduct.categoryName = productData?.categoriesName ?? ""
            customerProduct.ProductPrice = productData?.productsPrice ?? ""
            customerProduct.ProductColor = ""
            customerProduct.ProductSize = ""
            realmServices.addNewCustomer(customerId: String("\(customerId)"))
            guard let currentCustomer = realm.object(ofType: Customer.self, forPrimaryKey: String("\(customerId)"))
            else{return}
          realmServices.addProduct(customer: currentCustomer, product: customerProduct)
        }
        
    }
    
}
