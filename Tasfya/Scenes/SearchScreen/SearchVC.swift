//
//  SearchVC.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class SearchVC: BaseVC {
    
    var isSearching = false
    var searchData: [Datum]?
    
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
        self.navigationItem.setLeftBarButton(nil, animated: true)
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
        let languagehandler = LanguageHandler()
        let parameter = ["language_id": languagehandler.languageId]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getCategories(endPoint: "allCategories",parameter: parameter,  model: "allCategories")
        service.completionHandler{ [weak self](category, status, message) in
            
            if status {
                guard let  dataModel = category else {return}
                self?.categories = dataModel as? Categories
                self?.searchData = self?.categories?.data
            }
        }
    }
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let category = searchData?[indexPath.row]
        cell.configure(category: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ShopVC()
        guard let id = searchData?[indexPath.row].id else {return}
        vc.catId = id
        self.navigationController?.pushViewController(vc, animated: true)
        SearchTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filteredData = searchData?.filter{($0.name?.lowercased().contains(searchText.lowercased()))!}
        
        if self.searchBar.text?.isEmpty == true {
            self.searchData = self.categories?.data
            self.SearchTableView.reloadData()
        } else {
            searchData = filteredData
            self.SearchTableView.reloadData()
        }
    }
    
}
