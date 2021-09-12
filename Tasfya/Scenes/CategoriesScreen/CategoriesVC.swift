//
//  CategoriesVC.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class CategoriesVC: BaseVC {
    
    var categories: Categories? {
        didSet {
            DispatchQueue.main.async {
                self.CategoriesCollectionView.reloadData()
            }
        }
    }
    
    var baseUrl = "https://yousry.drayman.co/"
    
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        self.title = Constants.titles.categoris
        CategoriesCollectionView.delegate = self
        CategoriesCollectionView.dataSource = self
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()
    }
    
    func register() {
        CategoriesCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
    }
    
    func callPostApi() {
        let languagehandler = LanguageHandler()
        let parameter = ["language_id": languagehandler.languageId]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getCategories(endPoint: "allCategories",parameter: parameter,  model: "allCategories")
        service.completionHandler{ (category, status, message) in
            
            if status {
                guard let  dataModel = category else {return}
                self.categories = dataModel as? Categories
            }
        }
    }
    
}

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        let category = categories?.data?[indexPath.row]
        cell.categoryNameLbl.text = category?.name
        cell.productCountLbl.text = "\(String(describing: category!.totalProducts!)) products"
        let url = "http://yousry.drayman.co/"
        let imageURL = category?.image ?? ""
        let finalUrl = url + imageURL
        cell.categoryImg.showImage(url: finalUrl, cornerRadius: 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: (collectionViewSize/2), height: (collectionViewSize/2))
    }
}
