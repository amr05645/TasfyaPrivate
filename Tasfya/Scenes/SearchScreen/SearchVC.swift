//
//  SearchVC.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    var categories: Categories?
    
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
            DispatchQueue.main.async {
                self.SearchTableView.reloadData()
            }
        }
        task.resume()
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
