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
    
    func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func callPostApi(){
        let url = URL(string: "http://yousry.drayman.co/allCategories")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let parameters = getPostString(params: ["language_id":1])
        request.httpBody = parameters.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data {
                do {
                    let parsedCat = try JSONDecoder().decode(Categories.self, from: data)
                    self.categories = parsedCat
                }
                catch let jsonError
                {
                    print("error serializing json", jsonError)
                }
            }
        }
        task.resume()
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
