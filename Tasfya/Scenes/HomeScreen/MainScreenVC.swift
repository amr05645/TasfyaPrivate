//
//  MainScreenVC.swift
//  Tasfya
//
//  Created by Amr on 01/09/2021.
//

import UIKit

class MainScreenVC: UIViewController {
    
    var allProducts: AllProducts?
    
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
    
    func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func callPostApi(){
        let url = URL(string: "http://yousry.drayman.co/getAllProducts")
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
                    let parsedCat = try JSONDecoder().decode(AllProducts.self, from: data)
                    self.allProducts = parsedCat
                }
                catch let jsonError
                {
                    print("error serializing json", jsonError)
                }
            }
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
        task.resume()
    }
    
}

extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProducts?.productData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        let products = allProducts?.productData?[indexPath.row]
        cell.brandNameLbl.text = products?.productsName
        cell.priceLbl.text = products?.productsPrice
        let url = "http://yousry.drayman.co/"
        let imageURL = products?.productsImage ?? ""
        let finalUrl = url + imageURL
        cell.productImage.showImage(url: finalUrl, cornerRadius: 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected")
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
}
