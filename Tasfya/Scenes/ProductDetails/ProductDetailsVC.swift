//
//  ProductDetailsVC.swift
//  Tasfya
//
//  Created by Amr on 07/09/2021.
//

import UIKit
import ImageSlideshow

class ProductDetailsVC: BaseVC {
    
    var allProducts: AllProducts? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
                self.setupImageSlider()
            }
        }
    }
    
    var currentIndex: Int?
    
    var productslug: String?
    
    let likedImg = #imageLiteral(resourceName: "likedPhoto")
    let unlikeImg = #imageLiteral(resourceName: "unlikePhoto")
    var notSelected = true
    
    var baseUrl = "https://yousry.drayman.co/"
    
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
        callPostApi()
    }
    
    func updateView() {
        productNameLbl.text = allProducts?.productData?[currentIndex ?? 0].productsName
        categoryNameLbl.text = allProducts?.productData?[currentIndex ?? 0].categoriesName
        productDescriptionLbl.text = allProducts?.productData?[currentIndex ?? 0].productsDescription
        productPriceLbl.text = allProducts?.productData?[currentIndex ?? 0].productsPrice
        productStatusLbl.text = "\((allProducts?.productData?[currentIndex ?? 0].productsStatus) ?? "") in stock"
        likedLbl.text = "\((allProducts?.productData?[currentIndex ?? 0].isLiked) ?? "") likes"
    }
    
    func callPostApi() {
        let languagehandler = LanguageHandler()
        
        let parameter = ["language_id": languagehandler.languageId, "page_number": 0]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getProducts(endPoint: "getAllProducts",parameter: parameter,  model: "getAllProducts")
        service.completionHandler{ (products, status, message) in
            
            if status {
                guard let  dataModel = products else {return}
                self.allProducts = dataModel as? AllProducts
            }
        }
    }
    
    func setupImageSlider() {
        let url = baseUrl
        var imagesSources: [KingfisherSource] = []
        guard let data = allProducts?.productData else {return}
        guard let images = data[currentIndex ?? 0].images else {return}
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
        productImagesSlider.delegate = self
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
    }
    
}

extension ProductDetailsVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
