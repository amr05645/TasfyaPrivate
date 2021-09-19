//
//  ProductDetailsVC.swift
//  Tasfya
//
//  Created by Amr on 07/09/2021.
//

import UIKit
import ImageSlideshow

class ProductDetailsVC: BaseVC {
    
    var productslug: String?
    
    let likedImg = #imageLiteral(resourceName: "likedPhoto")
    let unlikeImg = #imageLiteral(resourceName: "unlikePhoto")
    var notSelected = true
    
    var product: ProductData?
    
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
        updateView()
        self.setupImageSlider()
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
    }
    
}