//
//  MainScreenVC.swift
//  Tasfya
//
//  Created by Amr on 01/09/2021.
//

import UIKit

class MainScreenVC: UIViewController {
    
    var currentIndex: Int?
    
    var allProducts: AllProducts? {
        didSet {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    
    var baseUrl = "https://yousry.drayman.co/"
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        register()
    }
    
    func register() {
        mainCollectionView.register(UINib(nibName: "MainCVCell", bundle: nil), forCellWithReuseIdentifier: "MainCVCell")
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
    
}

extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProducts?.productData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        let products = allProducts?.productData?[indexPath.row]
        cell.brandNameLbl.text = products?.productsName
        cell.priceLbl.text = products?.productsPrice
        let url = "http://yousry.drayman.co/"
        let imageURL = products?.productsImage ?? ""
        let finalUrl = url + imageURL
        cell.productImage.showImage(url: finalUrl, cornerRadius: 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsVC()
        currentIndex = indexPath.row
        vc.currentIndex = currentIndex
        self.navigationController?.pushViewController(vc, animated: true)
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
