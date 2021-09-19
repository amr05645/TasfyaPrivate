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
    var delegate: MainScreenVCDelegate?
    var catId: String?
    
    var titles = ["All"]
    
    var categories: Categories? {
        didSet {
            DispatchQueue.main.async {
                guard let titles = self.categories?.data?.compactMap({$0.name}) else {return}
                self.titles.append(contentsOf: titles)
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
    
    func showCategory(of id: String?) {
        let index = categories?.data?.firstIndex(where: {$0.id == id}) ?? 0
        pagingViewController.select(index: index+1, animated: false)
    }
    
    func callPostApi() {
        let languagehandler = LanguageHandler()
        
        let parameter = ["language_id": languagehandler.languageId]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getCategories(endPoint: "allCategories",parameter: parameter,  model: "allCategories")
        service.completionHandler{ [weak self](category, status, message) in
            
            if status {
                guard let  dataModel = category else {return}
                self?.categories = dataModel as? Categories
                if let id = self?.catId {
                    DispatchQueue.main.async {
                        self?.showCategory(of: id)
                    }
                }
            }
        }
    }
    
}

extension PagingControlVC: PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return titles.count
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let viewController = MainScreenVC()
        viewController.delegate = self.delegate
        return viewController
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let title = titles[index]
        return PagingIndexItem(index: index, title: title)
    }
}
