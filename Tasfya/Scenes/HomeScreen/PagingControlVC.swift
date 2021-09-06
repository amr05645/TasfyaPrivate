//
//  PagingControl.swift
//  Tasfya
//
//  Created by Amr on 01/09/2021.
//

import UIKit
import Parchment

class PagingControlVC: UIViewController {
    
    let pagingViewController = PagingViewController()
    
    var categories: Categories? {
        didSet {
            DispatchQueue.main.async {
                self.pagingViewController.reloadData()
            }
        }
    }
    
    var baseUrl = "https://yousry.drayman.co/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        pagingViewController.dataSource = self
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.textColor = .darkGray
        pagingViewController.selectedTextColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
        pagingViewController.indicatorColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        pagingViewController.menuItemSize = .selfSizing(estimatedWidth: self.view.bounds.width / 4, height: 30)
    }
    
    func callPostApi() {
        let parameter = ["language_id": 1]
        
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

extension PagingControlVC: PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return categories?.data?.count ?? 0
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let viewController = MainScreenVC()
        let cat = categories?.data?[index]
        viewController.category = cat
        return viewController
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let category = categories!.data![index]
        return PagingIndexItem(index: index, title: category.name ?? "")
    }
}
