//
//  MainScreenVC.swift
//  Tasfya
//
//  Created by Amr on 01/09/2021.
//

import UIKit

enum ScrollDirection {
    case up
    case down
}

protocol MainScreenVCDelegate {
    func didScroll(to direction: ScrollDirection)
}

class MainScreenVC: UIViewController {
    
    var currentIndex: Int?
    private var lastContentOffset: CGFloat = 0
    var delegate: MainScreenVCDelegate?
    var isPageRefreshing = false
    var page = 0
    
    var allProducts: AllProducts? {
        didSet {
            guard let products = self.allProducts?.productData else {return}
            self.products.append(contentsOf: products)
        }
    }
    
    var products = [ProductData]() {
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
    
    func callPostApi(page: Int = 0) {
        let languagehandler = LanguageHandler()
        
        let parameter = ["language_id": languagehandler.languageId, "page_number": page]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getProducts(endPoint: "getAllProducts",parameter: parameter,  model: "getAllProducts")
        service.completionHandler{[weak self] (products, status, message) in
            self?.isPageRefreshing = false
            
            if status {
                guard let  dataModel = products else {return}
                self?.allProducts = dataModel as? AllProducts
            }
        }
    }
    
}

extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        let product = products[indexPath.row]
        cell.configure(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsVC()
        currentIndex = indexPath.row
        vc.product = products[indexPath.row]
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(self.mainCollectionView.contentOffset.y >= (self.mainCollectionView.contentSize.height - self.mainCollectionView.bounds.size.height)) {
            
            if !isPageRefreshing {
                isPageRefreshing = true
                page += 1
                callPostApi(page: page)
            }
        }
        
        if self.lastContentOffset > scrollView.contentOffset.y && scrollView.contentOffset.y < 0 {
            // move down
            self.delegate?.didScroll(to: .down)
        } else if self.lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            // move up
            self.delegate?.didScroll(to: .up)
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
}
