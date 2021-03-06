//
//  CategoriesVC.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class CategoriesVC: BaseVC {
    
    var categories: Categories?
    
    
    var baseUrl = "https://yousry.drayman.co/"
    
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
        var mainCategory = [Datum]() {
        didSet {
        DispatchQueue.main.async {
            self.CategoriesCollectionView.reloadData()
        }
    }
        }
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
        service.completionHandler{[weak self] (category, status, message) in
            
            if status {
                guard let  dataModel = category else {return}
                self?.categories = dataModel as? Categories
                self?.filterMainCategory()
            }
        }
    }
    func filterMainCategory(){
        guard let data = categories?.data else {return}
        for item in data {
            if  item.parentID == "0"
            {
                mainCategory.append(item)
            }
        }
        
    }
    
}

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        let category = mainCategory[indexPath.row]
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
        let vc = SubCategoryVC()
        guard let id = categories?.data?[indexPath.row].id else {return}
        vc.catId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
