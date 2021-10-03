//
//  ProductDetailsVC.swift
//  Tasfya
//
//  Created by Amr on 07/09/2021.
//

import UIKit
import ImageSlideshow
import RealmSwift

class ProductDetailsVC: BaseVC {
    
    var productslug: String?
    let realmServices = RealmServices.shared
    let likedImg = #imageLiteral(resourceName: "likedPhoto")
    let unlikeImg = #imageLiteral(resourceName: "unlikePhoto")
    var notSelected = true
    let realm = try! Realm()
    var product: ProductData?
    var baseUrl = "https://yousry.drayman.co/"
    
    // get color and size
    var color : String?
    var size : String?
    
    @IBOutlet weak var productImagesSlider: ImageSlideshow!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var likedLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productStatusLbl: UILabel!
    @IBOutlet weak var productDescriptionLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: true)
        updateView()
      initializeRealm()
        self.setupImageSlider()
        getColorSize()

    }
    
    // func to get color and size of product
    
    func getColorSize(){
        let attribute = product?.attributes ?? []
        
        for item in attribute{
            if item.option?.name == "Colors"
            {
                color = item.values?[0].value
                
            }
            else if item.option?.name == "Size"{
                
                size = item.values?[0].value
            }
        }
        
    }
    
    func initializeRealm(){
        var config = realm.configuration
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    func updateView() {
        productNameLbl.text = product?.productsName
        categoryNameLbl.text = product?.categoriesName
        productDescriptionLbl.attributedText = product?.productsDescription?.htmlAttributedString()
        productPriceLbl.text = product?.productsPrice
        productStatusLbl.text = "\((product?.productsStatus) ?? "") in stock"
        likedLbl.text = "\((product?.isLiked) ?? "") likes"
    }
    
    func setupImageSlider() {
        let url = baseUrl
        var imagesSources: [KingfisherSource] = []
        guard let images = product?.images else {return}
        for image in images {
            let imageUrl = image.image ?? ""
            let finalUrl = url + imageUrl
            guard let completeLink = URL(string: finalUrl ) else {return}
            imagesSources.append(KingfisherSource(url: completeLink))
        }
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        productImagesSlider.pageIndicator = pageIndicator
        productImagesSlider.slideshowInterval = 2.5
        productImagesSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 0))
        productImagesSlider.activityIndicator = DefaultActivityIndicator()
        productImagesSlider.pageIndicator?.numberOfPages = imagesSources.count
        productImagesSlider.contentScaleMode = UIViewContentMode.scaleToFill
        productImagesSlider.setImageInputs(imagesSources)
        
    }
    
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        let textToShare = "Check out my app"
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let myWebsite = URL(string: "https://apps.apple.com/eg/app/endo/id1568290410") {
            
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "logoTasfya")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func likedBtnTapped(_ sender: Any) {
        if notSelected {
            likeBtn.setImage(likedImg, for: .normal)
        } else {
            likeBtn.setImage(unlikeImg, for: .normal)
        }
        notSelected = !notSelected
    }
    
    @IBAction func addToCartBtnTapped(_ sender: Any) {
        
        
        
        // check user already exist on data base or new user
        
        if realmServices.checkCurrentCustomer(customerId: "rania") {
            guard let currentCustomer = realm.object(ofType: Customer.self, forPrimaryKey: "rania")
            else{return}
            let customerProduct = Product()
            customerProduct.ProductName = product?.productsName ?? ""
            customerProduct.ProductIV = product?.productsImage ?? ""
            customerProduct.categoryName = product?.categoriesName ?? ""
            customerProduct.ProductPrice = product?.productsPrice ?? ""
            customerProduct.ProductCount = ("\(1)")
            customerProduct.ProductColor = self.color
            customerProduct.ProductSize = self.size
           realmServices.addProduct(customer: currentCustomer, product: customerProduct)
            
        }
        else{
            let customerProduct = Product()
            customerProduct.ProductName = product?.productsName ?? ""
            customerProduct.ProductIV = product?.productsImage ?? ""
            customerProduct.categoryName = product?.categoriesName ?? ""
            customerProduct.ProductPrice = product?.productsPrice ?? ""
            customerProduct.ProductColor = self.color
            customerProduct.ProductSize = self.size
            realmServices.addNewCustomer(customerId: "rania")
            guard let currentCustomer = realm.object(ofType: Customer.self, forPrimaryKey: "rania")
            else{return}
             try! realm.write{
             currentCustomer.customerData.append(customerProduct)
             }
//            realmServices.addProduct(customer: currentCustomer, product: customerProduct)
            print(customerProduct.ProductName)
        }
    }
    
}
