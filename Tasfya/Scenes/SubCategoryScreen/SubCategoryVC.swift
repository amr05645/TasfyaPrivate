//
//  SubCategoryVC.swift
//  Tasfya
//
//  Created by BMS on 13/10/2021.
//

import UIKit

class SubCategoryVC: UIViewController {

    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    var catId: String?
    var categories: Categories?
    var subCategory = [Datum](){
    didSet {
    DispatchQueue.main.async {
        self.subCategoryCollectionView.reloadData()
    }
}
    }
    var baseUrl = "https://yousry.drayman.co/"
    
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        self.title = Constants.titles.categoris
        subCategoryCollectionView.delegate = self
        subCategoryCollectionView.dataSource = self
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()
    }
    
    func register() {
        subCategoryCollectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
    }
    // filtr to get 
    func callPostApi() {
        let languagehandler = LanguageHandler()
        let parameter = ["language_id": languagehandler.languageId]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getCategories(endPoint: "allCategories",parameter: parameter,  model: "allCategories")
        service.completionHandler{[weak self] (category, status, message) in
            
            if status {
                guard let  dataModel = category else {return}
                self?.categories = dataModel as? Categories
                self?.filterSubCategory()
            }
        }
    }
    
    
    func filterSubCategory(){
        guard let data = categories?.data else {return}
        for item in data {
            if  catId == item.parentID
            {
                subCategory.append(item)
            }
        }
    }
}

extension SubCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategory.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        let category = subCategory[indexPath.row]
        cell.configure(category: category)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let vc = ShopVC()
       guard let id = categories?.data?[indexPath.row].id else {return}
        vc.catId = id
       self.navigationController?.pushViewController(vc, animated: true)
        print("hello")
    }
}
