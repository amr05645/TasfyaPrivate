//
//  SearchVC.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    var categories: Categories? {
        didSet {
            DispatchQueue.main.async {
                self.SearchTableView.reloadData()
            }
        }
    }
    
    var baseUrl = "https://yousry.drayman.co/"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        SearchTableView.delegate = self
        SearchTableView.dataSource = self
        searchBar.delegate = self
        register()
    }
    
    func register() {
        SearchTableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
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

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let category = categories?.data?[indexPath.row]
        cell.categoryNameLbl.text = category?.name
        let url = "http://yousry.drayman.co/"
        let imageURL = category?.icon ?? ""
        let finalUrl = url + imageURL
        cell.categoryIconImage.showImage(url: finalUrl, cornerRadius: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SearchTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
}
