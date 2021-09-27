//
//  MyFavoritesVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class MyFavoritesVC: BaseVC {
    
    @IBOutlet weak var MyFavoritesCollectionView: UICollectionView!
    var baseUrl = "https://yousry.drayman.co/"
    var isPageRefreshing = false
    var currentIndex: Int = 0
    var filterData = [ProductData]()
    var allProducts: AllProducts? {
        didSet {
            guard let products = self.allProducts?.productData else {return}
            self.products.append(contentsOf: products)
        }
    }

    var products = [ProductData]() {
        didSet {
            DispatchQueue.main.async {
                self.MyFavoritesCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         callPostApi()
        MyFavoritesCollectionView.delegate = self
        MyFavoritesCollectionView.dataSource = self
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()
    }
   
    
   
//    
//    func getFavouriteData(){
//        guard let data = loginModel?.data[0].likedProducts else{return}
//        for loginItem in data
//        {
//          guard let productData = allProducts?.productData else{return}
//            for productItem in productData
//            {
//                if loginItem.productsID == productItem.productsID!{
//                    filterData.append(productItem)
//                }
//            }
//        }
//        print(filterData)
//        self.MyFavoritesCollectionView.reloadData()
//    }

    
    
    func callPostApi() {
        let languagehandler = LanguageHandler()
        let parameter = ["language_id": languagehandler.languageId, "page_number": currentIndex]
        let service = Service.init(baseUrl: baseUrl)
        service.getProducts(endPoint: "getAllProducts",parameter: parameter,  model: "getAllProducts")
        service.completionHandler{[weak self] (products, status, message) in
         self?.isPageRefreshing = true

            if status {
                guard let  dataModel = products else {return}
                self?.allProducts = dataModel as? AllProducts

              self?.currentIndex+=1
              self?.isPageRefreshing = false
            }

        }
    }

    
    
    func register() {
        MyFavoritesCollectionView.register(UINib(nibName: "MainCVCell", bundle: nil), forCellWithReuseIdentifier: "MainCVCell")
    }
    
}
extension MyFavoritesVC : UICollectionViewDataSourcePrefetching{

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for index in indexPaths {
            if index.row  >= products.count - 3 && !isPageRefreshing{
                callPostApi()
                break
            }
        }

    }
}
extension MyFavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        cell.configure(product: filterData[indexPath.row])
        cell.likeBtn.setImage(#imageLiteral(resourceName: "likedPhoto"), for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: (collectionViewSize/2) + 80)
    }
    
}
